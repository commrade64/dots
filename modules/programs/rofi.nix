{ config, lib, pkgs, home-manager, vars, ... }: {
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${vars.username} = {
      programs.rofi = {
        enable = true;
      };
    };
  };
}
