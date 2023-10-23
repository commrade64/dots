{ config, lib, pkgs, vars, ... }: {
  home-manager.users.${vars.username} = {
    home.packages = [ pkgs.xdg-utils ];
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = [ "zathura.desktop" ];
          "image/*" = [ "feh.desktop" ];
          "video/png" = [ "mpv.desktop" ];
          "video/jpg" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.desktop" ];
        };
      };
      userDirs = {
        enable = true;
        createDirectories = true;
	desktop = "/home/${vars.username}";
	music = "/home/${vars.username}";
	publicShare = "/home/${vars.username}";
	templates = "/home/${vars.username}";

        documents = "/home/${vars.username}/docs";
        download = "/home/${vars.username}/downloads";
        pictures = "/home/${vars.username}/pictures";
        videos = "/home/${vars.username}/videos";
      };
    };  
  };
}
