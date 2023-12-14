{
  allowed-unfree-packages,
  config,
  favorite-browser,
  lib,
  pkgs,
  ...
}:

let
  username = "jack";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config"; # equivalent to config.xdg.configHome

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
    curl
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

    (writeShellApplication {
      name = "show-nixos-org";
      runtimeInputs = [ curl w3m ];
      text = ''
        curl -s 'https://nixos.org' | w3m -dump -T text/html
      '';
    })

    (writeShellScriptBin "debug-home-manager" ''
      printf "=== DEBUG HOME MANAGER ===\n"
      echo "favorite-browser is ${favorite-browser}"
      echo "config.home.username is ${config.home.username}"
      echo "config.home.homeDirectory is ${config.home.homeDirectory}"
      echo "username is ${username}"
      echo "homeDirectory is ${homeDirectory}"
      echo "configHome is ${configHome}"
    '')
  ];
in
{
  imports = [ ] ++ lib.concatMap import [
    ../programs
    ../scripts
    ../services
    ../xfconf
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    inherit homeDirectory username;

    # In case of a version mismatch between Nixpkgs and Home Manager, you can
    # silence it with this.
    # enableNixpkgsReleaseCheck = false;

    file = {
      "${config.xdg.configHome}/neofetch/config.conf".source = ../dotfiles/neofetch.conf;
      "${homeDirectory}/.npmrc".source = ../dotfiles/npmrc.ini;
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
  # manual.manpages.enable = false;

  # https://nix-community.github.io/home-manager/options.html#opt-nixpkgs.config
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  # restart systemd services on change
  systemd.user.startServices = "sd-switch";
}
