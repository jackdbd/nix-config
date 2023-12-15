{
  config,
  pkgs,
  ...
}:
# Usage:
# ghi list
# ghi create -a @me -l enhancement -t "My issue title"
# ghi status
# ghi view --web 15
# See: gh issue --help
let
  gh = "${pkgs.gh}/bin/gh";
in
  pkgs.writeShellScriptBin "ghi" ''
    export GITHUB_TOKEN=$(cat ${config.sops.secrets.github_token_workflow_developer.path})

    exec ${gh} issue "$@"
  ''
