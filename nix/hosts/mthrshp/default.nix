{ lib, ... }: {
  nix-config.hosts.mthrshp = rec {
    nixos = import ./nixos/configuration.nix;
    home = import ./nixos/home.nix;

    tags = {
      cntr = true;
      nix = true;
      scm = true;
      tl = true;
    };

    nix-config = {
      apps.kde.enable = true;
    };

    kind = "nixos";
    system = "x86_64-linux";

    username = "yehvaed";
    homeDirectory = "/home/${username}";
  };
}
