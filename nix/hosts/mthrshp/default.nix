{ lib, ... }: let
host = "mthrshp";

in {
  nix-config = {
    apps = {
      "${host}@kde" = {
          nixos = {
            services = {
              desktopManager.plasma6.enable = true;
              displayManager.sddm.enable = true;
              displayManager.sddm.wayland.enable = true;
            };
          };

          tags = [ "${host}" ]; 
      };
    };

    hosts.${host} = rec {
      kind = "nixos";
      system = "x86_64-linux";

      username = "yehvaed";
      homeDirectory = "/home/${username}";

      tags = {
        cntr = true;
        nix = true;
        scm = true;
        tl = true;
        ${host} = true;
      };

      nixos = import ./nixos/configuration.nix;
      home = import ./nixos/home.nix;
    };
  };
}
