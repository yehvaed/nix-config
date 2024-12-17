{
  nix-config.apps.init = {
    home = {
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
    enable = true;
  };

  nix-config.homeApps = [ ];
}
