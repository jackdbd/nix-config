{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.vscode;
in {
  meta = {};

  imports = [];

  options = {
    programs.vscode = {
      # already declared in home-manager/modules/vscode.nix
      # enable = mkEnableOption "VS Code";

      # already declared in home-manager/modules/vscode.nix
      # package = mkOption {
      #   type = types.package;
      #   default = pkgs.vscode;
      #   defaultText = literalExpression "pkgs.vscode";
      #   description = "Package providing VS Code.";
      # };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    # https://mipmip.github.io/home-manager-option-search/?query=vscode
    programs.vscode = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;

      # Do NOT declare VS Code extensions using a string: "esbenp.prettier-vscode"
      # Instead, search `vscode-extensions` on NixOS Search.
      # https://search.nixos.org/packages
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/editors/vscode
      # VS Code themes
      # https://mynixos.com/search?q=vscode+theme
      extensions = with pkgs.vscode-extensions;
        [
          bbenoist.nix # Nix language support for VS Code
          betterthantomorrow.calva # Clojure/Script interactive programming for VS Code
          bradlc.vscode-tailwindcss # Tailwind CSS tooling for VS Code
          christian-kohler.path-intellisense
          coolbear.systemd-unit-file # syntax highlighting for systemd unit files
          davidanson.vscode-markdownlint
          dbaeumer.vscode-eslint # integrates ESLint into VS Code
          eamodio.gitlens
          esbenp.prettier-vscode
          gencer.html-slim-scss-css-class-completion # CSS class name completion
          github.copilot
          github.copilot-chat
          github.vscode-github-actions
          github.vscode-pull-request-github
          jdinhlife.gruvbox # Gruvbox theme
          jnoortheen.nix-ide # Nix language support with formatting and error report
          kamadorueda.alejandra # Nix formatter
          mechatroner.rainbow-csv
          mhutchie.git-graph
          ms-azuretools.vscode-docker
          ms-python.python
          ms-vscode-remote.remote-containers # Dev Containers
          ms-vsliveshare.vsliveshare # Live Share (real-time collaborative development)
          # mtxr.sqltools
          # At the moment mtxr.sqltools is not available on nixpkgs (not even on
          # nixpkgs unstable) https://github.com/mtxr/vscode-sqltools
          tamasfe.even-better-toml
          usernamehw.errorlens
        ]
        ++ import ./extra-vscode-extensions.nix {
          inherit lib pkgs;
        };

      # https://github.com/jackdbd/dotfiles/tree/main/Code/.config/Code/User/snippets
      globalSnippets = import ./global-snippets.nix;

      keybindings = [
        {
          key = "f1";
          command = "revealInExplorer";
        }
      ];

      # https://code.visualstudio.com/docs/getstarted/settings
      # https://github.com/jackdbd/dotfiles/blob/main/Code/.config/Code/User/settings.json
      userSettings = import ./user-settings.nix {inherit lib pkgs;};

      # TODO: configure stylelint rules
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
  };
}
