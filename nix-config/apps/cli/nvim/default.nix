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

  matchPipe = pipeMaps: items:
    let
      findPipe = item:
        getAttr "pipe" (findFirst ({ cond, ... }: cond item) null pipeMaps);

      mapByPipe = item: pipe item (findPipe item);

    in map mapByPipe items;

  mergeItem = itemFactory: item: item // (itemFactory item);

  files = listFilesRecursive ./config;

  extend = f:
    { pkgs, lib, ... }@inputs:
    f {
      mapToConfig = matchPipe [
        # if plugins has config
        {
          pipe = [
            (plugin: plugin // { inherit plugin; })

            (mergeItem ({ pname, ... }: {
              listedConfigFiles =
                filter (file: hasPrefix pname (baseNameOf file)) files;
            }))

            (mergeItem ({ listedConfigFiles, ... }: {
              listedConfigFiles = listedConfigFiles;
            }))

            (mergeItem ({ listedConfigFiles, ... }: {
              configFile = head listedConfigFiles;
            }))

            (mergeItem ({ pname, configFile, ... }: {
              baseName =
                replaceStrings [ ".nix" ] [ "" ] (baseNameOf configFile);
            }))

            (mergeItem ({ baseName, ... }: {
              type = if hasSuffix "lua" baseName then "lua" else "vim";
            }))

            (mergeItem ({ configFile, ... }: {
              config = if hasSuffix ".nix" configFile then
                import (configFile) (inputs)
              else
                readFile (configFile);
            }))
          ];

          cond = { pname, ... }@plugin:
            filter (file: hasPrefix pname (baseNameOf file)) files != [ ];
        }

        # if not have config
        {
          pipe = [ (plugin: plugin) ];

          cond = plugin: true;
        }
      ];

      # passtrough inputs
      inherit pkgs;
      inherit lib;
    };

  module = { enable = true; };

in import ./nvim.nix (inputs // { inherit extend; } // module)
