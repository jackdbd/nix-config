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
    extensions = with pkgs.vscode-extensions; [
      # Nix language support for Visual Studio Code.
      bbenoist.nix
      # Clojure & ClojureScript Interactive Programming for VS Code
      betterthantomorrow.calva
      christian-kohler.path-intellisense
      coolbear.systemd-unit-file
      davidanson.vscode-markdownlint
      eamodio.gitlens
      esbenp.prettier-vscode
      github.copilot
      github.vscode-github-actions
      github.vscode-pull-request-github
      jdinhlife.gruvbox
      mechatroner.rainbow-csv
      mhutchie.git-graph
      ms-azuretools.vscode-docker
      # TODO: https://github.com/mtxr/vscode-sqltools
      tamasfe.even-better-toml
      usernamehw.errorlens
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
      "editor.minimap.enabled" = false;
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