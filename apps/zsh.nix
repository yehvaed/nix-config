{ lib, ... }:
let
  inherit (builtins)
    concatLists attrValues isAttr filter readDir match map exec;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) removePrefix hasSuffix;
  inherit (lib) findFirst any;

  matchPattern = file: any (pattern: hasSuffix pattern file) [ ".plugin.zsh" ];

  findPluginFile = plugin:
    let
      files = map (file: removePrefix plugin.outPath file)
        (listFilesRecursive plugin.outPath);
    in findFirst matchPattern "" files;

  loadPlugin = plugin: {
    name = plugin.name;
    src = builtins.trace "${plugin.outPath}" plugin.outPath;
    file = builtins.trace "${findPluginFile plugin}" (findPluginFile plugin);
  };

  load = plugins: map loadPlugin plugins;

in {
  nix-config.apps.zsh = {
    home = { pkgs, ... }: {
      programs.zsh = {
        plugins =
          load (with pkgs; [ zsh-fzf-tab zsh-fzf-history-search zsh-f-sy-h  ]);

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };

        zsh-abbr = {
          enable = true;
        };

        enable = true;
      };
    };

    nixpkgs = { packages.unfree = [ "zsh-abbr" ]; };

    tags = [ "dev" ];
  };
}
