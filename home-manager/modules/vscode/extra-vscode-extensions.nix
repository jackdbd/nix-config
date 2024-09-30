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

  chakrounanas.turbo-console-log = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "turbo-console-log";
      publisher = "ChakrounAnas";
      sha256 = "sha256-6CMnEGss4XkDau6Wn4equMJWoQtSjMgQ15Y7TK3mZvk=";
      version = "2.10.4";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/ChakrounAnas.turbo-console-log/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=ChakrounAnas.turbo-console-log";
      homepage = "https://github.com/Chakroun-Anas/turbo-console-log#readme";
      license = lib.licenses.mit;
    };
  };

  djblue.portal = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "portal";
      publisher = "djblue";
      sha256 = "sha256-uFPEgx5R69ESwJreoDBm7HX6kAt5MRz/U4SU6sOlypE=";
      version = "0.57.3";
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

  hbenl.vscode-mocha-test-adapter = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-mocha-test-adapter";
      publisher = "hbenl"; # Holger Benl
      sha256 = "sha256-3sbQFmLOQziwc/jzk7UjQXzFpe/+meoXkY7kDo6AvmI=";
      version = "2.14.1";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=hbenl.vscode-mocha-test-adapter";
      homepage = "https://github.com/hbenl/vscode-mocha-test-adapter";
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
      sha256 = "sha256-2wmdfvD6j/gQ3IEAn1vKOOzbqlmbWhVM5qXlLoBmg3c=";
      version = "1.9.2";
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

  # https://github.com/Pythagora-io/gpt-pilot
  Pythagora-io.gpt-pilot = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "gpt-pilot-vs-code";
      publisher = "PythagoraTechnologies";
      sha256 = "sha256-f+XNo3NRstKk+nc9q4qBbTehbdteDvss2MqazrlwVOQ=";
      version = "0.1.12";
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

  stylelint.vscode-stylelint = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-stylelint";
      publisher = "Stylelint";
      sha256 = "sha256-JoCa2d0ayBEuCcQi3Z/90GJ4AIECVz8NCpd+i+9uMeA=";
      version = "1.3.0";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/stylelint.vscode-stylelint/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=stylelint.vscode-stylelint";
      homepage = "https://github.com/stylelint/vscode-stylelint#readme";
      license = lib.licenses.mit;
    };
  };

  # https://github.com/unocss/unocss
  unocss.unocss = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "unocss";
      publisher = "antfu"; # Anthony Fu
      sha256 = "sha256-nfqvzKqpvEoRU9B5KNjj4vLK5evaftSA60keEPVtbRY=";
      version = "0.59.2";
    };
    meta = {
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=antfu.unocss";
      homepage = "https://github.com/unocss/unocss#readme";
      license = lib.licenses.mit;
    };
  };

  # https://github.com/vuejs/language-tools
  vuejs.language-tools = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "volar";
      publisher = "Vue";
      sha256 = "sha256-UQGatAUuDCd5/sisp8UOTuP1gtNMxTpOHQLzO28eOYg=";
      version = "2.0.14";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/Vue.volar/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=Vue.volar";
      homepage = "https://github.com/vuejs/language-tools#readme";
      license = lib.licenses.mit;
    };
  };

  yoavbls.pretty-ts-errors = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "pretty-ts-errors";
      publisher = "yoavbls";
      sha256 = "sha256-cmleAs7EMXT1z0o8Uq5ne2LrthUt/vhcN+iqfAy/i/8=";
      version = "0.6.0";
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
      sha256 = "sha256-gmdnU5OfHhWZ0yL3Af9blxDgO64Xbdmt8d6fDLVyPfc="; # v2.1.12
      version = "2.1.12";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/webhint.vscode-webhint/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=webhint.vscode-webhint";
      homepage = "https://webhint.io/";
      license = lib.licenses.asl20; # Apache License 2.0
    };
  };

  ziglang.vscode-zig = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-zig";
      publisher = "ziglang";
      sha256 = "sha256-tKDIGALQT4mgZ7u+LSbdzW2pdH0RhyUjpWyH4YHNR10=";
      version = "0.5.9";
    };
    meta = {
      changelog = "https://marketplace.visualstudio.com/items/ziglang.vscode-zig/changelog";
      downloadPage = "https://marketplace.visualstudio.com/items?itemName=ziglang.vscode-zig";
      homepage = "https://github.com/ziglang/vscode-zig#readme";
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
    activitywatch.aw-watcher-vscode
    bierner.color-info # Provides quick information about css colors
    chakrounanas.turbo-console-log
    djblue.portal # A clojure tool to navigate through your data
    dtsvet.vscode-wasm # WebAssembly Toolkit for VSCode
    hbenl.vscode-mocha-test-adapter # Mocha Test Explorer (Mocha adapter for the Test Explorer extension)
    mtxr.sqltools # SQL formatter and query runner for many databases
    pflannery.vscode-versionlens
    pranaygp.vscode-css-peek
    # PythagoraTechnologies.gpt-pilot-vs-code
    # Pythagora-io.gpt-pilot
    ronnidc.nunjucks
    ryan-heybourn.headwind
    stylelint.vscode-stylelint
    unocss.unocss
    vuejs.language-tools
    yoavbls.pretty-ts-errors
    webhint.vscode-webhint
    ziglang.vscode-zig
    zignd.html-css-class-completion
  ]
