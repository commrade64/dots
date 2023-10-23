{  config, lib, pkgs, inputs, vars, ... }: {
  imports = (import ../modules/desktops ++
             import ../modules/editors ++
             import ../modules/hardware ++
             import ../modules/programs ++
             import ../modules/services ++
             import ../modules/shell ++
             import ../modules/theming);

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" "video" "users" "wheel" ];
    # Add SSH public key(s) here
    openssh.authorizedKeys.keys = [];
  };

  networking = {
    networkmanager.enable = true;

    #firewall = {
    #  enable = true;
    #  # Open ports in the firewall
    #  allowedTCPPorts = [ ... ];
    #  allowedUDPPorts = [ ... ];
    #};

    #proxy = {
    #  default = "http://user:password@proxy:port/";
    #  noProxy = "127.0.0.1,localhost,internal.domain";
    #};
  };

  time.timeZone = "Europe/Kyiv";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  hardware = {
    # Disable PulseAudio
    pulseaudio.enable = lib.mkForce false;
  };

  # Disable ALSA
  sound.enable = lib.mkForce false;

  security = {
    polkit.enable = true;
    rtkit.enable = true;                   
  };

  services = {
    # DBus
    dbus = {
      enable = true;
    };

    # SSH
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";         # forbid root login through ssh
        PasswordAuthentication = false; # keys-only authentication
      };
      allowSFTP = true; # SFTP: secure file transfer protocol (sending files to a server)
    };

    # PipeWire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # USB
    devmon.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;

    # Power
    upower = {
      enable = true;
    };
  };

  programs = {
    dconf.enable = true;
  };

  environment = {
    variables = {
      # User-variables
      CC = "gcc";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
      TERMINAL = "${vars.terminal}";
      BROWSER = "${vars.browser}";

      # XDG Specification
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Some FreeType settings
      FREETYPE_PROPERTIES="truetype:interpreter-version=35 autofitter:no-stem-darkening=0";

      # Clean up ~
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      GOPATH = "$HOME/.local/share/go";
      GOMODCACHE = "$HOME/.cache/go/mod";
      LESSHISTFILE = "$HOME/.cache/less/history";
      XINITRC="$XDG_CONFIG_HOME/x11/xinitrc";
      WGETRC="$XDG_CONFIG_HOME/wgetrc";
      XCOMPOSEFILE="$XDG_CONFIG_HOME/X11/xcompose";
      XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose";
    };

    systemPackages = with pkgs; [
      # Libraries
      alsaLib
      glib
      glibc
      libgcc
      libcxx
      libllvm

      # Utilities
      coreutils
      git
      lxde.lxsession
      pamixer
      pulseaudio
      wget

      # C/C++ toolchain
      clang-tools
      gcc
      gnumake
      lld
      llvmPackages.bintools
      pkg-config
      udev

      # LaTeX
      texlive.combined.scheme-full
      tectonic

      # Go
      go 

      # Python
      python3

      # Rust
      cargo
      rustc
    ];
  };

  fonts = {
    packages = with pkgs; [
      cm_unicode
      corefonts                                              # microsoft fonts
      font-awesome                                           # icon font
      # helvetica-neue-lt-std                                  # free version of Helvetica Neue
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro      # apple's 'San Francisco' font family
      inputs.sf-mono-liga.packages.${pkgs.system}.sf-mono-liga
      inputs.apple-fonts.packages.${pkgs.system}.sf-arabic   
      inputs.apple-fonts.packages.${pkgs.system}.sf-symbols   
      inputs.apple-fonts.packages.${pkgs.system}.ny          # apple's 'New York' font family
      material-design-icons
      noto-fonts-cjk
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = false;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      defaultFonts = {
        serif = [ "CMU Serif" ".SF Symbols Fallback" "Material Design Icons"  "Apple Color Emoji" ];
        sansSerif = [ "SF Pro Display" ".SF Symbols Fallback" "Material Design Icons" "Apple Color Emoji" ];
        monospace = [ "CaskaydiaCove Nerd Font" "Material Design Icons" ".SF Symbols Fallback" "Apple Color Emoji" ];
        emoji = [ "Apple Color Emoji" ];
      };
      localConf = ''
      <match target="font">
        <test name="family" qual="any">
          <string>monospace</string>
          <!-- other fonts here .... -->
        </test>
        <edit name="embolden" mode="assign">
          <bool>true</bool>
        </edit>
      </match>
      '';
    };
  };

  nix = {
    # Add each flake input as a registry (making nix3 commands consistent with our flake)
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add our inputs to the system's legacy channels (making legacy nix commands consistent as well)
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Some Nix options
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    # Garbage collector
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (import inputs.emacs-overlay)
    ]; 
  };

  #systemd = {
  #  user.services.polkit-gnome-authentication-agent-1 = {
  #    description = "polkit-gnome-authentication-agent-1";
  #    wantedBy = [ "graphical-session.target" ];
  #    wants = [ "graphical-session.target" ];
  #    after = [ "graphical-session.target" ];
  #    serviceConfig = {
  #      Type = "simple";
  #      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #      Restart = "on-failure";
  #      RestartSec = 1;
  #      TimeoutStopSec = 10;
  #    };
  #  };
  #  sleep.extraConfig = ''
  #    AllowSuspend=yes
  #    AllowHibernation=no
  #    AllowSuspendThenHibernate=no
  #    AllowHybridSleep=yes
  #  '';
  #};

  system.stateVersion = "23.11";

}
