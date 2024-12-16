{
  nix-config.apps.podman = {
    nixos = { pkgs, lib, ... }: {
      virtualisation = {
        containers.enable = true;

        podman = {
          enable = true;

          # Create a `docker` alias for podman, to use it as a drop-in replacement
          dockerCompat = true;

          # Required for containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };

        oci-containers.backend = "podman";
      };

      environment.systemPackages = with pkgs;
        [
          docker-compose # start group of containers for dev
        ];

      environment = {
        etc."containers/registries.conf".text = lib.mkForce ''
          [registries.block]
          registries = []

          [registries.insecure]
          registries = ["private-registry.internal.dpdgroup.com"]

          [registries.search]
          registries = ["docker.io", "quay.io"]
        '';
      };
    };

    tags = [ "podman" ];
  };

  nix-config.defaultTags = { podman = true; };
}
