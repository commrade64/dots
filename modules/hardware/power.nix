{ lib, config, ... }: {
  config = lib.mkIf (config.laptop.enable) {
    services = {
      tlp.enable = true;
      auto-cpufreq.enable = true;
    };
  };
}
