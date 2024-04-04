{ nixos-wsl, pkgs, ... }: {
  nix-config.hosts.devbox = rec {
    kind = "nixos";
    system = "x86_64-linux";

    username = "yehvaed";
    homeDirectory = "/home/yehvaed";

    nixos = { pkgs, ... }: {
      imports = [ ./configuration.nix ];

      users.users."${username}" = {
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "audio" ];
      };

      programs.zsh.enable = true;

      networking.hostName = "devbox";
    };

    tags = {
      gnome = true;
      terminal = true;
      browser = true;
    };
  };
}
