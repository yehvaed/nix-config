{ ... }: {
  nix-config.apps.gh = {
    home = { programs.gh = { enable = true; }; };
    tags = [ "scm" ];
  };

  nix-config.defaultTags.scm = false;
}
