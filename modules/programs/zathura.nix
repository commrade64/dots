{ pkgs, vars, ... }: {
  home-manager.users.${vars.username} = {
    programs.zathura = {
      enable = true;
      package = pkgs.zathura;
      options = {
        recolor = true;
        recolor-lightcolor = "#000000";
        recolor-darkcolor = "#ffffff";
  
        default-bg = "#000000";
        default-fg = "#ffffff";
        render-loading = true;
        render-loading-bg = "#000000";
        render-loading-fg = "#ffffff";
  
        highlight-color = "#fec43f";
        highlight-active-color = "#db7b5f";
  
        statusbar-bg = "#1e1e1e";
        statusbar-fg = "#c6daff";
  
        inputbar-bg = "#000000";
        inputbar-fg = "#ffffff";
  
        index-bg = "#1e1e1e";
        index-fg = "#c6daff";
        index-active-bg = "#82b0ec";
        index-active-fg = "#1e1e1e";
  
        completion-bg = "#1e1e1e";
        completion-fg = "#ffffff";
        completion-group-bg = "#1e1e1e";
        completion-group-fg = "#5c5c5c";
        completion-highlight-bg = "#82b0ec";
        completion-highlight-fg = "#1e1e1e";
  
        notification-error-bg = "#000000";
        notification-error-fg = "#ff5f59";
        notification-warning-bg = "#000000";
        notification-warning-fg = "#fec43f";
        notification-bg = "#000000";
        notification-fg = "#9cbd6f";
      };
      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
        r = "reload";
        R = "rotate";
        K = "zoom in";
        J = "zoom out";
        p = "print";
        g = "goto top";
      };
    };
  };
}
