{
  nix-config.apps.sudo = {
    nixos = {
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
    };

    tags = [ "sudo" ];
  };

  nix-config.defaultTags = { sudo = true; };
}
