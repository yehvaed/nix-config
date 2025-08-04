{ lib, ... }:
let
  host = "mthrshp";
  user = "yehvaed";

in
{
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

      "${host}@zsh" = {
        nixos =
          { pkgs, ... }:
          {
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
        # ==> development tools
        docker = true;
        vscode = true;
        distros = true;

        # ==> scm tools
        github = true;

        # ==> default apps
        default = true;

        # ==> host specific overrides
        ${host} = true;
      };

      nixos = import ./nixos/configuration.nix;
      home = import ./nixos/home.nix;
    };
  };
}
