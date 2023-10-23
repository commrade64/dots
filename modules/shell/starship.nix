{ config, pkgs, vars, ...}: {
  home-manager.users.${vars.username} = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;

        character = {
          success_symbol = "[∮ ](bold blue)";
          error_symbol = "[∮ ](bold red)";
          vimcmd_symbol = "[λ ](bold blue)";
        };

        # single-line prompt (finally)
        line_break = {
          disabled = true;
        };
      };
    };
  };
}
