{ lib, ... }: 
let
machine-id = "b78e32ca-ef79-50b4-8e91-bd90ffc893ba";

in {
	nix-config.hosts.${machine-id} = rec {
		nixos = { pkgs, ... }: {
			imports = [ ./configuration.nix ];
      
      users.users.${username}.shell = pkgs.zsh;
      programs.zsh.enable = true;

      networking.hostName = lib.mkForce "${machine-id}"; # Define your hostname.
		};
		
    username = "yehvaed";
		homeDirectory = "/home/${username}";

		kind = "nixos";
		system = "x86_64-linux";
	};
}
