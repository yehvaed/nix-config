{ load, ... }: {
  nix-config.apps.zsh = {
    home = { pkgs, ... }: {
      programs.zsh = {
        plugins =
          load (with pkgs; [ zsh-fzf-tab zsh-fzf-history-search zsh-f-sy-h ]);

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };

        initExtra = /* sh */''
          [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
        '';

        shellAliases = { cat = "bat"; };

        enable = true;
      };

      programs.fzf = { enable = true; };

      programs.eza = {
        enableZshIntegration = true;
        enable = true;
      };

      programs.bat = { enable = true; };
    };

    tags = [ "zsh" ];
  };

  nix-config.defaultTags = { zsh = true; };
}
