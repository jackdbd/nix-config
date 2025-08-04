{
  config,
  inputs,
  lib,
  pkgs,
  user,
  ...
}:
with lib; {
  meta = {};

  imports = [];

  options = {};

  config.nix = {
    # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#reducing-disk-usage
    # If you really need to reclaim more space, consider manually trimming the generations with this script:
    # https://nixos.wiki/wiki/NixOS_Generations_Trimmer
    # https://www.reddit.com/r/NixOS/comments/16zli78/how_many_generations_do_you_have/
    gc = {
      automatic = true;
      # https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events
      # https://wiki.archlinux.org/title/systemd/Timers
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true;
    };

    # Recommended configuration for nixd
    # https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
    # https://youtu.be/M_zMoHlbZBY?si=GdjiJ4WitumJV8Eu&t=185
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    settings = {
      # Optimize storage
      # You can also manually optimize the store via:
      # nix-store --optimise
      # Refer to the following link for more details:
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      # TODO: Explain what the downsides of auto optimising the nix store are.
      auto-optimise-store = true;

      # Enable flakes, so we can avoid adding the flag --extra-experimental-features
      # every time we use the nix CLI (e.g. nix build, nix run, etc)
      # https://nixos.wiki/wiki/Flakes#Enable_flakes_permanently_in_NixOS
      experimental-features = ["nix-command" "flakes"];

      trusted-users = ["root" user];
    };
  };
}
