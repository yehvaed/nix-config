{
  nix-config.apps.greetd = {
    nixos = { pkgs, ... }: {
      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.hyprland}/bin/hyprland";
            user = "yehvaed";
          };

          default_session = initial_session;
        };
      };
    };

    tags = [ "gui" ];
  };
}
