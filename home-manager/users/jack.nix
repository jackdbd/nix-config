{
  allowed-unfree-packages,
  config,
  favorite-browser,
  lib,
  permitted-insecure-pakages,
  pkgs,
  ...
}: let
  username = "jack";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config"; # equivalent to config.xdg.configHome
in {
  imports =
    [
      ../modules/atuin
      ../modules/bash.nix
      ../modules/chromium.nix
      ../modules/direnv.nix
      ../modules/flameshot.nix
      ../modules/git.nix
      ../modules/gnome-keyring.nix
      # ../modules/hyprland.nix
      ../modules/lockscreen.nix
      ../modules/rssguard
      ../modules/starship.nix
      ../modules/tmux
      ../modules/vscode
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
      "${config.xdg.configHome}/neofetch/config.conf".source = ../../dotfiles/neofetch.conf;
      "${homeDirectory}/.npmrc".source = ../../dotfiles/npmrc.ini;
    };

    packages = with pkgs; [
      age # encryption tool
      alacritty # Open GL terminal emulator
      asciinema # record the terminal
      awscli2 # AWS CLI
      awsls # list command for AWS resources
      awsume # utility for assuming AWS IAM roles from the command line
      babashka # Clojure interpreter for scripting
      baobab # disk usage utility
      bless # HEX editor
      bruno # IDE for exploring/testing APIs (Postman/Insomnia alternative)
      buildah # build OCI images (alternative to docker build)
      burpsuite # suite of tools for web application security
      calibre # e-book reader
      clojure
      ctop # top-like interface for container metrics
      curl
      darktable # virtual lighttable and darkroom for photographers
      dbeaver-bin # GUI for many SQL databases https://dbeaver.io/about/
      ddrescue # data recovery tool (I also use it to burn an ISO to a USB flash drive)
      ddrescueview # Graphical viewer for GNU ddrescue mapfiles
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
      # emojione # open source emoji set TODO: this failed to build on 2024/07/25
      entr # file watcher
      exif # read and manipulate EXIF data in digital photographs
      eza # fork of exa, a better `ls`
      fd # a better `find`
      feh # image viewer
      ffmpeg
      ffuf # tool for web fuzzing and content discovery
      file # show the type of files
      firefox
      flyctl # Fly.io CLI
      fx # JSON viewer
      gh # GitHub CLI
      gimp # image editor
      glow # terminal markdown viewer
      gnumake # GNU Make (build tool)
      go
      google-chrome
      google-cloud-sdk # Google Cloud Platform CLI (gcloud)
      graphviz
      hyperfine # command-line benchmarking tool
      inkscape # vector graphics editor
      jq # JSON processor
      killall # kill processes by name or list PIDs
      kitty # GPU-based terminal emulator
      libreoffice # a variant of openoffice.org
      lm_sensors # tools for reading hardware sensors
      lshw # detailed information on the hardware configuration of the machine
      lsix # shows thumbnails in terminal using sixel graphics
      luajitPackages.fennel # Lisp that compiles to Lua
      meld # visual diff and merge tool
      monolith # save a web page as a single HTML file
      mtr # network diagnostics tool (basically traceroute + ping)
      ncdu # disk usage utility
      neil # CLI to add common aliases and features to deps.edn-based projects (e.g. Clojure, ClojureScript)
      neofetch
      nix-index # locate packages containing certain nixpkgs (TODO: does it work with flakes?)
      nix-output-monitor # nom: monitor nix commands (TODO: does it work with flakes?)
      nodePackages.node-gyp # Node.js native addon build tool
      nodePackages.wrangler # Cloudflare Workers CLI
      nuclei # vulnerability scanner
      ocrmypdf # adds an OCR text layer to scanned PDF files, allowing them to be searched (e.g. with ripgrep-all)
      openshot-qt # video editor
      ouch #  compress/decompress files and directories
      newman # Postman collection runner
      nodejs_22
      papirus-icon-theme
      pgadmin4
      pinta # image editor
      pitivi # video editor
      podman # docker run alternative
      poke # editor for binary data
      # postman # https://github.com/NixOS/nixpkgs/issues/259147
      prettyping # a nicer ping
      procs # a better `ps`
      pstree # show the set of running processes as a tree
      pulumi # infrastructure as code
      pulumiPackages.pulumi-language-nodejs
      python3
      qemu # machine & userspace emulator and virtualizer
      remmina # remote desktop client
      ripgrep-all # ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, etc
      rlwrap
      rm-improved
      rofi # application launcher & window switcher
      s-tui # Stress-Terminal UI monitoring tool (requires stress for some features)
      sakura # terminal emulator
      sameboy # Game Boy emulator
      screenkey # shows keypresses on screen
      sd # sed alternative
      (writeShellApplication {
        name = "show-nixos-org";
        runtimeInputs = [curl w3m];
        text = ''
          curl -s 'https://nixos.org' | w3m -dump -T text/html
        '';
      })
      silver-searcher # grep alternative
      simplescreenrecorder # screen recorder gui
      sqlite
      sqlitebrowser
      steghide # steganography tool for images and audio files
      stegseek # tool to crack steganography
      stress # workload generator for POSIX systems (required by s-tui)
      stripe-cli
      supabase-cli
      temurin-bin # Eclipse Temurin, prebuilt OpenJDK binary
      thunderbird # email client
      tokei # display statistics about your code
      transmission_3 # BitTorrent client
      trash-cli # alternative to rm
      # trashy # alternative to rm and trash-cli (not working?)
      unzrip # unzip replacement with parallel decompression
      usbutils # tools for working with USB devices, such as lsusb
      # v8 # JavaScript engine used in Node.js, Chromium, etc
      visidata # CLI for Exploratory Data Analysis
      vlc
      volta # JavaScript Tool Manager (nvm alternative)
      w3m # text-based web browser
      wabt # WebAssembly binary toolkit
      wasmtime # WASI runtime
      wget
      wireshark
      xsv # index/slice/analyze/split/join CSV files
      yarr # Yet another rss reader
      yt-dlp
      zathura # PDF viewer
      zeal # offline documentation browser
      zig
      zls # Zig language server
      zx # Tool for writing scripts using JavaScript
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

  programs.atuin.enable = true;
  programs.bash.enable = true;

  programs.chromium = {
    enable = true;
    enable-octotree = false;
  };

  programs.direnv.enable = true;
  programs.git.enable = true;

  # Let Home Manager install and manage itself.
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/home-manager.nix
  programs.home-manager.enable = true;

  programs.rssguard.enable = true;

  programs.starship.enable = true;

  programs.tmux.enable = true;

  programs.vscode.enable = true;

  # https://mipmip.github.io/home-manager-option-search/?query=nixpkgs
  nixpkgs.config = {
    # allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
    permittedInsecurePackages = permitted-insecure-pakages;
  };

  services.activitywatch = {
    enable = true;
    # https://nix-community.github.io/home-manager/options.xhtml#opt-services.activitywatch.watchers
    # https://docs.activitywatch.net/en/latest/configuration.html
    watchers = {
      aw-watcher-afk = {
        package = pkgs.activitywatch;
        settings = {
          poll_time = 5;
          timeout = 180;
        };
      };

      aw-watcher-window = {
        package = pkgs.activitywatch;
        settings = {
          exclude_title = false;
          poll_time = 1;
        };
      };
    };
  };

  # For blueman-applet to work, the blueman service must be enabled system-wide.
  # https://nixos.wiki/wiki/Bluetooth#Pairing_Bluetooth_devices
  services.blueman-applet.enable = true;

  services.gnome-keyring.enable = true;

  services.lockscreen.not-when-audio = true;
  services.lockscreen.not-when-fullscreen = true;

  # Restart systemd services on change
  systemd.user.startServices = "sd-switch";
  
  # This is a workaround to avoid the error "Unit tray.target not found" on some systemd units (e.g. blueman, flameshot)
  # https://github.com/nix-community/home-manager/issues/2064#issuecomment-887300055
  # TODO: remove this workaround as soon the issue is fixed
  systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};

  # https://mipmip.github.io/home-manager-option-search/?query=xsession
  # https://github.com/nix-community/home-manager/blob/8b797c8eea1eba7dfb47f6964103e6e0d134255f/modules/xsession.nix#L165
  # xsession.enable = true;
}
