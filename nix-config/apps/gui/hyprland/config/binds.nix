{ pkgs, ... }: # hyprlang
''
  $mod = SUPER

  # apps
  bind = $mod, RETURN, exec, ${pkgs.kitty}/bin/kitty
  bind = $mod, b, exec, ${pkgs.firefox}/bin/firefox
  bind = , f11, fullscreen

  # resize window
  bind = $mod SHIFT, h, resizeactive, -10 0 
  bind = $mod SHIFT, j, resizeactive, 0 10
  bind = $mod SHIFT, k, resizeactive, 0 -10
  bind = $mod SHIFT, l, resizeactive, 10 0

  # focus window
  bind = $mod, h, movefocus, l 
  bind = $mod, j, movefocus, d
  bind = $mod, k, movefocus, u
  bind = $mod, l, movefocus, r
''
