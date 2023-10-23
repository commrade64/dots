{ pkgs, vars, ... }: {
  home-manager.users.${vars.username} = {
    qt = {
      enable = true;
      platformTheme = "gtk";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
