{
  nix-config.apps.direnv = {
    home = {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;        
        nix-direnv.enable = true;
      };
    };

    tags = [ "direnv" ];
  };

  nix-config.defaultTags = { direnv = true; };
}

