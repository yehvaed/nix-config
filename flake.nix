{
  description = "Fully modular. infinitely replicable. slightly overengineered - powered by Nix. ❄️";

  outputs = { flake-parts, ... }@inputs:
    let
      perSystem = { pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          name = "nix-config";
          buildInputs = with pkgs; [
            nixpkgs-fmt
          ];
          shellHook = ''
            echo "🛠️  Welcome to the nix-config on ${system}"
          '';
        };
      };

      flakeModule = {

        imports = [ 
          inputs.nix-config-modules.flakeModule
          # clis
          # --------
          ./nix/apps/cli/cntr/distrobox.nix
          ./nix/apps/cli/cntr/podman.nix

          ./nix/apps/cli/nix/nh.nix
          ./nix/apps/cli/nix/nix-index.nix
      
          ./nix/apps/cli/nix/nh.nix
          ./nix/apps/cli/nix/nix-index.nix

          ./nix/apps/cli/scm/gh.nix
          ./nix/apps/cli/scm/git.nix

          ./nix/apps/cli/tl/eza.nix
          ./nix/apps/cli/tl/fd.nix
          ./nix/apps/cli/tl/fzf.nix
          ./nix/apps/cli/tl/ripgrep.nix

          # guis
          # --------

          # hw
          # --------
          
          # srv
          # --------

          # host
          # --------
          ./nix/hosts/mthrshp
        ];

        nix-config.homeApps = [ ];

        inherit perSystem;
        systems = [ "x86_64-linux" ]; 
      };
    in flake-parts.lib.mkFlake { inherit inputs; } flakeModule;

  inputs = {
    # nix
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-config-modules.url = "github:chadac/nix-config-modules";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # wsl 
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
}
