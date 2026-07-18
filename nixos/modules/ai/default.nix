{ pkgs, ... }:
{
  meta = { };

  imports = [ ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      claude-code
      claude-code-router
      claude-monitor
      codex
    ];
  };
}
