{
  nix-config.apps.init = {
    enable = true;
    home = {
      home.stateVersion = "23.05";
      programs.home-manager.enable = true;
    };
  };

  nix-config.defaultTags = {
    # desktop && guis 
    xmonad = false;
    hyprland = false;
    gnome = false;
    login = false;
    terminal = false;
    browser = false;
    rofi = false;

    virt = false;
    # shared
    essentials = true;

    # shared
    tools = true;
  };

  nix-config.homeApps = [ ];
}
