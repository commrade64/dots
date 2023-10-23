{ pkgs }:

pkgs.writeShellScriptBin "autostart" ''
  # Notification Daemon

  # Wayland
  # exec ${pkgs.swaynotificationcenter}/bin/swaync &   # notification daemon
  # ${pkgs.swww}/bin/swww init                         # wallpaper daemon
  # ${pkgs.waybar}/bin/waybar &                        # status bar

  # X
  ${pkgs.dunst}/bin/dunst &                            # notification daemon
  ${pkgs.networkmanagerapplet}/bin/nm-applet &         # network manager applet
  ${pkgs.polybar}/bin/polybar main &                   # status bar
  ''$HOME/dots/lib/scripts/polybar/focus_change.sh &   # listen to window focus change

  set_wall
''
