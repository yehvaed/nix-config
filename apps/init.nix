{
  nix-config.apps.init = {
    home = {
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
    enable = true;
  };

  nix-config.defaultTags = {
    default = true;
    dev = false;
    virt = false;
    gui = false;
  };

  nix-config.homeApps = [ ];
}
