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
      profiles.default.enableExtensionUpdateCheck = true;
      profiles.default.enableUpdateCheck = true;

      # Do NOT declare VS Code extensions using a string (e.g. "esbenp.prettier-vscode")
      # Instead, search `vscode-extensions` on these websites:
      # https://search.nixos.org/packages
      # https://mynixos.com/search
      # VS Code themes are also extensions.
      # If you can't find the VS Code extension you want on NixOS Search, add it
      profiles.default.extensions = with pkgs.vscode-extensions;
        [
          bbenoist.nix # Nix language support for VS Code
          betterthantomorrow.calva # Clojure/Script interactive programming for VS Code
          # This extension consumes a lot of CPU and memory if you do NOT have
          # Tailwind CSS installed. For now, I'm disabling it.
          # https://github.com/tailwindlabs/tailwindcss-intellisense/issues/915
          # bradlc.vscode-tailwindcss # Tailwind CSS tooling for VS Code
          christian-kohler.path-intellisense
          coolbear.systemd-unit-file # syntax highlighting for systemd unit files
          davidanson.vscode-markdownlint # Markdown linting and style checking
          dbaeumer.vscode-eslint # integrates ESLint into VS Code
          eamodio.gitlens
          esbenp.prettier-vscode
          gencer.html-slim-scss-css-class-completion # CSS class name completion
          github.copilot
          github.copilot-chat
          github.vscode-github-actions
          github.vscode-pull-request-github
          hashicorp.hcl # syntax highlighting for HCL files (Terraform, atlasgo.io)
          hbenl.vscode-test-explorer #  Run your tests in the VS Code sidebar
          jdinhlife.gruvbox # Gruvbox theme
          jnoortheen.nix-ide # Nix language support with formatting and error report
          kamadorueda.alejandra # Nix formatter
          mechatroner.rainbow-csv
          mhutchie.git-graph
          ms-azuretools.vscode-docker
          ms-python.black-formatter # Python formatter
          ms-python.debugpy # Python debugger
          ms-python.isort # Python import sorter
          ms-python.python
          ms-vscode-remote.remote-containers # Dev Containers
          ms-vscode.test-adapter-converter # Test Explorer UI (vscode-test-explorer) depends on Test Adapter Converter (ms-vscode.test-adapter-converter)
          ms-vsliveshare.vsliveshare # Live Share (real-time collaborative development)
          scala-lang.scala # syntax highlighting for Scala 2 and Scala 3
          scalameta.metals # Scala language server with rich IDE features
          stylelint.vscode-stylelint # CSS linter
          tailscale.vscode-tailscale # Share a port over the internet with Tailscale Funnel
          tamasfe.even-better-toml
          usernamehw.errorlens
          yoavbls.pretty-ts-errors # Make TypeScript errors prettier and human-readable
          zhwu95.riscv # syntax highlighting and snippets for RISC-V assembly language
          ziglang.vscode-zig # Zig support for Visual Studio Code.
        ]
        ++ import ./extra-vscode-extensions.nix {
          inherit lib pkgs;
        };

      # https://github.com/jackdbd/dotfiles/tree/main/Code/.config/Code/User/snippets
      profiles.default.globalSnippets = import ./global-snippets.nix;

      profiles.default.keybindings = import ./keybindings.nix;

      # https://code.visualstudio.com/docs/getstarted/settings
      # https://github.com/jackdbd/dotfiles/blob/main/Code/.config/Code/User/settings.json
      profiles.default.userSettings = import ./user-settings.nix {inherit lib pkgs;};

      # TODO: configure stylelint rules
      # https://github.com/stylelint/vscode-stylelint
      # https://github.com/stylelint/stylelint/blob/main/docs/user-guide/rules.md

      profiles.default.userTasks = {
        version = "2.0.0";
        tasks = [
          {
            label = "Compile TypeScript files";
            type = "typescript";
            tsconfig = "tsconfig.json";
            problemMatcher = ["$tsc"];
            group = {
              kind = "build";
            };
          }
        ];
      };
    };
  };
}
