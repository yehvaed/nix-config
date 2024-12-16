{ pkgs, lib, ... }@inputs:
let

  inherit (builtins)
    concatLists attrValues isAttr filter readDir match map exec;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) removePrefix hasSuffix;
  inherit (lib) findFirst any;

  findPluginFile = plugin:
    let
      files = map (file: removePrefix plugin.outPath file)
        (listFilesRecursive plugin.outPath);
      matchPattern = file:
        any (pattern: hasSuffix pattern file) [ ".plugin.zsh" ];

    in findFirst matchPattern "" files;

  loadPlugin = plugin: {
    name = plugin.name;
    src = plugin.outPath;
    file = findPluginFile plugin;
  };

  load = plugins: map loadPlugin plugins;

  module = { inherit load; };

in import ./zsh.nix (inputs // module)
