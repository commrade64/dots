{
  lib,
  config,
  ...
}:

{
  # Enable real-time kit (better experience)
  security.rtkit.enable = true;                   
  # Disable ALSA
  sound.enable = lib.mkForce false;
  # Disable PulseAudio
  hardware.pulseaudio.enable = lib.mkForce false;

  # Enable PipeWire
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
