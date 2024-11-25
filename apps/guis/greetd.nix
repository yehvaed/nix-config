{
  nix-config.apps.greetd = {
    nixos = { pkgs, ... }: {
      services.greetd = {
        settings = rec {
          initial_session = {
            command = "${pkgs.hyprland}/bin/Hyprland";
            user = "yehvaed";
          };
          default_session = initial_session;
        };
        enable = true;
      };
    };

    tags = [ "greetd" ];
  };
}
