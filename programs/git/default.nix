{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    # Other possibly useful aliases
    # https://gist.github.com/pksunkara/988716
    # https://github.com/gvolpe/nix-config/blob/master/home/programs/git/default.nix
    # https://github.com/servo/servo/wiki/Github-workflow#git-tips
    # Other diff/merge tools
    # https://stackoverflow.com/questions/572237/whats-the-best-three-way-merge-tool
    aliases = {
      au = "add --update";
      br = "branch";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      cm = "commit --message";
      co = "checkout";
      dt = "difftool --tool difftastic";
      dtm = "difftool --tool meld";
      fp = "fetch --prune";
      hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
      lg = "log --oneline --graph --decorate";
      mt = "mergetool";
      pf = "push --force-with-lease";
      pum = "pull upstream main";
      ra = "rebase --abort";
      rc = "rebase --continue";
      ri = "rebase --interactive";
      ric = "rebase --interactive origin/canary";
      rim = "rebase --interactive origin/main";
      st = "status";
    };

    extraConfig = {
      core = {
        bare = false;
        editor = "${pkgs.neovim}/bin/nvim";
      };
      # https://git-scm.com/docs/git-difftool
      difftool = {
        prompt = false;
        difftastic = {
          cmd = "difft $LOCAL $REMOTE";
        };
        meld = {
          cmd = "meld $LOCAL $REMOTE";
        };
      };
      github = {
        user = "jackdbd";
      };
      init = {
        defaultBranch = "main";
      };
      mergetool = {
        prompt = true;
      };
    };

    ignores = [
      "*.direnv"
      "*.envrc"
    ];

    userEmail = "giacomo@giacomodebidda.com";
    userName = "Giacomo Debidda";
  };
}