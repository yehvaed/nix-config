{ ... }: {
  nix-config.apps.init = {
    home = {
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
    enable = true;
  };

  nix-config.defaultTags = {
    nvim = true;
    hyprland = true;
    greetd = true;
    zsh = true;
    tmux = true;
    fonts = true;
    sudo = true;
    nh = true;
    kitty = true;
    firefox = true;
    eza = true;
    gh = true;
    devbox = true;
  };

  nix-config.homeApps = [];
}
