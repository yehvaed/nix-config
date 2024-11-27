{ lib, ... }: 
let
machine-id = "27ee5808-ef29-40e5-ac09-c5f517a35c53";

in {
	nix-config.hosts.${machine-id} = rec {
		nixos = { pkgs, ... }: {
			imports = [ ./configuration.nix ];
      
      users.users.${username}.shell = pkgs.zsh;
      programs.zsh.enable = true;

      networking.hostName = lib.mkForce "${machine-id}"; # Define your hostname.
		};
		
    username = "nixos";
		homeDirectory = "/home/${username}";

		kind = "nixos";
		system = "x86_64-linux";
	};
}
