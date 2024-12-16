{ extend, ... }:
let inherit (builtins) readFile;

in {
  nix-config.apps.nvim = {
    home = extend ({ mapToConfig, pkgs, ... }: {
      programs.neovim = {
        plugins = mapToConfig (with pkgs.vimPlugins; [
          # ==> @editor/lsp
          nvim-cmp
          nvim-lspconfig
          luasnip
          cmp-nvim-lsp
          cmp_luasnip

          # ==> @editor/treesitter
          nvim-treesitter.withAllGrammars

          # ==> @editor
          neo-tree-nvim
          trouble-nvim

          # ==> @pickers
          fzf-lua

          # ==> @theme
          neovim-ayu
        ]);

        viAlias = true;
        vimAlias = true;

        extraConfig = readFile ./config/init.vim;

        enable = true;
      };
    });

    nixos = { environment.variables.EDITOR = "nvim"; };

    tags = [ "nvim" ];
  };

  nix-config.defaultTags.nvim = true;
}
