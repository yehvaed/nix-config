{
  pkgs ? import <nixpkgs> {},
  ...
}: 
let

buildGoModule = pkgs.buildGoModule.override { go = pkgs.go_1_23; };

in buildGoModule rec {
  pname = "diffnav";
  version = "0.2.8";
  
  vendorHash = "sha256-2JjQF+fwl8+Xoq9T3jCvngRAOa3935zpi9qbF4w4hEI=";

  src = pkgs.fetchFromGitHub {
    owner = "dlvhdr";
    repo = "diffnav";
    rev = "v${version}";
    hash = "sha256-xZAi/Ky1RjOxjhQKHvozaPTqDPcrGfhMemGWzi7WyW4=";
  };

  dependencies = with pkgs; [ delta ];
}
