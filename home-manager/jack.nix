{ config, lib, pkgs, ... }:

let
  username = "jack";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    activitywatch        # time tracker
    asciinema            # record the terminal
    alacritty            # terminal emulator
    babashka             # Clojure interpreter for scripting
    betterlockscreen     # lock screen
    bless                # HEX editor
    buildah              # build OCI images (alternative to docker build)
    calibre              # e-book reader
    chromium             #
    clojure              #
    ctop                 # top-like interface for container metrics
    difftastic           # syntax-aware diff
    dive                 # explore the layers of a container image
    duf
    dunst                # notification daemon
    emojione
    entr
    eza                  # a better `ls` (it's a fork of exa)
    fd
    feh
    ffmpeg
    ffuf
    firefox
    flameshot
    fx
    gh
    gimp
    git-cola
    # TODO: trying to install gitFull gives me a "collision" error
    # gitFull
    gitg
    glow                 # terminal markdown viewer
    go
    google-chrome
    google-cloud-sdk     # Google Cloud Platform CLI (gcloud)
    graphviz             #
    httpie               #
    hyperfine            # command-line benchmarking tool
    inkscape             #
    jq                   #
    killall              # kill processes by name or list PIDs
    liferea              # RSS reader
    monolith
    neofetch
    nerdfonts
    nitch                # minimal system information fetch
    nix-index            # locate packages containing certain nixpkgs
    nix-output-monitor   # nom: monitor nix commands
    nuclei
    nyancat              # the famous rainbow cat!
    openshot-qt
    ncdu
    newman
    nodejs_21
    pgadmin4
    pinta
    podman
    poke
    # TODO: trying to install postman gives me an HTTP 404
    postman
    prettyping           # a nicer ping
    pulumi
    qemu
    ripgrep-all
    rlwrap
    rm-improved
    rofi
    s-tui
    screenkey            # shows keypresses on screen
    sd
    silver-searcher
    simplescreenrecorder # screen recorder gui
    sqlite
    sqlitebrowser
    stripe-cli
    sxhkd
    syncthing
    temurin-bin-18
    thunderbird
    tmux
    tokei
    vlc
    vscode
    yt-dlp
    wasmtime
    wget
    wireshark
    zathura
    zeal
    zig
    # zls

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

    # enableNixpkgsReleaseCheck = false;

    file = {
      "${config.xdg.configHome}/neofetch/config.conf".source = ../dotfiles/neofetch.conf;
      "${config.xdg.configHome}/tmux/tmux.conf".source = ../dotfiles/tmux.conf;
    };

    packages = defaultPkgs;

    # environment variables
    sessionVariables = {
      BROWSER = "${lib.getExe pkgs.google-chrome}";
      EDITOR = "nvim";
    };

    # Do NOT change this value, even if you update Home Manager.
    stateVersion = "22.11";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";
}
