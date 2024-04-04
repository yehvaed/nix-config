#!/usr/bin/env nix-shell
#! nix-shell -i bash -p home-manager git vim fzf

export NIX_EXTRA_EXPERIMENTAL_FEATURES="nix-command flakes"
debug_opts=( --option eval-cache false )

_nixos-rebuild() {
  echo "====> ${1} nixos configuration"
  sudo nixos-rebuild  \
    "${1}" \
    --flake ".#${2}" \
    "${debug_opt[@]}"
}

_home-manager() {
 echo "====> ${1} home-manager configuration"
 home-manager \
   --extra-experimental-features "${NIX_EXTRA_EXPERIMENTAL_FEATURES}" \
    "${1}" \
    --flake ".#${2}" \
   "${debug_opt[@]}"
}

_nix_helper() {
  _nixos-rebuild "$@"
  _home-manager "$@"
}

hosts="$(grep -Rh hosts nix/hosts | cut -d'=' -f1 | tr -d ' ' | cut -d'.' -f3)"
count=$(( $(echo ${hosts} | wc -l) + 3))

if [[ -n "$2" ]]; then
  host=$(echo "${hosts[@]}" | fzf --height "${count}" --filter "$2")
else
  host="${HOSTNAME}"
fi

[[ -n "${host}" ]] && _nix_helper "$1" "${host}" 

