{ config, lib, pkgs, ... }:

let
  username = "jack";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    activitywatch # time tracker
    asciinema # record the terminal
    babashka # Clojure interpreter for scripting
    betterlockscreen # lock screen
    bless # HEX editor
    buildah # build OCI images (alternative to docker build)
    calibre # e-book reader
    chromium
    clojure
    ctop # top-like interface for container metrics
    darktable # virtual lighttable and darkroom for photographers
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
    nerdfonts
    nix-index # locate packages containing certain nixpkgs
    nix-output-monitor # nom: monitor nix commands
    nuclei
    openshot-qt # video editor
    newman
    # nodejs_21
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
    rofi
    # TODO: I tried to use these rofi plugins but got collision errors with rofi-theme-selector
    # rofi-calc
    # rofi-top
    sameboy # Game Boy emulator
    s-tui # Stress-Terminal UI monitoring tool (requires stress for some features)
    screenkey # shows keypresses on screen
    stress # workload generator for POSIX systems (required by s-tui)
    silver-searcher
    simplescreenrecorder # screen recorder gui
    sqlite
    sqlitebrowser
    stegseek # tool to crack steganography
    stripe-cli
    syncthing
    temurin-bin-18
    thunderbird
    tmux
    tmuxPlugins.continuum
    tmuxPlugins.resurrect
    tokei
    vlc
    vscode
    wasmtime
    wget
    wireshark
    xsv # index/slice/analyze/split/join CSV files
    yt-dlp
    zathura
    zeal
    zig
    zls

    # note: there is no config.home.configHome because in this file I let `home` inherit only username and homeDirectory
    (writeShellScriptBin "debug-args" ''
      printf "Nix arguments:
      config.home.username is ${config.home.username}
      config.home.homeDirectory is ${config.home.homeDirectory}
      username is ${username}
      homeDirectory is ${homeDirectory}
      configHome is ${configHome}"
    '')
  ];
in
{
  # Let Home Manager install and manage itself.
  # Here are a few nice Home Manager configurations:
  # https://github.com/gvolpe/nix-config/tree/master/home
  # https://github.com/Misterio77/nix-starter-configs/tree/main/standard
  programs.home-manager.enable = true;

  imports = lib.concatMap import [
    ../programs
    ../scripts
    ../services
    ../xfconf
  ];

  home = {
    inherit username homeDirectory;

    # don't forget to add home-manager as a nix channel
    # https://nix-community.github.io/home-manager/index.html#sec-install-standalone
    # I forgot to do it, and I was getting this error:
    # error: file 'home-manager/home-manager/home-manager.nix' was not found in the Nix search path 
    # See the solutions suggested here:
    # https://github.com/nix-community/home-manager/issues/4060

    # TODO: at the moment I have a version mismatch between Nixpkgs and Home
    # Manager. I'm not sure whether I should pin the Nixpkgs's version, the Home
    # Manager's one, or both.
    enableNixpkgsReleaseCheck = false;

    file = {
      "${config.xdg.configHome}/neofetch/config.conf".source = ../dotfiles/neofetch.conf;
    };

    packages = defaultPkgs;

    # environment variables
    sessionVariables = {
      BROWSER = "${lib.getExe pkgs.google-chrome}";
      EDITOR = "nvim";
    };

    # Do NOT change the value of stateVersion, even if you update Home Manager.
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";
  };

  # I had the same issue about home-manager manual described here. The solution
  # looks proposed in the thread seems to work.
  # https://discourse.nixos.org/t/starting-out-with-home-manager/31559
  manual.manpages.enable = false;

  # https://nix-community.github.io/home-manager/options.html#opt-nixpkgs.config
  nixpkgs.config = {
    # I prefer to explicitly list all the unfree packages I am using.
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "postman"
      "google-chrome"
      "vscode"
    ];
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";
}
