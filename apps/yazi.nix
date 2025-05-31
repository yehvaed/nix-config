{
  nix-config.apps.yazi = {
    home = { programs.yazi = { enable = true; }; };

    tags = [ "dev" ];
  };
}

