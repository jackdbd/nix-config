{ config, pkgs, ... }:

{
  # Configuration for Chromium and its extensions
  # https://codeberg.org/davidak/nixos-config/src/branch/main/profiles/desktop.nix
  # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/chromium.nix
  # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/extensions.nix
  programs.chromium = {
    enable = true;

    # https://nix-community.github.io/home-manager/options.html#opt-programs.chromium.commandLineArgs
    commandLineArgs = [];

    # https://nix-community.github.io/home-manager/options.html#opt-programs.chromium.extensions
    extensions = [
      # Consent-O-Matic
      { id = "mdjildafknihdffpkfmmpnpoiajfjnjd"; }
      # Google Arts & Culture
      { id = "akimgimeeoiognljlfchpbkpfbmeapkh"; }
      # Lastpass
      { id = "hdokiejnpimakedhajhdlcegeplioahd"; }
      # SponsorBlock for YouTube
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
      # Terms of Service; Didn't Read
      { id = "hjdoplcnndgiblooccencgcggcoihigg"; }
      # Tmetric (time tracker)
      { id = "ffijoclmniipjbhecddgkfpdafpbdnen"; }
      # Vimium
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
    ];
  };
}