{
  allowed-unfree-packages,
  config,
  favorite-browser,
  lib,
  pkgs,
  ...
}: let
  username = "jack";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config"; # equivalent to config.xdg.configHome
in {
  imports =
    [
      ../modules/activitywatch.nix
      ../modules/chromium-wrapper.nix
      ../modules/flameshot.nix
      ../modules/lockscreen.nix
      ../modules/xfconf.nix
    ]
    ++ lib.concatMap import [
      ../programs
      ../scripts
    ];

  home = {
    inherit homeDirectory username;

    # In case of a version mismatch between Nixpkgs and Home Manager, you can
    # silence it by setting enableNixpkgsReleaseCheck to false.
    enableNixpkgsReleaseCheck = true;

    file = {
      "${config.xdg.configHome}/gcloud/configurations/config_calderone".source = ../../dotfiles/gcloud-configurations/config_calderone.ini;
      "${config.xdg.configHome}/gcloud/configurations/config_virtual_machines".source = ../../dotfiles/gcloud-configurations/config_virtual_machines.ini;
      "${config.xdg.configHome}/gcloud/configurations/config_website_audit".source = ../../dotfiles/gcloud-configurations/config_website_audit.ini;
      "${config.xdg.configHome}/liferea/feedlist.opml".source = ../../dotfiles/liferea/feedlist.opml;
      "${config.xdg.configHome}/neofetch/config.conf".source = ../../dotfiles/neofetch.conf;
      "${homeDirectory}/.npmrc".source = ../../dotfiles/npmrc.ini;
    };

    packages = with pkgs; [
      asciinema # record the terminal
      babashka # Clojure interpreter for scripting
      betterlockscreen # lock screen
      bless # HEX editor
      buildah # build OCI images (alternative to docker build)
      calibre # e-book reader
      chromium
      clojure
      ctop # top-like interface for container metrics
      curl
      darktable # virtual lighttable and darkroom for photographers
      (writeShellScriptBin "debug-home-manager" ''
        printf "=== DEBUG HOME MANAGER ===\n"
        echo "favorite-browser is ${favorite-browser}"
        echo "config.home.username is ${config.home.username}"
        echo "config.home.homeDirectory is ${config.home.homeDirectory}"
        echo "username is ${username}"
        echo "homeDirectory is ${homeDirectory}"
        echo "configHome is ${configHome}"
      '')
      difftastic # syntax-aware diff
      dive # explore the layers of a container image
      emojione # open source emoji set
      entr # file watcher
      exif # read and manipulate EXIF data in digital photographs
      ffmpeg
      ffuf
      firefox
      flameshot
      fx
      gh
      gimp
      glow # terminal markdown viewer
      go
      google-chrome
      google-cloud-sdk # Google Cloud Platform CLI (gcloud)
      graphviz
      haskellPackages.boring-game
      hyperfine # command-line benchmarking tool
      inkscape
      jq
      killall # kill processes by name or list PIDs
      liferea # RSS reader
      lsix # shows thumbnails in terminal using sixel graphics
      luajitPackages.fennel
      monolith
      neofetch
      nix-index # locate packages containing certain nixpkgs
      nix-output-monitor # nom: monitor nix commands
      nuclei
      openshot-qt # video editor
      newman
      nodejs_21
      papirus-icon-theme
      pgadmin4
      pinta
      pitivi # video editor
      podman
      poke
      # postman # https://github.com/NixOS/nixpkgs/issues/259147
      prettyping # a nicer ping
      pulumi
      qemu
      ripgrep-all
      rlwrap
      rm-improved
      sameboy # Game Boy emulator
      s-tui # Stress-Terminal UI monitoring tool (requires stress for some features)
      screenkey # shows keypresses on screen
      (writeShellApplication {
        name = "show-nixos-org";
        runtimeInputs = [curl w3m];
        text = ''
          curl -s 'https://nixos.org' | w3m -dump -T text/html
        '';
      })
      silver-searcher
      simplescreenrecorder # screen recorder gui
      sqlite
      sqlitebrowser
      stegseek # tool to crack steganography
      stress # workload generator for POSIX systems (required by s-tui)
      stripe-cli
      temurin-bin-18
      thunderbird
      tmux
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
      tokei
      vlc
      vscode
      w3m
      wasmtime
      wget
      wireshark
      xsv # index/slice/analyze/split/join CSV files
      yt-dlp
      zathura
      zeal
      zig
      zls
    ];

    # Environment variables
    sessionVariables = {
      BROWSER = "${lib.getExe pkgs.google-chrome}";
      EDITOR = "nvim";
    };

    # Do NOT change the value of stateVersion, even if you update Home Manager.
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";
  };

  programs.chromium-wrapper.enable = true;
  programs.chromium-wrapper.should-install-extensions = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # I had the same issue about home-manager manual described here. The solution
  # looks proposed in the thread seems to work.
  # https://discourse.nixos.org/t/starting-out-with-home-manager/31559
  # manual.manpages.enable = false;

  # https://nix-community.github.io/home-manager/options.html#opt-nixpkgs.config
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  services.activitywatch.extraOptions = ["--verbose"];

  # For blueman-applet to work, the blueman service must be enabled system-wide.
  # https://nixos.wiki/wiki/Bluetooth#Pairing_Bluetooth_devices
  services.blueman-applet.enable = true;

  services.lockscreen.not-when-audio = true;
  services.lockscreen.not-when-fullscreen = true;

  # Restart systemd services on change
  systemd.user.startServices = "sd-switch";
}
