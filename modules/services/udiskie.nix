{ config, lib, pkgs, vars, ...}: {
  home-manager.users.${vars.username} = {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
  };
}
