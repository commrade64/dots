{ config, pkgs, lib, vars, host, ... }: with host; let 
  dpi = 
    if hostname == "desktop" then
      92
    else if hostname == "notebook" then
      125
    else 93;
  
  polybar = pkgs.polybar.override {
    alsaSupport = true;
    pulseSupport = true;
  };
in {
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${vars.username} = {
      services.polybar = {
        enable = true;
        package = polybar;
        config = {
          "colors" = {
            background = "#282828";
            background-alt = "#1d2021";
            foreground = "#ebdbb2";
            primary = "#ebdbb2";
            secondary = "#fabd2f";
            alert = "#cccc241d";
            disabled = "#928374";
          };
          
          "bar/main" = {
            width = "100%";
            height = "18pt";
            radius = 0;
            dpi = dpi;

            foreground = "\${colors.foreground}";
            background = "\${colors.background}";

            line-size = "0pt";
            line-color = "\${colors.secondary}";

            border-bottom-size = "2pt";
            border-bottom-color = "\${colors.background-alt}";
            
            padding-left = 5;
            padding-right = 3;
            
            module-margin = 1;
            modules-left = "launcher class";
            modules-center = "bspwm";
            modules-right = "xkeyboard audio-input audio-output network date";
            
            separator = " ";
            separator-foreground = "\${colors.secondary}";
            
            font-0 = "SF Pro Text:size=9:weight=200;1";
            font-1 = "monospace:size=10:weight=150;3";
            font-2 = "SF Pro Display:size=9:weight=210;2";
            font-3 = ".SF Symbols Fallback:size=9;0";
            font-4 = "Apple Color Emoji:size=1;0";

            tray-position = "right";
            tray-maxsize = 16;
            tray-foreground = "\${colors.foreground}";
            tray-background = "\${colors.background}";
            tray-padding = 1;
            
            cursor-click = "pointer";
            cursor-scroll = "ns-resize";
            
            enable-ipc = true;
            
            wm-restack = "bspwm";
          };

          "module/launcher" = {
            type = "custom/text";
            # content = "";
            # content = "";
            content = "􀛧 ";
            content-padding = 1;
            # content-foreground=${colors.primary}
            # click-left = ~/.config/polybar/hack/scripts/launcher.sh &
            # click-right = ~/.config/polybar/hack/scripts/color-switch.sh &
          };

          "module/class" = {
            type = "custom/ipc";
            format-font = 3;
            format-foreground = "#fbf1c7";
            hook-0 ="exec ~/dots/lib/scripts/polybar/get_class.sh";
            initial = 1;
          };

          "module/bspwm" = {
            type = "internal/bspwm";
            pin-workspaces = true;
            inline-mode = false;
            enable-click = true;
            enable-scroll = true;
            reverse-scroll = true;
            fuzzy-match = false;
            occupied-scroll = false;
            ws-icon-default = "󰝦 ";
            format = "<label-state> <label-mode>";
            format-font = 2;
            label-monitor = "%name%";
            label-focused = "󰪥 ";
            label-focused-foreground = "\${colors.foreground}";
            label-occupied = "󰻃 ";
            label-occupied-foreground = "#bbebdbb2";
            label-urgent = "󰗖 ";
            label-urgent-foreground = "\${colors.secondary}";
            label-empty = "󰝦 ";
            label-empty-foreground = "\${colors.disabled}";
            label-separator = " ";
            label-separator-padding = 0;
            #label-monocle = ;
            #label-tiled = ;
            #label-fullscreen = ;
            #label-floating = ;
            #label-pseudotiled = P;
            #label-locked = ;
            #label-locked-foreground = #bd2c40;
            #label-sticky = ;
            #label-sticky-foreground = #fba922;
            #label-private = ;
            #label-private-foreground = #bd2c40;
            #label-marked = M;
          };
          
          "module/xkeyboard" = {
            type = "internal/xkeyboard";
            blacklist-0 = "num lock";
            blacklist-1 = "caps lock";
            label-indicator-background = "\${colors.secondary}";
            label-indicator-foreground = "\${colors.background}";
            label-indicator-margin = 1;
            label-indicator-padding = 2;
            label-layout = "􀺑 %layout%";
            label-layout-foreground = "\${colors.primary}";
          };

          "module/audio-output" = {
            type = "custom/script";
            tail = true;
            label-foreground = "\${colors.foreground}";

            exec = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --icons-volume \"􀊡 , 􀊥 , 􀊧 , 􀊩 ,\" --icon-muted \"􀊣 \" --node-nickname \"alsa_output.pci-0000_0b_00.4.analog-stereo:(􀟶  Speakers)\" --node-nickname \"alsa_output.usb-Focusrite_iTrack_Solo-00.analog-stereo:(􀺹  Headphones)\" listen";
            click-left = "exec pavucontrol -t 3 &";
            click-middle = "~/dots/lib/scripts/polybar/pulseaudio_control.sh togmute";
            click-right = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --node-blacklist \"alsa_output.pci-0000_09_00.1.hdmi-stereo\" next-node";
            scroll-up = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --volume-max 100 up";
            scroll-down = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --volume-max 100 down";
          };

          "module/audio-input" = {
            type = "custom/script";
            tail = true;
            label-foreground = "\${colors.foreground}";

            exec = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --node-type 'input' --icons-volume \"\" --icon-muted \"\" --node-nickname \"alsa_input.usb-Focusrite_iTrack_Solo-00.analog-stereo:(􀑫  Microphone)\" --node-blacklist \"alsa_output.pci-0000_09_00.1.hdmi-stereo.monitor\",\"alsa_output.usb-Focusrite_iTrack_Solo-00.analog-stereo.monitor\",\"alsa_output.pci-0000_0b_00.4.analog-stereo.monitor\" listen";
            click-left = "exec pavucontrol -t 4 &";
            click-middle = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --node-type 'input' togmute";
            click-right = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --node-type 'input' next-node";
            scroll-up = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --node-type 'input' --volume-max 100 up";
            scroll-down = "~/dots/lib/scripts/polybar/pulseaudio_control.sh --node-type 'input' --volume-max 100 down";
          };

          "module/audio" = {
            type = "internal/pulseaudio";
            sink = "alsa_output.pci-0000_0b_00.4.analog-stereo";
            format-volume = "<ramp-volume> <label-volume>";
            label-muted = "􀊣 muted";
            label-muted-foreground = "\${colors.primary}";
            ramp-volume-0 = "􀊡 "; 
            ramp-volume-1 = "􀊥 ";
            ramp-volume-2 = "􀊧 ";
            ramp-volume-3 = "􀊩 ";
            click-left = "pavucontrol";
            click-right = "pavucontrol";
            click-middle = "pamixer --toggle-mute";
            interval = 5;
          };
          
          "module/network" = {
            type = "internal/network";
            interface = "wlp4s0";
            interval = 1;

            format-connected = "<ramp-signal> <label-connected>";
            format-connected-background = "\${colors.background}";
            format-connected-padding = 0;
            label-connected = "%{A1:pkill nm-applet; nm-applet &:}%essid%%{A}";
            ramp-signal-0 = "􀙇";
            ramp-signal-1 = "􀙇";
            ramp-signal-2 = "􀙇" ;

            format-disconnected = "<label-disconnected>";
            format-disconnected-prefix = "睊";
            format-disconnected-background = "\${colors.background}";
            format-disconnected-padding = 0;
            label-disconnected = "%{A1:nm-applet &:} Offline%{A}";
          };
          
          "module/date" = {
            type = "internal/date";
            date = "%a %b %e, %H:%M";
            date-alt = "%a %b %e, %I:%M %P";
            label = "%date%";
            label-foreground = "\${colors.primary}";
            interval = 1;
          };
          
          "settings" = {
            screenchange-reload = true;
            pseudo-transparency = false;
          };
      
        };

        script = ''
          #${pkgs.polybar}/bin/polybar-msg cmd quit
          #
          #echo "---" | tee -a /tmp/polybar.log
          #${pkgs.polybar}/bin/polybar example 2>&1 | tee -a /tmp/polybar.log & disown
          #echo "Bars launched..."
        '';
      };
    };
  };
}
