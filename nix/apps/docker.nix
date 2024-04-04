{ ... }:
let inherit (builtins) readFile;
in {
  nix-config.apps.docker = {
    nixos = { pkgs, config, ... }: {
      virtualisation.docker.enable = true; 
    };

    tags = [ "virt" ];
  };
}
