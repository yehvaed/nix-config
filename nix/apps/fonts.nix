{ ... }:
let inherit (builtins) readFile;
in {
  nix-config.apps.fonts = {
    nixos = { pkgs, ... }: {
      fonts.packages = with pkgs;
        [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
    };

    tags = [ "tools" ];
  };
}
