{ ... }:
let inherit (builtins) readFile;
in {
  nix-config.apps.gnome = {
    nixos = { pkgs, ... }: {
      services = {
        xserver = {
          enable = true;
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;
        };
      };

      environment.systemPackages = with pkgs; [ whitesur-gtk-theme ];
    };
    tags = [ "gnome" ];
  };
}
