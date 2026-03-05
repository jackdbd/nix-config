{ pkgs, ... }:
{
  meta = { };

  imports = [ ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      claude-code
      codex
    ];
  };
}
