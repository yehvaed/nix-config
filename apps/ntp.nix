{ inputs, ... }: {
  nix-config.apps.ntp = {
    nixos = { options, pkgs, ... }: { 
      networking.timeServers = options.networking.timeServers.default;
    };

    tags = [ "default" ];
  };
}
