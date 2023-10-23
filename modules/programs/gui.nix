{ config, pkgs, lib, vars, ... }: {
  config = lib.mkIf (config.x11wm.enable || config.wlwm.enable) {
    home-manager.users.${vars.username} = {
      home.packages = with pkgs; [
	keepassxc
        pavucontrol
	pcmanfm
	telegram-desktop
	#vlc
      ];
    };
  };
}
