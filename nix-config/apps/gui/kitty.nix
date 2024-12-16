{ ... }: {
  nix-config.apps.kitty = {
    home = {
      programs.kitty = {
        settings = {
          # paddings
          window_padding_width = 10;
        };

        font = {
          name = "Fira Code";
          size = 10;
        };

        enable = true;
      };
    };

    tags = [ "kitty" ];
  };

  nix-config.defaultTags = { kitty = true; };
}
