{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.vscode;
  # Can I get buildVscodeMarketplaceExtension?
  # inherit (pkgs.applications.editors.vscode.extensions.vscode-utils) buildVscodeMarketplaceExtension;
  # sqltools = buildVscodeMarketplaceExtension {
  #   mktplcRef = {
  #     name = "vscode-sqltools";
  #     publisher = "SQLTools";
  #     version = "0.28.1";
  #     sha256 = lib.fakeSha256;
  #     # sha256 = "";
  #   };
  #   meta = {
  #     description = ''
  #       Database management for VSCode.
  #       SQLTools provides connections to many of the most commonly used
  #       databases, making it easier to work with your data.
  #     '';
  #     license = lib.licenses.mit;
  #   };
  # };
in {
  imports = [];

  options = {};

  meta = {};

  config.home.packages = [
    pkgs.vscode
  ];

  # https://mipmip.github.io/home-manager-option-search/?query=vscode
  config.programs.vscode = {
    enable = true;

    # Do NOT declare VS Code extensions like this:
    # extensions = [ "esbenp.prettier-vscode" ];
    # Instead, search `vscode-extensions` on NixOS Search.
    # https://search.nixos.org/packages
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/editors/vscode
    # VS Code themes
    # https://mynixos.com/search?q=vscode+theme
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix # Nix language support for VS Code
      betterthantomorrow.calva # Clojure/Script interactive programming for VS Code
      christian-kohler.path-intellisense
      coolbear.systemd-unit-file # syntax highlighting for systemd unit files
      davidanson.vscode-markdownlint
      eamodio.gitlens
      esbenp.prettier-vscode
      github.copilot
      github.vscode-github-actions
      github.vscode-pull-request-github
      jdinhlife.gruvbox # Gruvbox theme
      kamadorueda.alejandra # Nix formatter
      mechatroner.rainbow-csv
      mhutchie.git-graph
      ms-azuretools.vscode-docker
      # at the moment mtxr.sqltools is not available on nixpkgs (not even on
      # nixpkgs unstable) https://github.com/mtxr/vscode-sqltools
      tamasfe.even-better-toml
      usernamehw.errorlens
    ];

    # https://code.visualstudio.com/docs/getstarted/settings
    userSettings = {
      "[git-commit]"."editor.rulers" = [50];
      "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[css]"."editor.formatOnSave" = true;
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.formatOnSave" = true;
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.formatOnSave" = true;
      "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
      "[nix]"."editor.formatOnSave" = true;
      "[nix]"."editor.tabSize" = 2;
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.formatOnSave" = true;
      "alejandra.program" = "alejandra";
      "editor.minimap.enabled" = false;
      "editor.rulers" = [80 120];
      # The extension pflannery.vscode-versionlens works only if the file type
      # associated to package.json is json, not jsonc.
      # For tsconfig files we can use jsonc without any issues.
      # https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens
      "files.associations"."*.json" = "json";
      "files.associations"."tsconfig*.json" = "jsonc";
      # hide a few folders
      "files.exclude".".clj-kondo/" = true;
      "files.exclude".".lsp/" = true;
      "files.exclude"."**/node_modules/" = true;
      # Open all NEW VS Code windows in full screen mode. The first window will
      # always restore the size and location as you left it before closing.
      "window.newWindowDimensions" = "fullscreen";
      "window.restoreFullscreen" = true;
      # https://code.visualstudio.com/api/references/theme-color
      "workbench.colorCustomizations" = {
        "editorRuler.foreground" = "#d3d3d3";
      };
      "workbench.colorTheme" = "Gruvbox Dark Medium";
    };

    # TODO: configure stylelint and stylelint rules
    # https://github.com/stylelint/vscode-stylelint
    # https://github.com/stylelint/stylelint/blob/main/docs/user-guide/rules.md

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
