{ pkgs, ... }:
with pkgs; [
  # go
  gopls

  # ts
  nodePackages.typescript-language-server
  nodePackages.svelte-language-server

  # haskel
  ghc
  haskell-language-server

  # java
  java-language-server
]
