{ config, pkgs, vars, ... }: let
  autostart = import ../../lib/scripts/general/autostart.nix { inherit pkgs; };
  set_wall = import ../../lib/scripts/general/set_wall.nix { inherit pkgs; };
  zaread = import ../../lib/scripts/general/zaread.nix { inherit pkgs; };
in {
  home-manager.users.${vars.username} = {
    home.packages = [
      autostart
      set_wall
      # zaread
    ];
  };
}
