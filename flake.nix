{
	description = "Nix custom config";
	
	outputs = {flake-parts, ...}@inputs:
	let
		inherit (flake-parts.lib) mkFlake;
		inherit (builtins) map readDir attrNames;

    mapToFlakeImports = path:
      map (file: path + "/${file}") (attrNames (readDir path));

    flakeModule = {
			imports = [
				inputs.nix-config-modules.flakeModule
      ]
      ++ (mapToFlakeImports ./apps/cli)
      ++ (mapToFlakeImports ./apps/gui)
      ++ (mapToFlakeImports ./apps/shared)
      ++ (mapToFlakeImports ./hosts);

			systems = [];
		};
	in (mkFlake { inherit inputs; } flakeModule) // { inherit flakeModule; };
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nix-config-modules.url = "github:chadac/nix-config-modules";
		flake-parts.url = "github:hercules-ci/flake-parts";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";   
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    posting = {
      url = "github:justDeeevin/posting?ref=flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};
}
