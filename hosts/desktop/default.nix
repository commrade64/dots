{ lib, config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  desktop.enable = true;
  nvidia.enable = true;
  bspwm.enable = true;

  networking = {
    hostName = "desktop";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "pcspkr" ];
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
	efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
	device = "nodev";
	efiSupport = true;
	useOSProber = true;
	configurationLimit = 3;
      };
      timeout = 5;
    };
  };

  # environment = {
  #   loginShellInit = ''
  #     if [[ -z $DISPLAY ]] && [[ $(tty) == "/dev/tty1" ]]; then
  #       startx $XINITRC
  #     fi
  #   '';
  # };
}
