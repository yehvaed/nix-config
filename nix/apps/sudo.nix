{ ... }:
let inherit (builtins) readFile;
in {
  nix-config.apps.sudo = {
    nixos = { pkgs, config, ... }: {
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
    };

    tags = [ "essentials" ];
  };
}
