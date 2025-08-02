{
  nix-config.apps.fzf = {
    home = { programs.fzf = { enable = true; }; };

    tags = [ "tl" ];
  };

  nix-config.defaultTags.tl = false;
}

