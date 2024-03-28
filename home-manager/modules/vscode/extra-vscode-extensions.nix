{
  lib,
  pkgs,
}: let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  activitywatch.aw-watcher-vscode = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "aw-watcher-vscode";
      publisher = "ActivityWatch";
      version = "0.5.0";
      # When you want to add a new extension or a new version of an existing extension, do this:
      # 1. Set an empty SHA or a fake one (e.g. using lib.fakeSha256)
      # 2. Run home-manager switch. This will fail because the SHA does not match. Take note of the correct SHA.
      # 3. Replace the SHA with the correct one.
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

  pflannery.vscode-versionlens = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-versionlens";
      publisher = "pflannery";
      version = "1.9.2";
      sha256 = "sha256-2wmdfvD6j/gQ3IEAn1vKOOzbqlmbWhVM5qXlLoBmg3c=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/pflannery.vscode-versionlens/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens";
      homepage = "https://gitlab.com/versionlens/vscode-versionlens#readme";
      license = lib.licenses.mit;
    };
  };

  pranaygp.vscode-css-peek = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-css-peek";
      publisher = "pranaygp";
      version = "4.4.1";
      sha256 = "sha256-GX6J9DfIW9CLarSCfWhJQ9vvfUxy8QU0kh3cfRUZIaE=";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek";
      homepage = "https://github.com/pranaygp/vscode-css-peek/blob/master/README.md";
      license = lib.licenses.mit;
    };
  };

  # https://github.com/Pythagora-io/gpt-pilot
  Pythagora-io.gpt-pilot = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "gpt-pilot-vs-code";
      publisher = "PythagoraTechnologies";
      version = "0.1.12";
      sha256 = "sha256-f+XNo3NRstKk+nc9q4qBbTehbdteDvss2MqazrlwVOQ=";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/PythagoraTechnologies.gpt-pilot-vs-code/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=PythagoraTechnologies.gpt-pilot-vs-code";
      homepage = "https://github.com/Pythagora-io/gpt-pilot#readme";
      license = lib.licenses.asl20;
    };
  };

  ronnidc.nunjucks = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nunjucks";
      publisher = "ronnidc";
      version = "0.3.1";
      sha256 = "sha256-7YfmRMhC+HFmYgYtyHWrzSi7PZS3tdDHly9S1kDMmjY=";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=ronnidc.nunjucks";
      homepage = "https://github.com/ronnidc/vscode-nunjucks#readme";
      # license = null; // no license!
    };
  };

  ryan-heybourn.headwind = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "headwind";
      publisher = "heybourn";
      version = "1.7.0";
      sha256 = "sha256-yXsZoSuJQTdbHLjEERXX2zVheqNYmcPXs97/uQYa7og=";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=heybourn.headwind";
      homepage = "https://github.com/heybourn/headwind#readme";
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
      version = "0.5.3";
      sha256 = "sha256-JSCyTzz10eoUNu76wNUuvPVVKq4KaVKobS1CAPqgXUA=";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=yoavbls.pretty-ts-errors";
      homepage = "https://github.com/yoavbls/pretty-ts-errors#readme";
      license = lib.licenses.mit;
    };
  };

  webhint.vscode-webhint = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-webhint";
      publisher = "webhint";
      version = "2.1.12";
      sha256 = "sha256-gmdnU5OfHhWZ0yL3Af9blxDgO64Xbdmt8d6fDLVyPfc="; # v2.1.12
      # sha256 = "sha256-I+mDpMb9SgGeh6+a2JePC98ZXZyU+WztmwyX4dWtySY="; # v2.1.10
      # Version 2.1.11 doesn't work. Nix is able to build it, but it doesn't install it in VS Code.
      # version = "2.1.11";
      # sha256 = "sha256-Ir+Dk63k+eE+1PKQnO9FkCEXIVcfj/p13RcwTOf7qdM="; # v2.1.11
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/webhint.vscode-webhint/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=webhint.vscode-webhint";
      homepage = "https://webhint.io/";
      license = lib.licenses.asl20; # Apache License 2.0
    };
  };
in
  with pkgs.vscode-extensions; [
    activitywatch.aw-watcher-vscode
    bierner.color-info # Provides quick information about css colors
    chakrounanas.turbo-console-log
    dtsvet.vscode-wasm # WebAssembly Toolkit for VSCode
    pflannery.vscode-versionlens
    pranaygp.vscode-css-peek
    # PythagoraTechnologies.gpt-pilot-vs-code
    Pythagora-io.gpt-pilot
    ronnidc.nunjucks
    ryan-heybourn.headwind
    stylelint.vscode-stylelint
    yoavbls.pretty-ts-errors
    webhint.vscode-webhint
  ]
