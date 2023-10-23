{ config, lib, pkgs, vars, ...}: {
  home-manager.users.${vars.username} = {
    home.packages = with pkgs; [
      alsa-utils
      btop
      #eza
      feh
      #ffmpeg
      fzf
      jaq
      jq
      killall
      #lf
      neofetch
      pciutils
      playerctl
      ripgrep
      #rsync
      unrar
      unzip
      usbutils
      zip
      zoxide
    ];
  };
}
