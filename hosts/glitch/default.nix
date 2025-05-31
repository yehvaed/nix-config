{ lib, ... }:
let host = "glitch";

in {
  nix-config.hosts.${host} = rec {
    nixos = { pkgs, ... }: {
      imports = [ ./etc/nixos/configuration.nix ];

      users.users.${username}.shell = pkgs.zsh;
      programs.zsh.enable = true;

      networking.hostName = lib.mkForce host;
    };

    tags = {
      dev = true;
      virt = true;
      gui = true;
    };

    kind = "nixos";
    system = "x86_64-linux";

    username = "yehvaed";
    homeDirectory = "/home/${username}";
  };
}
