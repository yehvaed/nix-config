{ inputs, ...}:
let
  inherit (inputs.nix-std.lib.regex) splitOn;
  inherit (inputs.nix-std.lib.serde) toTOML;
  inherit (builtins) getEnv;

  # FIXME: this need --impure flag to be turned on
  insecureRegistries = splitOn ";" (getEnv("NIX_CONFIG_PODMAN_INSECURE_REGISTRIES"));

in toTOML {
  "registries.block" = {
    registries = [];
  }; 

  "registries.insecure" = {
    registries = insecureRegistries;
  }; 
  
 "registries.search" = {
    registries = ["docker.io" "quay.io"];
  };
} 
