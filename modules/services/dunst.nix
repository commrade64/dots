{ config, lib, pkgs, vars, ... }: {
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${vars.username} = {
      home.packages = [ pkgs.libnotify ];
      services.dunst = {
        enable = true;
      };
    };
  };
}
