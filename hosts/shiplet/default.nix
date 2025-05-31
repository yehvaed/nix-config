{ inputs, lib, ... }:
let machine-id = "shiplet";

in {
  nix-config.hosts.${machine-id} = rec {
    home = {
      programs.git = {
        extraConfig = {
          credential = {
            helper =
              "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
          };
        };

        enable = true;
      };
    };

    nixos = { pkgs, ... }: {
      imports = [ ./etc/nixos/configuration.nix ];

      users.users.${username}.shell = pkgs.zsh;
      programs.zsh.enable = true;

      networking.hostName = lib.mkForce "${machine-id}"; # Define your hostname.
    };

    username = "nixos";
    homeDirectory = "/home/${username}";

    tags = {
      dev = true;
      virt = true;
      gui = true;
    };

    kind = "nixos";
    system = "x86_64-linux";
  };


  nix-config.modules.nixos = [ inputs.nixos-wsl.nixosModules.wsl ];
}
