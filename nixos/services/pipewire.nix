{ config, lib, pkgs, ... }:

{
  imports = [];
  
  options = {};
  
  config = {
    # The PipeWire daemon can be configured to be both an audio server (with
    # PulseAudio and JACK features) and a video capture server.
    # https://nixos.wiki/wiki/PipeWire
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };
  };

  meta = {};
}
