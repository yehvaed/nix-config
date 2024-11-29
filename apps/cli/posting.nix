{ ... }@params: {
  nix-config.apps.posting = {
    home = { pkgs, ... }@inputs: {
      programs.posting = {
        enable = true;
      };
    };
    
    nixpkgs = { inputs, ... }: {
      params.overlays = [ inputs.posting.overlays.default ];
    };

    tags = [ "posting" ];
  };

  nix-config.defaultTags = {
    posting = true;
  };
  
  nix-config.modules.home-manager = [
    params.inputs.posting.modules.homeManager.default  
  ];
}
