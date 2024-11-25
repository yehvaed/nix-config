{ ... }: {
  nix-config.apps.gh = {
    home = {
      programs.gh = {
        enable = true;
      };
    };
    tags = [ "gh" ];
  };
}
