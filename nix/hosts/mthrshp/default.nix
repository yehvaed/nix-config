{ lib, ... }: {
  nix-config.hosts.mthrshp = rec {
    nixos = { pkgs, ... }: {
      imports = [ 
         ./hardware-configuration.nix
      ];

      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;
      };

      users.users.${username} = {
        isNormalUser = true;

        home = "/home/${username}";
        extraGroups = [ "wheel" "networkmanager" ];
      };

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Warsaw";

      # users.users.${username}.shell = pkgs.zsh;
      programs.zsh.enable = true;

      networking.hostName = lib.mkForce "mthrshp";

      system.stateVersion = "24.05";
    };

    home = { pkgs, ...}: {
      home.stateVersion = "24.05";
    };

    tags = {
      tl = true;
      nix = true;
      scm = true;
    };

    kind = "nixos";
    system = "x86_64-linux";

    username = "yehvaed";
    homeDirectory = "/home/${username}";


  };
}
