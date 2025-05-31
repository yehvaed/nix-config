{
  nix-config.apps.tmux = {
    home = { pkgs, ... }@inputs:
      let

        inherit (pkgs.tmuxPlugins) mkTmuxPlugin;
        inherit (pkgs) fetchFromGitHub;

        dotbar = mkTmuxPlugin rec {
          pluginName = "dotbar";
          version = "0.3.0";
          src = fetchFromGitHub {
            owner = "vaaleyard";
            repo = "tmux-dotbar";
            rev = version;
            sha256 = "sha256-n9k18pJnd5mnp9a7VsMBmEHDwo3j06K6/G6p7/DTyIY=";
          };
        };

      in {
        programs.tmux = {
          plugins = (import ./plugins/loader.nix inputs)
            (with pkgs.tmuxPlugins; [
              #themes
              catppuccin

              # sections
              battery
            ]);

          extraConfig = ''
            set-option -g renumber-windows on
            set -g base-index 1
            setw -g pane-base-index 1
          '';

          terminal = "tmux-256color";
          historyLimit = 100000;
          enable = true;
        };

        home.packages = with pkgs; [ acpi ];
      };

    tags = [ "dev" ];
  };
}
