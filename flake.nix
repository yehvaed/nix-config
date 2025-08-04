{
  description = "Fully modular. Infinitely replicable. Slightly overengineered – powered by Nix. ❄️";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-config-modules.url = "github:chadac/nix-config-modules";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { flake-parts, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      # Import a .nix file, calling it if it's a function
      importNixFile = path:
        let
          raw = import path;
        in if lib.isFunction raw
           then raw { inherit inputs; lib = nixpkgs.lib; pkgs = nixpkgs; modulesPath = ""; config = {}; }
           else raw;

      # Check if a file's content has nix-config apps or hosts
      hasNixConfig = content:
        lib.hasAttrByPath [ "nix-config" "apps" ] content
        || lib.hasAttrByPath [ "nix-config" "hosts" ] content;

      # Discover nix-config files recursively in a directory
      discoverConfigs = dir:
        lib.flatten (lib.mapAttrsToList (name: type:
          let
            fullPath = "${dir}/${name}";
          in
          if type == "directory" then
            discoverConfigs fullPath
          else if lib.hasSuffix ".nix" name then
            let
              content = importNixFile fullPath;
              configPath = if name == "default.nix" && hasNixConfig content then dir else fullPath;
            in if hasNixConfig content
               then [ { path = configPath; content = content; } ]
               else []
          else []
        ) (builtins.readDir dir));

      foundConfigs = discoverConfigs ./nix;

      importPaths = map (c: c.path) foundConfigs;

      # Extract all host names from the discovered configs
      hostNames = lib.concatMap (c: lib.attrNames (c.content.nix-config.hosts or {})) foundConfigs;

      # Collect all unique tags from all apps in all configs
      tags = lib.genAttrs
        (lib.unique (lib.concatMap (conf:
          lib.concatLists (lib.mapAttrsToList (_: app: app.tags or []) (conf.content.nix-config.apps or {}))
        ) foundConfigs))
        (_: false);

    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ inputs.nix-config-modules.flakeModule ] ++ importPaths;

      nix-config.homeApps = [];
      nix-config.defaultTags = tags;

      perSystem = { pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          name = "nix-config";
          buildInputs = [ pkgs.nixpkgs-fmt ];
          shellHook = ''
            echo "🛠️ Welcome to the nix-config on ${system}"
          '';
        };
      };
    };
}
