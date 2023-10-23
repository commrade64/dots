{ config, pkgs, vars, ... }:let
  gruvbox-plus-icons = import ./gruvbox-plus-icons.nix { inherit pkgs; };
in {
  home-manager.users.${vars.username} = {
    home.pointerCursor = {
      package = pkgs.apple-cursor;
      name = "macOS-Monterey";
      size = 16;
      gtk.enable = true;
      x11 = {
        enable = true;
        defaultCursor = "left_ptr";
      };
    };
    
    gtk = {
      enable = true;
  
      font = {
        name = "SF Pro Display";
        size = 12;
      };
  
      theme = {
        name = "Gruvbox-Dark-BL";
        package = pkgs.gruvbox-gtk-theme;
      };
      
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = gruvbox-plus-icons;
      };
  
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS-Monterey";
        size = 16;
      };
  
      gtk2.configLocation = "/home/${vars.username}/.config/gtk-2.0/gtkrc";
    };
  };
}
