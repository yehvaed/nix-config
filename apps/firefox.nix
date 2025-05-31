{
  nix-config.apps.firefox = {
    home = { pkgs, ... }: {
      programs.firefox = {
        package = pkgs.firefox;
        enable = true;
      };
    };

    tags = [ "gui" ];
  };
}

