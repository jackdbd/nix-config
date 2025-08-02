{pkgs, ...}: let
  bibataCursors = pkgs.bibata-cursors; # A popular Catppuccin-compatible cursor theme
  catppuccinGtkMocha = pkgs.catppuccin-gtk.override {
    accents = ["blue"];
    size = "standard";
    variant = "mocha";
  };
  catppuccinPapirusMochaIcons = pkgs.catppuccin-papirus-folders.override {
    accent = "blue";
    flavor = "mocha";
  };
  # Fetch a wallpaper from a public URL. This is the declarative way to
  # include external files in the Nix store. The SHA256 hash ensures integrity.
  greeterBackground = pkgs.fetchurl {
    # https://github.com/orangci/walls-catppuccin-mocha (right click, copy image address)
    url = "https://github.com/orangci/walls-catppuccin-mocha/blob/40912e6418737e93b59a38bcf189270cbf26656d/abandoned-trainstation.jpg?raw=true";
    sha256 = "sha256-o63nf2+x3/FAOFlHEBpZuciT3CIxCZBfQn/bEPawmQQ=";
  };
in {
  meta = {
    # TODO: I don't know why, but NixOS tells me meta.description does not exist.
    # description = "A custom NixOS module for configuring LightDM with Catppuccin themes.";
    # longDescription = ''
    #   This module provides a simple way to configure LightDM with the
    #   Catppuccin theme. It includes a selection of popular cursor and
    #   icon themes, as well as a GTK theme that matches the Catppuccin
    #   aesthetic.
    # '';
    # license = pkgs.lib.licenses.mit;
  };

  imports = [];

  options = {};

  config = {
    # Install a few themes system-wide (i.e. for all users and services).
    environment.systemPackages = [
      bibataCursors
      catppuccinGtkMocha
      catppuccinPapirusMochaIcons
    ];

    # Enables autologin. See also here to configure a fingerprint reader.
    # https://timothymiller.dev/posts/2024/auto-login-with-nixos-and-kde-plasma/
    # services.displayManager = {
    #   autoLogin.enable = true;
    #   autoLogin.user = "jack";
    # };

    services.xserver = {
      # Explicitly enable the X server, as LightDM is an X11 display manager.
      enable = true;

      # This is needed to ensure the GTK themes are correctly picked up by the
      # LightDM greeter and other GTK applications.
      desktopManager.xfce.enable = true; # Or another GTK-based DE

      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/display-managers/lightdm.nix
      # https://wiki.archlinux.org/title/LightDM
      # lightdm --show-config
      displayManager.lightdm = {
        enable = true;

        background = greeterBackground;

        extraConfig = ''
          [greeter]
          background = ${greeterBackground}
        '';

        # The default greeter is 'lightdm-gtk-greeter', but 'slick' has more
        # theming options.
        greeters.slick = {
          enable = true;
          draw-user-backgrounds = true;

          theme = {
            name = "Catppuccin-Mocha";
            package = catppuccinGtkMocha;
          };

          iconTheme = {
            name = "Catppuccin-Papirus-Mocha";
            package = catppuccinPapirusMochaIcons;
          };

          cursorTheme = {
            name = "Bibata";
            package = bibataCursors;
          };
        };
      };
    };
  };
}
