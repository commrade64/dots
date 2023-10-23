{ config, lib, pkgs, vars, ... }: { 
  config = lib.mkIf (config.bspwm.enable) {
    home-manager.users.${vars.username} = {
      services.picom = {
        enable = true;
        package = pkgs.picom;

        backend = "glx";                              # 'glx' or 'Xrender'
        vSync = true;                                 # Fix Screen Tearing

        #activeOpacity = 0.93;                        # Transparency
        #inactiveOpacity = 0.93;
        #menuOpacity = 0.93;

        shadow = true;                               # Shadows
        shadowOpacity = 0.75;

        fade = false;
        fadeDelta = 10;
        # transition-length = 150;                    # Animations Jonaburg
        # transition-pow-x = 0.5;
        # transition-pow-y = 0.5;
        # transition-pow-w = 0.5;
        # transition-pow-h = 0.5;
        # size-transition = true;

        opacityRules = [                              # Opacity rules if transparency is prefered
          #"100:name = 'Picture in picture'"
          #"100:name = 'Picture-in-Picture'"
          #"85:class_i ?= 'rofi'"
          #"80:class_i *= 'discord'"
          #"80:class_i *= 'emacs'"
          #"90:class_i *= 'Alacritty'"
          #"100:fullscreen"
        ];                                            # Find with $ xprop | grep "WM_CLASS"


        settings = {
          # Rounded corners
          corner-radius = 12;                          # Corners
          round-border = 12;
          rounded-corners-exclude = [
            "window_type = 'dock'"
            "window_type = 'desktop'"
            "name *= 'polybar'"
          ];

          # Blur
          # blur = {
          #   # size = 10.0;
          #   strength = 5.0;
          #   deviation = 1.0;
          #   method = "dual_kawase";
          #   kernel = "11x11gaussian";
          # };
          # blur-background = false;
          # blur-background-frame = true;
          # blur-background-fixed = true;

          focus-exclude = [
          	"class_g ?= 'rofi'"
          	"class_g ?= 'slop'"
          ];
          
          shadow-exclude = [
          	"name = 'Notification'"
          	"class_g = 'Conky'"
          	"class_g ?= 'Notify-osd'"
          	"class_g = 'Cairo-clock'"
          	"class_g = 'slop'"
          	"class_g = 'Firefox' && argb"
          	"class_g = 'Rofi'"
          	"class_g = 'i3bar'"
              "class_g *= 'i3bar'"
              "name *= 'i3bar'"
              "class_g ?= 'i3bar'"
              "class_g *= 'i3'"
          	"_GTK_FRAME_EXTENTS@:c"
          	"_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
          ];

          # General settings
          daemon = true;
          use-damage = false;                         # Fixes Flickering
          resize-damage = 1;
          refresh-rate = 0;
          detect-rounded-corners = true;              # Extras
          detect-client-opacity = false;
          detect-transient = true;
          detect-client-leader = false;
          mark-wmwim-focused = true;
          mark-ovredir-focues = true;
          unredir-if-possible = true;
          glx-no-stencil = true;
          glx-no-rebind-pixmap = true;

           wintypes = {
             tooltip = { fade = true; shadow = false; focus = false; };
             normal = { shadow = true; };
             dock = { shadow = false; };
             dnd = { shadow = false; };
             popup_menu = { shadow = true; focus = false; };
             dropdown_menu = { shadow = true; focus = false; };
             above = { shadow = true; };
             splash = { shadow = false; };
             utility = { focus = false; shadow = false; blur-background = false; };
             notification = { shadow = true; };
             desktop = { shadow = false; blur-background = false; };
             menu = { focus = false; };
             dialog = { shadow = true; };
           };
        };
      };
    };
  };
}
