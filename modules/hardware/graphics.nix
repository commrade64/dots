{ config, pkgs, ... }: {
  # OpenGL (video accel + more)
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      glxinfo
    ];
  };
}
