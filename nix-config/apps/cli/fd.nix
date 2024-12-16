{
  nix-config.apps.fd = {
    home = { programs.fd = { enable = true; }; };

    tags = [ "fd" ];
  };

  nix-config.defaultTags = { fd = true; };
}

