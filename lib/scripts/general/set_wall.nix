{ pkgs }:

pkgs.writeShellScriptBin "set_wall" ''
  # path to a wallpapers directory
  path="$HOME/pictures/wallpapers"

  img=$(find $path -name "$1.*")
  if [[ -z "$1" ]] || [[ -z "$img" ]]; then
      img="$path/default"
  fi

  # ${pkgs.swww}/bin/swww img $img
  ${pkgs.feh}/bin/feh --bg-fill $img
''
