{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  cfg = config.programs.vscode;

  activitywatch.aw-watcher-vscode = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "aw-watcher-vscode";
      publisher = "ActivityWatch";
      version = "0.5.0";
      # sha256 = lib.fakeSha256;
      sha256 = "sha256-OrdIhgNXpEbLXYVJAx/jpt2c6Qa5jf8FNxqrbu5FfFs=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/activitywatch.aw-watcher-vscode/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=activitywatch.aw-watcher-vscode";
      homepage = "https://github.com/ActivityWatch/aw-watcher-vscode#readme";
      license = lib.licenses.mpl20;
    };
  };

  bierner.color-info = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "color-info";
      publisher = "bierner"; # Matt Bierner
      version = "0.7.2";
      sha256 = "sha256-Bf0thdt4yxH7OsRhIXeqvaxD1tbHTrUc4QJcju7Hv90=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/bierner.color-info/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=bierner.color-info";
      homepage = "https://github.com/mattbierner/vscode-color-info#readme";
      license = lib.licenses.mit;
    };
  };

  chakrounanas.turbo-console-log = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "turbo-console-log";
      publisher = "ChakrounAnas";
      version = "2.9.10";
      sha256 = "sha256-1QyDdE/M7IJ9WByhCUNCneThc7UZ+4B+B2pRwDYy7K0=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/ChakrounAnas.turbo-console-log/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=ChakrounAnas.turbo-console-log";
      homepage = "https://github.com/Chakroun-Anas/turbo-console-log#readme";
      license = lib.licenses.mit;
    };
  };

  dtsvet.vscode-wasm = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-wasm";
      publisher = "dtsvet"; # WebAssembly Foundation
      version = "1.4.1";
      sha256 = "sha256-zs7E3pxf4P8kb3J+5zLoAO2dvTeepuCuBJi5s354k0I=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/dtsvet.vscode-wasm/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=dtsvet.vscode-wasm";
      homepage = "https://github.com/wasmerio/vscode-wasm";
      license = lib.licenses.mit;
    };
  };

  stylelint.vscode-stylelint = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-stylelint";
      publisher = "Stylelint";
      version = "1.3.0";
      sha256 = "sha256-JoCa2d0ayBEuCcQi3Z/90GJ4AIECVz8NCpd+i+9uMeA=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/stylelint.vscode-stylelint/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=stylelint.vscode-stylelint";
      homepage = "https://github.com/stylelint/vscode-stylelint#readme";
      license = lib.licenses.mit;
    };
  };

  yoavbls.pretty-ts-errors = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "pretty-ts-errors";
      publisher = "yoavbls";
      version = "0.5.2";
      sha256 = "sha256-g6JIiXfjQKQEtdXZgsQsluKuJZO0MsD1ijy+QLYE1uY=";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=yoavbls.pretty-ts-errors";
      homepage = "https://github.com/yoavbls/pretty-ts-errors#readme";
      license = lib.licenses.mit;
    };
  };
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

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    # https://mipmip.github.io/home-manager-option-search/?query=vscode
    programs.vscode = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = false;

      # Do NOT declare VS Code extensions like this:
      # extensions = [ "esbenp.prettier-vscode" ];
      # Instead, search `vscode-extensions` on NixOS Search.
      # https://search.nixos.org/packages
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/editors/vscode
      # VS Code themes
      # https://mynixos.com/search?q=vscode+theme
      extensions = with pkgs.vscode-extensions; [
        activitywatch.aw-watcher-vscode
        bbenoist.nix # Nix language support for VS Code
        betterthantomorrow.calva # Clojure/Script interactive programming for VS Code
        bierner.color-info # Provides quick information about css colors
        chakrounanas.turbo-console-log
        christian-kohler.path-intellisense
        coolbear.systemd-unit-file # syntax highlighting for systemd unit files
        davidanson.vscode-markdownlint
        dtsvet.vscode-wasm # WebAssembly Toolkit for VSCode
        eamodio.gitlens
        esbenp.prettier-vscode
        github.copilot
        github.vscode-github-actions
        github.vscode-pull-request-github
        jdinhlife.gruvbox # Gruvbox theme
        jnoortheen.nix-ide # Nix language support with formatting and error report
        kamadorueda.alejandra # Nix formatter
        mechatroner.rainbow-csv
        mhutchie.git-graph
        ms-azuretools.vscode-docker
        # at the moment mtxr.sqltools is not available on nixpkgs (not even on
        # nixpkgs unstable) https://github.com/mtxr/vscode-sqltools
        stylelint.vscode-stylelint
        tamasfe.even-better-toml
        usernamehw.errorlens
        yoavbls.pretty-ts-errors
      ];

      # https://github.com/jackdbd/dotfiles/tree/main/Code/.config/Code/User/snippets
      globalSnippets = {
        fixme = {
          body = ["$LINE_COMMENT FIXME: $0"];
          description = "Insert a FIXME remark";
          prefix = ["fixme"];
        };
        todo = {
          body = ["$LINE_COMMENT TODO: $0"];
          description = "Insert a TODO remark";
          prefix = ["todo"];
        };
        "define zig struct" = {
          "prefix" = "str";
          "body" = "const Foo = struct {\n    x: f64,\n};";
          "description" = "Define a struct";
        };
        "import esm/ts module" = {
          prefix = "im";
          body = "import { $0 } from \"$1\";";
        };
        "import zig std library" = {
          prefix = "std";
          body = "const std = @import(\"std\");";
          description = "Import Zig standard library";
        };
        "log.debug variable and type in zig" = {
          "prefix" = "ld";
          "body" = "std.log.debug(\"$0: {} type: {}\", .{$0, @typeInfo(@TypeOf($0))});";
          "description" = "Log a variable and its type to stdout";
        };
        "while loop in zig" = {
          "prefix" = "wh";
          "body" = "var i: usize = 0;\nwhile (i < 10) : (i += 1) {\n    $0\n}";
          "description" = "while loop skeleton";
        };
      };

      keybindings = [
        {
          key = "f1";
          command = "revealInExplorer";
        }
      ];

      # https://code.visualstudio.com/docs/getstarted/settings
      # https://github.com/jackdbd/dotfiles/blob/main/Code/.config/Code/User/settings.json
      userSettings = {
        "[git-commit]"."editor.rulers" = [50];
        "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[css]"."editor.formatOnSave" = true;
        "[javascript][json][typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript][json][typescript]"."editor.formatOnSave" = true;
        "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
        "[nix]"."editor.formatOnSave" = true;
        "[nix]"."editor.tabSize" = 2;
        "[postcss]"."editor.defaultFormatter" = "stylelint.vscode-stylelint";
        "[postcss]"."editor.formatOnSave" = true;
        "alejandra.program" = "alejandra";
        "editor.inlineSuggest.enabled" = true;
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
        "gitlens.ai.experimental.provider" = "openai";
        # https://github.com/nix-community/vscode-nix-ide
        # https://github.com/oxalica/nil?tab=readme-ov-file#vscodevscodium-with-nix-ide
        "nix.enableLanguageServer" = true; # Enable LSP
        "nix.serverPath" = "nil"; # The path to the LSP server executable
        "nix.serverSettings" = {
          nil = {
            formatting = {command = ["alejandra"];};
          };
        };
        # "security.workspace.trust.untrustedFiles" = "open";
        "turboConsoleLog.includeFileNameAndLineNum" = false;
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
  };
}
