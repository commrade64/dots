{ config, lib, ... }: with lib; {
  options = {
    bluetooth = {
      enable = mkOption {
        type = types.bool;
	default = false;
      };
    };
  };

  config = lib.mkIf (config.bluetooth.enable) {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General= {
	  Enable = "Source,Sink,Media,Socket";
	};
      };
    };
    services.blueman.enable = true;
  };
}
