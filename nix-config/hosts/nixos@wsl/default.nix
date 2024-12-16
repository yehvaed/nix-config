{ lib, ... }:
let machine-id = "nixos";

in {
  nix-config.hosts.${machine-id} = rec {
    nixos = { pkgs, ... }: {
      imports = [ ./configuration.nix ];

      users.users.${username}.shell = pkgs.zsh;
      programs.zsh.enable = true;

      networking.hostName = lib.mkForce "${machine-id}"; # Define your hostname.
    };

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

    username = "nixos";
    homeDirectory = "/home/${username}";

    kind = "nixos";
    system = "x86_64-linux";
  };
}
