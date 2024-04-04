{ lib, ... }:

{
  nix-config.apps.git = {
    home = { pkgs, ... }: {
      programs.git = {
        extraConfig = {
          core = { pager = "delta"; };
          interactive = { diffFilter = "delta --color-only"; };
          delta = {
            navigate = true;
            light = false;
          };
          merge = { conflictstyle = "diff3"; };
          diff = { colorMoved = "default"; };
          init = { defaultBranch = "main"; };
          status = {
            # short = true;
          };
          fetch = { prune = true; };
          pull = { rebase = false; };
          pretty = {
            default =
              "%Cred%h%Creset - %C(cyan)%an%Creset - %s %Cblue(%cr) %C(green)%d%Creset";
          };
          format = { pretty = "default"; };
        };
        enable = true;
      };

      home.packages = with pkgs; [ delta ];
    };

    tags = [ "tools" ];
  };
}
