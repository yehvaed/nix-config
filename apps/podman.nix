{
  nix-config.apps.podman = {
    nixos = { pkgs, ... }: {
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
    };

    tags = [ "virt" ];
  };
}
