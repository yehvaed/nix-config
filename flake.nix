{
	description = "Nix custom config";
	
	outputs = {flake-parts, nixpkgs, ...}@inputs:
	let
		inherit (flake-parts.lib) mkFlake;
    inherit (nixpkgs.lib) attrNames;
    inherit (builtins) map readDir;

    getNixModulesFrom = from:
      map (module: from + "/${module}") (attrNames (readDir from));

		flakeModule = {
			imports = [
				# ==> external modules to load
				inputs.nix-config-modules.flakeModule
			] 
      ++ (getNixModulesFrom ./apps)
      ++ (getNixModulesFrom ./hosts)
      ;

			systems = [];
		};
	in (mkFlake { inherit inputs; } flakeModule) // { inherit flakeModule; };
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nix-config-modules.url = "github:chadac/nix-config-modules";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		flake-parts.url = "github:hercules-ci/flake-parts";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
	};
}
