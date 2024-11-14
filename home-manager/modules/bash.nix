{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.bash;
in {
  meta = {};

  imports = [];

  options = {
    programs.bash = {};
  };

  config = mkIf cfg.enable {
    # Home Manager is only able to set session variables automatically if it manages your shell.
    # https://nix-community.github.io/home-manager/index.html#_why_are_the_session_variables_not_set

    programs.bash = {
      enableCompletion = true;

      # https://nix-community.github.io/home-manager/options.html#opt-programs.bash.shellAliases
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        bug = "${pkgs.gh}/bin/gh issue create -a @me -l bug -t"; # e.g. bug "Thing X is broken when I do Y"
        chatgpt = "${pkgs.docker}/bin/docker run --rm --interactive --tty -v ${config.home.homeDirectory}/chatgpt/data/:/app/data -p 3000:3000 ghcr.io/cogentapps/chat-with-gpt:release";
        dk = "${pkgs.docker}/bin/docker";
        docs = "cd ~/Documents";
        down = "cd ~/Downloads";
        dvt-clojure = "nix flake new --template github:the-nix-way/dev-templates#clojure";
        dvt-node = "nix flake new --template github:the-nix-way/dev-templates#node";
        dvt-zig = "nix flake new --template github:the-nix-way/dev-templates#zig";
        gg = "gitg";
        gk = "gitk";
        hm = "home-manager --flake $HOME/repos/nix-config#$(whoami)@$(hostname)";
        hmn = "${pkgs.home-manager}/bin/home-manager --extra-experimental-features nix-command --extra-experimental-features flakes --flake $HOME/repos/nix-config#$(whoami)@$(hostname) news";
        hms = "${pkgs.home-manager}/bin/home-manager --extra-experimental-features nix-command --extra-experimental-features flakes --flake $HOME/repos/nix-config#$(whoami)@$(hostname) switch -b backup";
        issue = "${pkgs.gh}/bin/gh issue create -a @me -l enhancement -t"; # e.g. issue "Issue title here"
        issues = "${pkgs.gh}/bin/gh issue list";
        keyring = "systemctl --user start gnome-keyring.service";
        l = "${pkgs.eza}/bin/eza --all --long";
        lg = "lazygit";
        ll = "ls -l";
        lock = "xflock4";
        loc = "tokei"; # count lines of code
        myip = "curl http://ipecho.net/plain; echo";
        # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/update-the-system
        nfu = "nix flake update --flake $HOME/repos/nix-config";
        pics = "cd ~/Pictures";
        pk = "pkill --signal SIGTERM --echo --count"; # e.g. pk chromium-browser
        repl = "rlwrap bb --repl";
        repos = "cd ~/repos";
        rm = "${pkgs.trash-cli}/bin/trash-put";
        snr = "sudo nixos-rebuild switch --flake $HOME/repos/nix-config#$(hostname)";
        steampipe_dk = "docker run --rm --mount $\"type=bind,source=/home/jack/steampipe/config,target=/home/steampipe/.steampipe/config\" --name steampipe turbot/steampipe:latest";
        # https://the.exa.website/features/tree-view
        "t2" = "${pkgs.eza}/bin/eza --tree --ignore-glob=node_modules --level=2";
        "t3" = "${pkgs.eza}/bin/eza --tree --ignore-glob=node_modules --level=3";
        # download only audio (no video), in mp3 format
        "ytmp3" = "yt-dlp --ignore-errors --extract-audio --audio-format mp3";
      };
    };
  };
}
