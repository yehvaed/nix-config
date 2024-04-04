{ pkgs, lib, ... }:
let
  inherit (builtins) readFile;
  inherit (lib.strings) hasSuffix;

  withConfig = plugin: type: config: {
    inherit plugin;
    inherit type;
    inherit config;

  };

  withConfigFile = plugin: configFile:
    withConfig plugin (if hasSuffix ".lua" configFile then "lua" else "vim")
    (readFile (configFile));

in {
  nix-config.apps.nvim = {
    home = { pkgs, ... }: 
    let
      extraPlugins = import ./pkgs.nix { inherit pkgs; };
    in {
      programs.neovim = {
        plugins = (with pkgs.vimPlugins; [
          # editors     
          (withConfigFile nvim-cmp ./plugins/editor/nvim-cmp.lua)
          (withConfigFile nvim-lspconfig ./plugins/editor/nvim-lspconfig.lua)
          (withConfig comment-nvim "lua" "require('Comment').setup()")
          luasnip
          lspkind-nvim
          cmp-nvim-lsp
          nvim-cmp
          cmp_luasnip
          (withConfigFile nvim-treesitter.withAllGrammars ./plugins/editor/nvim-treesitter.lua)
          nvim-treesitter-parsers.svelte
          (withConfigFile neo-tree-nvim ./plugins/editor/neo-tree.lua)

          # pickers
          (withConfigFile fzf-lua ./plugins/pickers/fzf-lua.lua)

          # themes
          (withConfigFile neovim-ayu ./plugins/themes/ayu.lua)

          # icons
          nvim-web-devicons
          
          # tools
          (withConfigFile neorg ./plugins/tools/neorg.lua)

          # others
          plenary-nvim
        ])
        ++ (with pkgs.tree-sitter-grammars; [
          tree-sitter-norg-meta
        ])
        ++ (with extraPlugins; [
          (withConfig refactoring-nvim "lua" "require('refactoring').setup({})")
        ]);

        extraLuaPackages = luaPkgs : [
          luaPkgs.pathlib-nvim # For neorg
          luaPkgs.lua-utils-nvim # For neorg
          luaPkgs.nvim-nio
        ];

        extraPackages = with pkgs; [
            # go
            gopls

            # ts
            nodePackages.typescript-language-server
            nodePackages.svelte-language-server

            # haskel
            ghc
            haskell-language-server

            # java
            java-language-server
        ];

        extraConfig = readFile (./plugins/init.vim);

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        enable = true;
      };

      programs.fzf = { enable = true; };

      programs.ripgrep = { enable = true; };

      programs.zsh.shellAliases = { v = "nvim"; };
    };

    tags = [ "essentials" "nvim" ];
  };
}
