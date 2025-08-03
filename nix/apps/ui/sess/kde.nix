{
  nix-config.apps.kde = {
    nixos = {
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;
      };
    };

    tags = [ "sess" ]; 
  };
}
