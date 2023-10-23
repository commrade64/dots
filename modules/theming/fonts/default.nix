{ config, pkgs, vars, ... }: {
  home-manager.users.${vars.username} = { 
    home.file = {
      ".local/share/fonts/ttf/AppleColorEmoji.ttf".source = ./apple-color-emoji/AppleColorEmoji.ttf;
      ".local/share/fonts/otf/Menlo-Regular-Full.otf".source = ./menlo/Menlo-Regular-Full.otf;
      ".local/share/fonts/ttf/Menlo-Regular-Full.ttf".source = ./menlo/Menlo-Regular-Full.ttf;
      # Helvetica Neue
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue-Bold.otf".source = ./helvetica-neue/HelveticaNeue-Bold.otf;
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue—Light.otf".source = ./helvetica-neue/HelveticaNeue-Light.otf;
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue—Medium.otf".source = ./helvetica-neue/HelveticaNeue-Medium.otf;
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue—RegularItalic.otf".source = ./helvetica-neue/HelveticaNeue-RegularItalic.otf;
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue—Regular.otf".source = ./helvetica-neue/HelveticaNeue-Regular.otf;
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue—Thin.otf".source = ./helvetica-neue/HelveticaNeue-Thin.otf;
      ".local/share/fonts/otf/helvetica-neue/HelveticaNeue—UltraLight.otf".source = ./helvetica-neue/HelveticaNeue-Ultralight.otf;
    };
  };
}
