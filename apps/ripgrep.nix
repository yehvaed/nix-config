{
  nix-config.apps.ripgrep = {
    home = { programs.ripgrep = { enable = true; }; };

    tags = [ "default" ];
  };

  nix-config.defaultTags = { ripgrep = true; };
}

