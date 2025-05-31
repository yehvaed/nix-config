{
  nix-config.apps.neovim = {
    home = { config, pkgs, ... }@inputs: 
    let 
      inherit (config.home) homeDirectory;
      inherit (config.lib.file) mkOutOfStoreSymlink;
    in {
      programs.neovim = {
        plugins = with pkgs.vimPlugins; [
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

          # ==> @tools
          neorg
        ];

        viAlias = true;
        vimAlias = true;

        enable = true;
      };

      home.file.".config/nvim".source = 
        mkOutOfStoreSymlink "${homeDirectory}/.local/etc/nixos/apps/neovim";
    };

    nixos = { 
      environment.variables = { 
        EDITOR = "nvim"; 
      }; 
    };

    tags = [ "dev" ];
  };
}
