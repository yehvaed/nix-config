{
  nix-config.apps.devbox = {
    home = { pkgs, ... }: { home.packages = [ pkgs.devbox ]; };

    tags = [ "devbox" ];
  };

  nix-config.defaultTags = { devbox = true; };
}
