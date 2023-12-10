{ config, pkgs, ... }:

{
  # Home Manager is only able to set session variables automatically if it manages your shell.
  # https://nix-community.github.io/home-manager/index.html#_why_are_the_session_variables_not_set
  programs.bash = {
    enable = true;
    
    enableCompletion = true;

    # https://nix-community.github.io/home-manager/options.html#opt-programs.bash.shellAliases
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      bug = "${pkgs.gh}/bin/gh issue create -a @me -l bug -t"; # e.g. bug "Thing X is broken when I do Y"
      chatgpt = "${pkgs.docker}/bin/docker run -v ${config.home.homeDirectory}/chatgpt/data/:/app/data -p 3000:3000 ghcr.io/cogentapps/chat-with-gpt:release";
      dk = "${pkgs.docker}/bin/docker";
      docs = "cd ~/Documents";
      down = "cd ~/Downloads";
      gg = "gitg";
      gk = "gitk";
      hm = "${pkgs.home-manager}/bin/home-manager -f ~/repos/nix-config/users/jack.nix";
      hms = "${pkgs.home-manager}/bin/home-manager -f ~/repos/nix-config/users/jack.nix switch";
      issue = "${pkgs.gh}/bin/gh issue create -a @me -l enhancement -t"; # e.g. issue "Issue title here"
      issues = "${pkgs.gh}/bin/gh issue list";
      l = "${pkgs.exa}/bin/exa --all --long";
      lg = "lazygit";
      ll = "ls -l";
      lock = "xflock4";
      # count line of code
      loc = "tokei";
      myip = "curl http://ipecho.net/plain; echo";
      pics = "cd ~/Pictures";
      pk = "pkill --signal SIGTERM --echo --count"; # e.g. pk liferea
      repl = "rlwrap bb --repl";
      repos = "cd ~/repos";
      snr = "sudo nixos-rebuild";
      # https://the.exa.website/features/tree-view
      "t2" = "${pkgs.exa}/bin/exa --tree --ignore-glob=node_modules --level=2";
      "t3" = "${pkgs.exa}/bin/exa --tree --ignore-glob=node_modules --level=3";
      # download only audio (no video), in mp3 format
      "ytmp3" = "yt-dlp --ignore-errors --extract-audio --audio-format mp3";
    };
  };
}