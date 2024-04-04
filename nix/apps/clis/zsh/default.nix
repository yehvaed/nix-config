{ lib, ... }:
let
  inherit (builtins) readFile;

  withConfigFile = plugin: initFile: {
    name = plugin.pname;
    src = plugin;
    file = initFile;
  };

in {
  nix-config.apps.zsh = {
    home = { pkgs, ... }: {
      programs.zsh = {
        plugins = with pkgs; [
          # command line
          (withConfigFile zsh-f-sy-h
            "share/zsh/site-functions/F-Sy-H.plugin.zsh")
          (withConfigFile zsh-vi-mode
            "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh")

          # pickers
          (withConfigFile zsh-fzf-tab "share/fzf-tab/fzf-tab.plugin.zsh")

          # misc
          (withConfigFile zsh-you-should-use
            "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh")
          (withConfigFile zsh-defer "share/zsh-defer/zsh-defer.plugin.zsh")
        ];

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "history" ];
        };

        envExtra = ''
          export EDITOR="nvim";
        '';

        initExtra = ''
          zsh-defer bindkey "^r" "fzf-history-widget"
          eval "$(${pkgs.direnv}/bin/direnv hook zsh)"

          ${readFile ./functions.zsh}

          alias \$=""
          export PS1="$(tput setaf 2)$(tput bold)\$ $(tput sgr0)"
        '';

        shellAliases = {
          cat = "bat";
          nix-shell = "nix-shell --command zsh";
        };

        dotDir = ".config/zsh";

        historySubstringSearch.enable = true;
        enable = true;
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.ripgrep = { enable = true; };

      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        extraOptions = [ "--group-directories-first" "--header" ];
      };

      programs.bat = {
        enable = true;

      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [ "--cmd cd" ];
      };

      home.packages = with pkgs; [ direnv ];

    };

    tags = [ "tools" ];
  };
}
