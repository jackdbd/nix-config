{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Do NOT declare VS Code extensions like this:
    # extensions = [ "esbenp.prettier-vscode" ];
    # Instead, search `vscode-extensions` on NixOS Search.
    # https://search.nixos.org/packages
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/editors/vscode
      # VS Code themes
      # https://mynixos.com/search?q=vscode+theme
    extensions = [
      # Nix language support for Visual Studio Code.
      pkgs.vscode-extensions.bbenoist.nix
      # Clojure & ClojureScript Interactive Programming for VS Code
      pkgs.vscode-extensions.betterthantomorrow.calva
      pkgs.vscode-extensions.christian-kohler.path-intellisense
      pkgs.vscode-extensions.coolbear.systemd-unit-file
      pkgs.vscode-extensions.davidanson.vscode-markdownlint
      pkgs.vscode-extensions.eamodio.gitlens
      pkgs.vscode-extensions.esbenp.prettier-vscode
      # pkgs.vscode-extensions.github.copilot
      pkgs.vscode-extensions.github.vscode-github-actions
      # https://marketplace.visualstudio.com/items?itemName=jdinhlife.gruvbox
      pkgs.vscode-extensions.jdinhlife.gruvbox
      pkgs.vscode-extensions.mechatroner.rainbow-csv
      pkgs.vscode-extensions.mhutchie.git-graph
      pkgs.vscode-extensions.tamasfe.even-better-toml
      pkgs.vscode-extensions.usernamehw.errorlens
    ];

    # https://nix-community.github.io/home-manager/options.html#opt-programs.vscode.userSettings
    userSettings = {
      "[git-commit]"."editor.rulers" = [50];
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.formatOnSave" = true;
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.formatOnSave" = true;
      "[nix]"."editor.tabSize" = 2;
      "[nix]"."editor.formatOnSave" = true;
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.formatOnSave" = true;
      "editor.rulers" = [80 120];
      # The extension pflannery.vscode-versionlens works only if the file type
      # associated to package.json is json, not jsonc.
      # For tsconfig files we can use jsonc without any issues.
      # https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens
      "files.associations"."*.json" = "json";
      "files.associations"."tsconfig*.json" = "jsonc";
      "files.exclude"."**/node_modules/" = true;
      # https://code.visualstudio.com/api/references/theme-color
      "workbench.colorCustomizations" = {
        "editorRuler.foreground" = "#d3d3d3";
      };
      "workbench.colorTheme" = "Gruvbox Dark Medium";
    };

    userTasks = {
      version = "2.0.0";
      tasks = [
        {
          type = "shell";
          label = "Hello task";
          command = "hello";
        }
      ];
    };
  };
}