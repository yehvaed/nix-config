{
  nix-config.apps.nh = {
    home = {
      programs.nh = {
        clean = {
          enable = true;
          extraArgs = "--keep 5 --keep-since 3d";
        };

        enable = true;
      };

      programs.zsh = { shellAliases = { nhos = "nh os switch"; }; };
    };

    tags = [ "nh" ];
  };

  nix-config.defaultTags = { nh = true; };
}
