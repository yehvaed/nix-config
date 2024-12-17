{
  nix-config.apps.ripgrep = {
    home = { programs.ripgrep = { enable = true; }; };

    tags = [ "ripgrep" ];
  };

  nix-config.defaultTags = { ripgrep = true; };
}

