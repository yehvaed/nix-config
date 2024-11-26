{
  nix-config.apps.fonts = {
    nixos = { pkgs, ...}: {
      fonts.packages = with pkgs; [ 
        (nerdfonts.override { 
          fonts = [ 
            "IBMPlexMono"
            "Iosevka"
            "IosevkaTerm"
            "FiraCode" 
          ]; 
        }) 
      ];
    };

    tags = [ "fonts" ];
  };
  
  nix-config.defaultTags = {
    fonts = true;
  }; 
}
