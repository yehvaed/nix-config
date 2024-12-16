{
  nix-config.apps.zoxide = {
    home = {
      programs.zoxide = {
        enableZshIntegration = true;
        enable = true;
      };
    };

    tags = [ "zoxide" ];
  };

  nix-config.defaultTags = { zoxide = true; };
}

