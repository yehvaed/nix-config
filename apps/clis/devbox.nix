{
  nix-config.apps.devbox = {
    home = { pkgs, ...}: {
      home.packages = [ pkgs.devbox ];
    };

    tags = [ "devbox" ];
  };
}
