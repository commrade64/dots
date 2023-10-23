{ pkgs, vars, ...}: {
  home-manager.users.${vars.username} = {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };

    # install language servers
    home.packages = with pkgs; [
      gopls
      lua-language-server
      nixd
      nodePackages.pyright
      nodePackages.typescript-language-server
      vscode-langservers-extracted
      rust-analyzer
      texlab
    ];
  };
}
