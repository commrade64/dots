{ config, pkgs, lib, vars, ... }: {
  config = lib.mkIf (config.desktop.enable) {
    home-manager.users.${vars.username} = {
      programs.obs-studio = {
        enable = true;
        #plugins = with pkgs.obs-studio-plugins; [
        #  wlrobs
        #];
      };
    };
  };
}
