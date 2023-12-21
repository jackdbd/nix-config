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
      enableUpdateCheck = true;

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
        chakrounanas.turbo-console-log
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
  };
}
