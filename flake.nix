{
  description = "My nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-config-modules.url = "github:chadac/nix-config-modules";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    ags.url = "github:Aylur/ags";
  };

  outputs = inputs: import ./nix/outputs.nix (inputs);
}
