{ lib, ... }: 
let
  inherit (builtins) readDir concatStringsSep;
  inherit (lib) attrNames;
in {
  nix-config.apps.hyprland = {
    home = { pkgs, ... }: {
      wayland.windowManager.hyprland = {
        extraConfig = concatStringsSep "\n" ( 
          map (file: import (./config + "/${file}") { inherit pkgs; }) (attrNames (readDir ./config ))
        );

        enable = true;
      };

      programs.kitty.enable = true;
    };

    nixos = {
      programs.hyprland.enable = true;
    };

    tags = [ "hyprland" ];
  };
}
