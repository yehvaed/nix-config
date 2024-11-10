{ ... }: /* hyprlang */ ''
  general {
    border_size = 0
    gaps_in = 15
    gaps_out = 20
  }

  decoration {
    #col.shadow = rgba(255,99,71,0.25)
    col.shadow = rgb(0,0,0)
    col.shadow_inactive = rgb(0,0,0)
    shadow_offset = 5 5

    # shadow {
    #   enable = true;
    #   color = 0xff000000;
    #   color_inactive = 0xee1a1a1a;
    # }

    rounding = 10
  }

  misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
  }
''
