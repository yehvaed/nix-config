{
  nix-config.apps.lazygit = {
    home = { programs.lazygit = { enable = true; }; };

    tags = [ "dev" ];
  };
}

