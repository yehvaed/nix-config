{ ... }:
let inherit (builtins) readFile;
in {
  nix-config.apps.nvim = {
    home = { pkgs, ... }: {
      programs.tmux = {
        plugins = with pkgs.tmuxPlugins; [ battery ];

        extraConfig = readFile (./tmux.conf);
        terminal = "screen-256color";
        enable = true;
      };

      programs.fzf = { enable = true; };
    };

    tags = [ "tools" ];
  };
}
