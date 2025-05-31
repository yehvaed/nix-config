{
  nix-config.apps.zoxide = {
    home = {
      programs.zoxide = {
        enableZshIntegration = true;
        enable = true;
      };
    };

    tags = [ "default" ];
  };

  nix-config.defaultTags = { zoxide = true; };
}

