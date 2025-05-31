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

  mergeItem = itemFactory: item: item // (itemFactory item);

  mapWith = fn: item: fn item;

  merge = fn: item: item // (fn item);

  files = listFilesRecursive ./.;

  pipeline = [
    (plugin: { inherit plugin; })

    (merge (mapWith ({ plugin, ... }:
      let isPluginConfig = file: hasPrefix plugin.pname (baseNameOf file);

      in { config = head (filter isPluginConfig files); })))

    (merge (mapWith ({ config, ... }:
      let baseName = replaceStrings [ ".nix" ] [ "" ] (baseNameOf config);
      in { type = if hasSuffix "lua" baseName then "lua" else "vim"; })))

    (merge (mapWith ({ config, ... }: {
      config = if hasSuffix ".nix" config then
        import (config) (inputs)
      else
        readFile (config);
    })))
  ];

  hasConfig = { pname, ... }:
    (filter (file: hasPrefix pname (baseNameOf file)) files) != [ ];

in map (plugin: pipeIf hasConfig plugin pipeline)
