{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.git;
in {
  meta = {};

  imports = [];

  options = {
    programs.git = {
      # already declared in home-manager/modules/git.nix
      # enable = mkEnableOption "Install git";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      git
      # git-cola # git GUI TODO: this failed to build on 2024/07/25
      lazygit # terminal UI for git commands
    ];

    programs.git = {
      lfs.enable = true;

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
        dh = "difftool --tool difftastic HEAD~";
        dt = "difftool --tool difftastic";
        dtm = "difftool --tool meld";
        fp = "fetch --prune";
        fu = "fetch upstream";
        hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
        lg = "log --oneline --graph --decorate";
        mt = "mergetool";
        pf = "push --force-with-lease";
        pom = "push origin main";
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
          # excludesfile = "~/.gitignore";
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

      # .gitignore for this Linux user
      ignores = [
        ".clj-kondo/"
        ".lsp/"
        "*.direnv"
        "*.envrc"
      ];

      userEmail = "giacomo@giacomodebidda.com";
      userName = "Giacomo Debidda";
    };

    programs.lazygit = {
      enable = true;
      # https://rycee.gitlab.io/home-manager/options.html#opt-programs.lazygit.settings
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
      settings = {
        gui = {
          nerdFontsVersion = "3";
          windowSize = "half"; # "normal" (default) | "half" | "full"
        };
      };
    };
  };
}
