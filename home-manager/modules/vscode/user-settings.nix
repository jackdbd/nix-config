{
  lib,
  pkgs,
}: {
  "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[css]"."editor.formatOnSave" = true;
  "[git-commit]"."editor.rulers" = [50];
  "[html]"."editor.defaultFormatter" = "vscode.html-language-features";
  # This syntax seems not to work.
  # "[javascript][json][typescript]"."editor.defaultFormatter" = pkgs.vscode-extensions.esbenp.prettier-vscode;
  # This syntax works.
  "[javascript][json][typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[javascript][json][typescript]"."editor.formatOnSave" = true;
  "[markdown]"."editor.suggestOnTriggerCharacters" = false;
  "[markdown][nunjucks]"."editor.wordWrap" = "bounded";
  "[markdown][nunjucks]"."editor.wordWrapColumn" = 120;
  "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
  "[nix]"."editor.formatOnSave" = true;
  "[nix]"."editor.tabSize" = 2;
  "[postcss]"."editor.defaultFormatter" = "stylelint.vscode-stylelint";
  "[postcss]"."editor.formatOnSave" = true;
  "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
  "[python]"."editor.formatOnSave" = true;
  "[python]"."editor.codeActionsOnSave" = {
    "source.organizeImports" = "explicit";
  };

  "alejandra.program" = "alejandra";
  # https://calva.io/customizing/
  # https://calva.io/emacs-keybindings/
  # https://calva.io/paredit/#about-the-keyboard-shortcuts

  # I don't find the Calva inspector particularly useful. Maybe I'll change my mind later.
  # https://calva.io/inspector/
  "calva.autoOpenInspector" = false;
  "calva.paredit.hijackVSCodeDefaults" = true;
  # https://calva.io/customizing-jack-in-and-connect/#project-roots-search-globing
  # https://github.com/BetterThanTomorrow/calva/blob/cfac06252fb445ff20231ca0216698f577997254/package.json#L807
  # TODO: I would like to add .devenv to this list, but I think I would need to
  # create a nix overlay for this. It's much more reasonable to make a PR to
  # Calva and add .devenv there.
  # "calva.projectRootsSearchExclude" =
  #   pkgs.vscode-extensions.betterthantomorrow.calva.projectRootsSearchExclude.default
  #   ++ [
  #     ".devenv"
  #   ];
  # Jack-in connect sequences: https://calva.io/connect-sequences/
  "calva.replConnectSequences" = [
    {
      "name" = "deps.edn :dev";
      "cljsType" = "none";
      # "jackInEnv" = {};
      "menuSelections" = {
        "cljAliases" = ["dev"];
      };
      "projectType" = "deps.edn";
    }
  ];
  "calva.showCalvaSaysOnStart" = false;
  "calva.showDocstringInParameterHelp" = true;

  "css.validate" = true;

  "editor.inlineSuggest.enabled" = true;
  "editor.minimap.enabled" = false;
  "editor.rulers" = [80 120];

  # https://www.michael1e.com/turning-on-emmet-for-nunjuck-files-on-vscode/
  "emmet.includeLanguages" = {
    "nunjucks" = "html";
  };

  # The extension pflannery.vscode-versionlens works only if the file type
  # associated to package.json is json, not jsonc.
  # For tsconfig files we can use jsonc without any issues.
  # https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens
  "files.associations" = {
    "_headers" = "toml";
    "_redirects" = "toml";
    "*.json" = "json";
    "*.webc" = "html";
    ".ignore" = "txt";
    "tsconfig*.json" = "jsonc";
  };

  # hide a few folders
  "files.exclude".".calva/" = true;
  "files.exclude".".clj-kondo/" = true;
  "files.exclude".".cpcache/" = true;
  "files.exclude".".direnv/" = true;
  "files.exclude".".devenv/" = true;
  "files.exclude".".lsp/" = true;
  "files.exclude".".portal/" = true;
  "files.exclude".".turbo/" = true;
  "files.exclude"."**/node_modules/" = true;

  "github.copilot.enable" = {
    "*" = true;
    plaintext = false;
    markdown = true;
  };
  "githubIssues.queries" = [
    {
      label = "Bugs";
      query = ''repo:''${owner}/''${repository} sort:created-desc state:open label:bug'';
    }
    {
      label = "Created By Me";
      query = ''author:''${user} state:open repo:''${owner}/''${repository} sort:created-desc'';
    }
  ];
  "githubPullRequests.queries" = [
    {
      label = "Assigned To Me";
      query = ''is:open assignee:''${user}'';
    }
    {
      label = "Created By Me";
      query = ''is:open author:''${user}'';
    }
    {
      label = "Waiting For My Review";
      query = ''is:open review-requested:''${user}'';
    }
    {
      label = "WIP PRs";
      query = "is:open";
    }
  ];

  # Git Graph settings
  # https://github.com/mhutchie/vscode-git-graph/wiki/Extension-Settings
  # GitLens settings
  # https://help.gitkraken.com/gitlens/gitlens-settings/
  # Prevent Gitlens from hijacking the "Generate Commit Message with Copilot" button.
  # https://github.com/microsoft/vscode/issues/200375#issuecomment-1847411013

  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nixd";
  # nixd settings (vimjoyer): https://youtu.be/M_zMoHlbZBY?si=wBMp8UAnNyH8P1OJ&t=314
  "nix.serverSettings" = {
    formatting = {
      command = ["alejandra"];
    };
    nixpks = {
      expr = "import <nixpkgs> {}";
    };
  };

  "search.exclude" = {
    "**/.calva" = true;
    "**/.direnv" = true;
    "**/.devenv" = true;
    "**/.git" = true;
    "**/dist" = true;
    "**/flake-inputs" = true;
    "**/node_modules" = true;
    "**/tmp" = true;
  };

  # Open all NEW VS Code windows in full screen mode. The first window will
  # always restore the size and location as you left it before closing.
  "window.newWindowDimensions" = "fullscreen";
  "window.restoreFullscreen" = true;

  # https://code.visualstudio.com/api/references/theme-color
  "workbench.colorCustomizations" = {
    "editorRuler.foreground" = "#d3d3d3";
  };

  # "workbench.colorTheme" = "Gruvbox Dark Medium";
  # https://github.com/ziglang/vscode-zig/blob/master/package.json
  "zig.path" = "zig"; # The string "zig" means lookup zig in PATH
  "zig.zls.path" = "zls"; # The string "zls" means lookup zls in PATH
  # "zig.zls.path" = "/home/jack/.nix-profile/bin/zls";
}
