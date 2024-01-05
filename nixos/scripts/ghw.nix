{
  config,
  pkgs,
  ...
}:
# Wrap the GitHub CLI in an environment containing a GITHUB_TOKEN that has only
# the minimum set of permissions required to manage GitHub workflows.
# Usage: ghw list
# See: gh workflow --help
# TODO: how to have autocompletion for ghw?
let
  gh = "${pkgs.gh}/bin/gh";
in
  pkgs.writeShellScriptBin "ghw" ''
    export GITHUB_TOKEN=$(cat ${config.sops.secrets."github-tokens/workflow_developer".path})

    exec ${gh} workflow "$@"
  ''
