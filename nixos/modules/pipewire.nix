{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.pipewire;
in {
  meta = {};

  imports = [];

  options = {
    services.pipewire = {
      # already declared in nixos/modules/pipewire.nix
      # enable = mkEnableOption "Whether to enable pipewire service.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alsa-utils # Advanced Linux Sound Architecture utils
    ];

    hardware.pulseaudio.enable = false;

    # The PipeWire daemon can be configured to be both an audio server (with
    # PulseAudio and JACK features) and a video capture server.
    # https://nixos.wiki/wiki/PipeWire
    services.pipewire = {
      # Enable ALSA support
      alsa.enable = true;
      alsa.support32Bit = true;
      # Enable JACK audio emulation
      # jack.enable = true;
      # Enable PulseAudio server emulation
      pulse.enable = true;
    };

    # When PipeWire is enabled, the docs recommend to enable a RealtimeKit system service.
    security.rtkit.enable = true;
  };
}
