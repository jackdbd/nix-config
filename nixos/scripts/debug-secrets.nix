{
  config,
  pkgs,
  ...
}: let
  secrets = config.sops.secrets;
in
  pkgs.writeShellScriptBin "debug-secrets" ''
    printf "=== DEBUG SECRETS ===\n"
    echo "defaultSopsFile is at ${config.sops.defaultSopsFile}"

    printf "\ngithub_token_workflow_developer\n"
    echo "secret found at ${secrets.github_token_workflow_developer.path}"
    echo "secret is $(cat ${secrets.github_token_workflow_developer.path})"

    echo "gh auth status (to check that GITHUB_TOKEN is set)"
    export GITHUB_TOKEN=$(cat ${secrets.github_token_workflow_developer.path})
    gh auth status

    printf "\nnpm_token_read_all_packages\n"
    echo "secret found at ${secrets."nested_secret/npm_token_read_all_packages".path}"
    echo "secret is $(cat ${secrets."nested_secret/npm_token_read_all_packages".path})"

    printf "\ndeeply-nested\n"
    echo "secret found at ${secrets."abc/def/ghi/deeply-nested".path}"
    echo "secret is $(cat ${secrets."abc/def/ghi/deeply-nested".path})"
  ''
