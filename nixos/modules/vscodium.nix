{pkgs, ...}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      # https://nixos.wiki/wiki/VSCodium
      vscodium

      # Declaring VSCode extensions here seems not to work. However, I can
      # manually install them in VSCodium. Since I use very few extensions in
      # VSCodium, installing them manually is not a big deal.
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions;
          [
            bbenoist.nix # Nix language support for VS Code
            esbenp.prettier-vscode
            ms-python.debugpy # Python debugger (debugpy) extension for VS Code
            ms-python.python
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          ];
      })
    ];
  };
}
