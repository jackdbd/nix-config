{
  lib,
  pkgs,
}: let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  # The `name` and `publisher` fields here can be found as the `Unique Identifier`
  # in the Visual Studio Code Marketplace. For example:
  # antfu.unocss => name = "unocss" and publisher = "antfu"

  activitywatch.aw-watcher-vscode = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "aw-watcher-vscode";
      publisher = "ActivityWatch";
      version = "0.5.0";
      # When you want to add a new extension or a new version of an existing extension, do this:
      # 1. Set an empty SHA or a fake one (e.g. using lib.fakeSha256)
      # 2. Run home-manager switch. This will fail because the SHA does not match. Take note of the correct SHA.
      # 3. Replace the SHA with the correct one.
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
      sha256 = "sha256-Bf0thdt4yxH7OsRhIXeqvaxD1tbHTrUc4QJcju7Hv90=";
      version = "0.7.2";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/bierner.color-info/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=bierner.color-info";
      homepage = "https://github.com/mattbierner/vscode-color-info#readme";
      license = lib.licenses.mit;
    };
  };

  djblue.portal = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "portal";
      publisher = "djblue";
      sha256 = "sha256-GSi5COZsg2sOM4C9+4+3CehHp85gY80hLug64B3aIYo=";
      version = "0.59.2";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=djblue.portal";
      homepage = "https://github.com/djblue/portal#readme";
      license = lib.licenses.mit;
    };
  };

  dtsvet.vscode-wasm = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-wasm";
      publisher = "dtsvet"; # WebAssembly Foundation
      sha256 = "sha256-zs7E3pxf4P8kb3J+5zLoAO2dvTeepuCuBJi5s354k0I=";
      version = "1.4.1";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/dtsvet.vscode-wasm/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=dtsvet.vscode-wasm";
      homepage = "https://github.com/wasmerio/vscode-wasm";
      license = lib.licenses.mit;
    };
  };

  mtxr.sqltools = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "sqltools";
      publisher = "mtxr";
      sha256 = "sha256-bTrHAhj8uwzRIImziKsOizZf8+k3t+VrkOeZrFx7SH8=";
      version = "0.28.3";
    };
    meta = {
      changelog = "https://vscode-sqltools.mteixeira.dev/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools";
      homepage = "https://vscode-sqltools.mteixeira.dev/";
      license = lib.licenses.mit;
    };
  };

  pflannery.vscode-versionlens = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-versionlens";
      publisher = "pflannery";
      sha256 = "sha256-gsMBB4veu4MWPEkW1sefHi5ZI6zDPNHicMdu0Z3c24Q=";
      version = "1.22.2";
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
      sha256 = "sha256-GX6J9DfIW9CLarSCfWhJQ9vvfUxy8QU0kh3cfRUZIaE=";
      version = "4.4.1";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek";
      homepage = "https://github.com/pranaygp/vscode-css-peek/blob/master/README.md";
      license = lib.licenses.mit;
    };
  };

  ronnidc.nunjucks = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nunjucks";
      publisher = "ronnidc";
      sha256 = "sha256-7YfmRMhC+HFmYgYtyHWrzSi7PZS3tdDHly9S1kDMmjY=";
      version = "0.3.1";
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
      sha256 = "sha256-yXsZoSuJQTdbHLjEERXX2zVheqNYmcPXs97/uQYa7og=";
      version = "1.7.0";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=heybourn.headwind";
      homepage = "https://github.com/heybourn/headwind#readme";
      license = lib.licenses.mit;
    };
  };

  unocss.unocss = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "unocss";
      publisher = "antfu"; # Anthony Fu
      sha256 = "sha256-4bxxp4mtcnMhLdKL9D01VqMQKOAjaeWI8Q5He5HHhMQ=";
      version = "66.3.3";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=antfu.unocss";
      homepage = "https://github.com/unocss/unocss#readme";
      license = lib.licenses.mit;
    };
  };

  vuejs.language-tools = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "volar";
      publisher = "Vue";
      sha256 = "sha256-6iInkhGZ0r4xtJCiHrsTa6EMnNR4mXUARR4B9YXRm+I=";
      version = "3.0.3";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/Vue.volar/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=Vue.volar";
      homepage = "https://github.com/vuejs/language-tools#readme";
      license = lib.licenses.mit;
    };
  };

  zignd.html-css-class-completion = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "html-css-class-completion";
      publisher = "zignd";
      sha256 = "sha256-3BEppTBc+gjZW5XrYLPpYUcx3OeHQDPW8z7zseJrgsE=";
      version = "1.20.0";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/Zignd.html-css-class-completion/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=Zignd.html-css-class-completion";
      license = lib.licenses.mit;
    };
  };
in
  with pkgs.vscode-extensions; [
    # activitywatch.aw-watcher-vscode
    bierner.color-info # Provides quick information about css colors
    djblue.portal # A clojure tool to navigate through your data
    dtsvet.vscode-wasm # WebAssembly Toolkit for VSCode
    mtxr.sqltools # SQL formatter and query runner for many databases
    pflannery.vscode-versionlens
    pranaygp.vscode-css-peek
    ronnidc.nunjucks
    ryan-heybourn.headwind
    scalameta.metals
    unocss.unocss
    vuejs.language-tools
    zignd.html-css-class-completion
  ]
