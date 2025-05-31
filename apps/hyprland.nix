{
  nix-config.apps.hyprland = {
    home = { pkgs, ... }: {
      wayland.windowManager.hyprland = {
        settings = {
          bind = [ "$mod, Return, exec, kitty" ];

          bindm = [
            # mouse movements
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];

          monitor = [ "eDP-1, 1920x1080@144, 0x0, 1" ];

          "$mod" = "SUPER";

          misc = {
            force_default_wallpaper = 1;
            disable_hyprland_logo = false;
          };
        };

        enable = true;
      };

      programs.kitty.enable = true;
    };

    nixos = { pkgs, ... }: { programs.hyprland.enable = true; };

    tags = [ "gui" ];
  };
}
