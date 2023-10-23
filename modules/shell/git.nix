{ config, pkgs, vars, ...}: {
  home-manager.users.${vars.username} = {
    programs.git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        user = {
          name = "Sviatoslav Liashenko";
          email = "sweathrtx@gmail.com";
        };
      };
    };
  };
}
