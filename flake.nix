{
  description = "Nix custom config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-std.url = "github:chessai/nix-std";
    nix-config-modules.url = "github:chadac/nix-config-modules";
    flake-parts.url = "github:hercules-ci/flake-parts";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    posting = {
      url = "github:justDeeevin/posting?ref=flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: import ./nix-config inputs;
}
