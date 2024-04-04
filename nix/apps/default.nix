{ lib, ... }:

{
  imports = [
    # desktop apps
    ./guis/xmonad
    ./guis/polybar
    ./guis/alacritty
    ./guis/greetd
    ./guis/rofi
    ./guis/qutebrowser
    
    # virt 
    ./docker.nix

    # shell tools
    ./tools/nvim
    ./tools/tmux
    ./tools/zsh
    ./tools/git.nix

    # rest
    ./fonts.nix
    ./init.nix

    # helper
    ./sudo.nix
  ];
}
