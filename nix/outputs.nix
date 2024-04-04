inputs@{ flake-parts, ... }:

let
  flakeModule = {
    imports = [ 
      #: ==> modules to load
      inputs.nix-config-modules.flakeModule 
      
      # ==> apps configs
      ./apps/clis/nvim
      ./apps/clis/tmux
      ./apps/clis/zsh
      ./apps/clis/git.nix

      ./apps/guis/alacritty
      ./apps/guis/gnome
      
      ./apps/docker.nix
      ./apps/fonts.nix
      ./apps/sudo.nix

      ./apps/init.nix

      # ==> host configs
      ./hosts/devbox
      ./hosts/wsl
    ];

    systems = [ ];

    nix-config.modules.nixos = [ inputs.nixos-wsl.nixosModules.wsl ];
    nix-config.modules.home-manager = [ inputs.ags.homeManagerModules.default ];
  };

in (flake-parts.lib.mkFlake { inherit inputs; } flakeModule) // {
  inherit flakeModule;
}
