{
  nix-config.apps.eza = {
    home = {
      programs.eza = {
        extraOptions = [ "--group-directories-first" ];

        colors = "always";
        icons = "always";
        git = true;

        enable = true;
      };
    };

    tags = [ "eza" ];
  };

  nix-config.defaultTags = { eza = true; };
}

