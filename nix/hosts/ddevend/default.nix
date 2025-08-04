{ inputs, lib, ... }: let
host = "ddevend";
user = "nixos";

in {
  nix-config = {
    apps = {
       "${host}@git" = {
          home = { pkgs, ... }: {
            programs.git = {
              extraConfig = {
                credential = {
                  helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
                };
            };
            
            enable = true;
          };
        };
        
          tags = [ "${host}" ]; 
      };

      "${host}@zsh" = {
          nixos = { pkgs, ... }: {
            users.users.${user}.shell = pkgs.zsh;
            programs.zsh.enable = true;
          };

          tags = [ "${host}" ]; 
      };
    };

    hosts.${host} = {
      kind = "nixos";
      system = "x86_64-linux";

      username = user;
      homeDirectory = "/home/${user}";

      tags = {
        "@mux" = true;
        "@sh" = true;
        cntr = true;
        nix = true;
        scm = true;
        tl = true;
        wsl = true;
        ${host} = true;
      };

      nixos = import ./nixos/configuration.nix;
      home = import ./nixos/home.nix;
    };

    modules.nixos = [ inputs.nixos-wsl.nixosModules.wsl ];
  };
}

