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

  outputs =
    { flake-parts, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      autoload = import ./nix/autoload.nix { inherit lib inputs nixpkgs; };

      # perSystem definition separated for clarity
      perSystem =
        { pkgs, system, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "nix-config";
            buildInputs = [
              pkgs.nixfmt-rfc-style
              pkgs.gnumake
            ];
            shellHook = ''
              echo "🛠️ Welcome to the nix-config on ${system}"
            '';
          };
        };

      flakeBody = {
        systems = [ "x86_64-linux" ];

        imports = [ inputs.nix-config-modules.flakeModule ] ++ autoload.importPaths;

        nix-config.homeApps = [ ];
        nix-config.defaultTags = autoload.tags;

        inherit perSystem;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } flakeBody;
}
