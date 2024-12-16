{ ... }: {
  nix-config.apps.gh = {
    home = { programs.gh = { enable = true; }; };
    tags = [ "gh" ];
  };

  nix-config.defaultTags = { gh = true; };
}
