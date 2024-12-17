{
  nix-config.apps.fonts = {
    nixos = { pkgs, ... }: {
      fonts.packages = with pkgs;
        [
          fira-code
        ];
    };

    tags = [ "fonts" ];
  };

  nix-config.defaultTags = { fonts = true; };
}
