{ ... }@inputs: {
  nix-config.apps.podman = {
    nixos = { pkgs, lib, ... }: {
      virtualisation = {
        containers.enable = true;

        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };

        oci-containers.backend = "podman";
      };

      environment.systemPackages = with pkgs; [ docker-compose ];

      environment = {
        etc."containers/registries.conf".text = lib.mkForce (import ./config/registries.conf.nix inputs);
      };
    };

    tags = [ "podman" ];
  };

  nix-config.defaultTags = { podman = true; };
}
