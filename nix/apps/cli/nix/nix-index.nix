{ inputs, ... }: {
  nix-config.apps.nix-index = {
    nixos = { pkgs, ... }: { programs.nix-index-database.comma.enable = true; };

    tags = [ "nix" ];
  };

  nix-config = {
    modules.nixos = [ inputs.nix-index-database.nixosModules.nix-index ];
  };

  nix-config.defaultTags.nix = false;
}
