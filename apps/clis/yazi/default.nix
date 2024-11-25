{ ... }: {
  nix-config.apps.yazi = {
    home = {
      programs.yazi = {
        enableZshIntegration = true;
        enable = true;
      };
    };

    tags = [ "yazi" ];
  };
}
