{ inputs, ... }: {
  nix-config.apps.nix-index = {
    nixos = { pkgs, ... }: { programs.nix-index-database.comma.enable = true; };

    tags = [ "default" ];
  };

  nix-config = {
    modules.nixos = [ inputs.nix-index-database.nixosModules.nix-index ];
  };
}
