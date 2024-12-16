{ ... }: {
  nix-config.apps.tmux = {
    home = { pkgs, ... }@inputs: {
      programs.tmux = {
        plugins = with pkgs.tmuxPlugins; [ battery ];

        extraConfig = import ./config/init.tmux.nix inputs;

        terminal = "tmux-256color";
        historyLimit = 100000;

        enable = true;
      };
    };

    tags = [ "tmux" ];
  };

  nix-config.defaultTags = { tmux = true; };

}
