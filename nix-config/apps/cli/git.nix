{ ... }: {
  nix-config.apps.git = {
    home = { ... }: { programs.git = { enable = true; }; };
    tags = [ "git" ];
  };

  nix-config.defaultTags = { git = true; };
}
