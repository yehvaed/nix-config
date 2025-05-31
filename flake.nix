{
  description = "My dotfiles, powered by Nix. ❄️";

  inputs = {
    # utils
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-config-modules.url = "github:chadac/nix-config-modules";

    # wsl specfic 
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # apps
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { flake-parts, ... }@inputs:
    let
      inherit (builtins)
        match pathExists filter readDir attrNames baseNameOf map;

      canImport = path:
        let entry = baseNameOf path;
        in match ".*\\.nix$" entry != null
        || pathExists (path + "/default.nix");

      importAll = dir:
        filter canImport
        (map (entry: dir + "/${entry}") (attrNames (readDir dir)));

      flakeModule = {
        imports = [ inputs.nix-config-modules.flakeModule ]
          ++ (importAll ./apps) ++ (importAll ./hosts);

        systems = [ ];
      };
    in (flake-parts.lib.mkFlake { inherit inputs; } flakeModule) // {
      inherit flakeModule;
    };
}
