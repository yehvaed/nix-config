{ lib, ... }@inputs:
let
  inherit (builtins)
    head listToAttrs readFile map baseNameOf hasAttr getAttr replaceStrings
    filter toFile;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.attrsets) recursiveUpdate;
  inherit (lib.trivial) pipe;
  inherit (lib.strings) hasSuffix hasPrefix;
  inherit (lib.lists) findFirst;

  pipeIf = predicate: item: pipeline:
    if predicate item then pipe item pipeline else item;

  mapWith = fn: item: fn item;

  merge = fn: item: item // (fn item);

  files = listFilesRecursive ./.;

  pipeline = [
    (plugin: { inherit plugin; })

    (merge (mapWith ({ plugin, ... }:
      let
        inherit (plugin) pname;
        baseName = replaceStrings [ "tmuxplugin-" ] [ "" ] (baseNameOf pname);
        isPluginConfig = file: hasPrefix baseName (baseNameOf file);
      in { extraConfig = head (filter isPluginConfig files); })))

    (merge (mapWith ({ extraConfig, ... }: {
      extraConfig = if hasSuffix ".nix" extraConfig then
        import (extraConfig) (inputs)
      else
        readFile (extraConfig);
    })))
  ];

  hasConfig = { pname, ... }:
    let
      baseName = replaceStrings [ "tmuxplugin-" ] [ "" ] (baseNameOf pname);
      isPluginConfig = file: hasPrefix baseName (baseNameOf file);
    in (filter isPluginConfig files) != [ ];

in map (plugin: pipeIf hasConfig plugin pipeline)
