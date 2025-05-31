{ inputs, ... }: {
  nix-config.apps.ags = {
    home = { pkgs, ... }: {
      programs.ags = {
        configDir = ./config;
        extraPackages = with pkgs; [
          inputs.ags.packages.${pkgs.system}.hyprland
          inputs.ags.packages.${pkgs.system}.battery
          inputs.ags.packages.${pkgs.system}.mpris
          inputs.ags.packages.${pkgs.system}.network
          inputs.ags.packages.${pkgs.system}.tray
          inputs.ags.packages.${pkgs.system}.wireplumber
          adwaita-icon-theme
          gnome-icon-theme
        ];

        systemd.enable = true;

        enable = true;
      };

    };

    tags = [ "default" ];
  };

  nix-config = {
    modules.home-manager = [ inputs.ags.homeManagerModules.default ];
  };
}
