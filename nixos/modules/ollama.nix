{
  config,
  lib,
  pkgs,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      ollama
    ];

    services.ollama = {
      enable = true;
      environmentVariables = {};
    };
  };
}
