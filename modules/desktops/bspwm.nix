{ config, lib, pkgs, vars, host, ... }: with lib; with host; let
  monitor =
    if hostname == "desktop" then
      "${pkgs.xorg.xrandr}/bin/xrandr --output ${main-monitor} --mode 1920x1080 --rate 144.0 --pos 0x0 --rotate normal"
    else if hostname == "notebook" then
      "${pkgs.xorg.xrandr}/bin/xrandr --output ${main-monitor} --mode 1366x768 --rate 60.0 --pose 0x0 --rotate normal"
    else false;

  extra = ''
    killall -q polybar &
    while grep -u $UID -x polybar >/dev/null; do sleep 1; done

    #pgrep -x sxhkd >/dev/null || sxhkd &
    
    WORKSPACES
    
    bspc config top_padding        0
    bspc config bottom_padding     0
    bspc config border_width       2
    bspc config window_gap         5
    bspc config split_ratio     0.52

    bspc config click_to_focuse         true
    bspc config focus_follows_pointer   false
    bspc config borderless_monocle      false
    bspc config gapless_monocle         false

    bspc config focused_border_color     "#504945"
    bspc config normal_border_color      "#282828"

    # Call an auto-start script
    autostart
  '';
  
  extraConf = builtins.replaceStrings [ "WORKSPACES" ]
  [(
    if hostname == "desktop" then ''
       bspc monitor -d 1 2 3 4 5 6 7
     ''
     else if hostname == "notebook" then ''
       bspc monitor -d 1 2 3 4
     ''
     else false
  )]
  "${extra}";
in {
  options = {
    bspwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.bspwm.enable) {
    x11wm.enable = true;

    services = {
      xserver = {
        enable = true;

        layout = "us,ua";
        xkbVariant = ",,";
        xkbModel = "pc104";
        xkbOptions = "grp:alt_shift_toggle";

        displayManager = {
          sddm = {
            enable = true;
          };
          defaultSession = "none+bspwm";
          sessionCommands = monitor;
          #   export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
          #   export USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
          #   export ALTUSERXSESSION="$XDG_CACHE_HOME/X11/Xsession"
          #   export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors
          # '';
        };

        windowManager = {
          bspwm = {
            enable = true;
          };
        };

        serverFlagsSection = ''
          Option "BlankTime" "0"
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
        '';

        resolutions = [
          { x = 1920; y = 1080; }
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      xclip         # Clipboard manager
      xdotool       # Fake kbd/mouse input
      xorg.xev      # Event viewer
      xorg.xkill    # Process killer
      xorg.xrandr   # Monitor settings
      xterm         # Basic X terminal (for testing purposes)
    ];

    home-manager.users.${vars.username} = {
      xsession = {
        enable = true;
        windowManager.bspwm = {
          enable = true;
          rules = {
            #"Emacs" = {
            #  desktop = "1";
            #  follow = true;
            #  state = "tiled";
            #};
            "firefox" = {
              desktop = "2";
              follow = false;
              state = "tiled";
            };
            "Pavucontrol" = {
              state = "floating";
              sicky = true;
              rectangle = "1080x540+420+270";
            };
            "Pcmanfm" = {
              state = "floating";
            };
            "Save Image" = {
              state = "floating";
            };
          };
          extraConfig = extraConf;
        };
      };

      xresources = {
       path = "$HOME/.config/x11/xresources";
      };
    };
  };
}
