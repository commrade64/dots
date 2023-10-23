{ config, pkgs, vars, ... }: {
  home-manager.users.${vars.username} = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
    };

    services.emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
      client.enable = true;
    };
  };
}
