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
      ../modules/atuin
      ../modules/chromium.nix
      ../modules/direnv.nix
      ../modules/flameshot.nix
      ../modules/liferea.nix
      ../modules/lockscreen.nix
      ../modules/tmux
      ../modules/vscode.nix
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
      babashka # Clojure interpreter for scripting
      baobab # disk usage utility
      bless # HEX editor
      buildah # build OCI images (alternative to docker build)
      calibre # e-book reader
      clojure
      ctop # top-like interface for container metrics
      curl
      darktable # virtual lighttable and darkroom for photographers
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
      emojione # open source emoji set
      entr # file watcher
      exif # read and manipulate EXIF data in digital photographs
      eza # fork of exa, a better `ls`
      fd # a better `find`
      feh # image viewer
      ffmpeg
      ffuf # tool for web fuzzing and content discovery
      firefox
      fx # JSON viewer
      gh # GitHub CLI
      gimp # image editor
      git-cola # git GUI
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
      lm_sensors # tools for reading hardware sensors
      lshw # detailed information on the hardware configuration of the machine
      lsix # shows thumbnails in terminal using sixel graphics
      luajitPackages.fennel # Lisp that compiles to Lua
      meld # visual diff and merge tool
      monolith # save a web page as a single HTML file
      mtr # network diagnostics tool (basically traceroute + ping)
      ncdu # disk usage utility
      neofetch
      nix-index # locate packages containing certain nixpkgs (TODO: does it work with flakes?)
      nix-output-monitor # nom: monitor nix commands (TODO: does it work with flakes?)
      nodePackages.node-gyp # Node.js native addon build tool
      nuclei # vulnerability scanner
      obsidian # notes / knowledge base
      openshot-qt # video editor
      ouch #  compress/decompress files and directories
      newman # Postman collection runner
      nodejs_21
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
      python3
      qemu # machine & userspace emulator and virtualizer
      remmina # remote desktop client
      ripgrep-all # ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, etc
      rlwrap
      rm-improved
      rofi # application launcher & window switcher
      rssguard # RSS/Atom feed reader with online synchronization
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
      starship # customizable prompt for any shell
      steghide # steganography tool for images and audio files
      stegseek # tool to crack steganography
      stress # workload generator for POSIX systems (required by s-tui)
      stripe-cli
      temurin-bin-18 # OpenJDK
      thunderbird # email client
      tokei # display statistics about your code
      transmission # BitTorrent client
      usbutils # tools for working with USB devices, such as lsusb
      vlc
      volta # avaScript Tool Manager (nvm alternative)
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

  programs.chromium = {
    enable = true;
    should-install-extensions = true;
  };

  programs.direnv.enable = true;

  # Let Home Manager install and manage itself.
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/home-manager.nix
  programs.home-manager.enable = true;

  programs.tmux.enable = true;

  programs.vscode.enable = true;

  # https://nix-community.github.io/home-manager/options.html#opt-nixpkgs.config
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;

    # Obsidian is build on Electron. I don't know why NixOS marks Electron as insecure.
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  services.activitywatch = {
    enable = true;
    client = {
      client = {
        commit_interval = 15;
      };
    };
  };

  # For blueman-applet to work, the blueman service must be enabled system-wide.
  # https://nixos.wiki/wiki/Bluetooth#Pairing_Bluetooth_devices
  services.blueman-applet.enable = true;

  services.lockscreen.not-when-audio = true;
  services.lockscreen.not-when-fullscreen = true;

  # Restart systemd services on change
  systemd.user.startServices = "sd-switch";

  # https://mipmip.github.io/home-manager-option-search/?query=xsession
  # https://github.com/nix-community/home-manager/blob/8b797c8eea1eba7dfb47f6964103e6e0d134255f/modules/xsession.nix#L165
  # xsession.enable = true;
}
