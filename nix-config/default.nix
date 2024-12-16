{ flake-parts, ... }@inputs:
let
  inherit (flake-parts.lib) mkFlake;
  inherit (builtins) map readDir attrNames;

  mapToFlakeImports = path:
    map (file: path + "/${file}") (attrNames (readDir path));

  flakeModule = {
    imports = [ inputs.nix-config-modules.flakeModule ]
      ++ (mapToFlakeImports ./apps/cli) ++ (mapToFlakeImports ./apps/gui)
      ++ (mapToFlakeImports ./apps/shared) ++ (mapToFlakeImports ./hosts);

    nix-config.modules.nixos = [ inputs.nixos-wsl.nixosModules.wsl ];

    systems = [ ];
  };
in (mkFlake { inherit inputs; } flakeModule) // { inherit flakeModule; }
