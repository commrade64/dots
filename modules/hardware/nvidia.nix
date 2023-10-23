{ config, lib, pkgs, ... }: with lib; {
  options = {
    nvidia = {
      enable = mkOption {
        type = types.bool;
	default = false;
      };
    };
  };

  config = lib.mkIf (config.nvidia.enable) {
    boot = {
      kernelModules = [ "nvidia" "nvidia_modeset" ];
    };

    environment = {
      variables = {
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "0";
      };
    };

    services = {
      xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
    };

    hardware = {
      nvidia = {
        open = false;
        nvidiaSettings = true;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
      opengl = {
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
          nvidia-vaapi-driver
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
  };
}
