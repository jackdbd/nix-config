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

    printf "\ngithub-tokens/workflow_developer\n"
    echo "secret found at ${secrets."github-tokens/workflow_developer".path}"
    echo "secret is $(cat ${secrets."github-tokens/workflow_developer".path})"

    echo "gh auth status (to check that GITHUB_TOKEN is set)"
    export GITHUB_TOKEN=$(cat ${secrets."github-tokens/workflow_developer".path})
    gh auth status

    printf "\nhacker-news/credentials\n"
    echo "secret found at ${secrets."hacker-news/credentials".path}"
    echo "secret is $(cat ${secrets."hacker-news/credentials".path})"

    printf "\nnpm-tokens/read_all_packages\n"
    echo "secret found at ${secrets."npm-tokens/read_all_packages".path}"
    echo "secret is $(cat ${secrets."npm-tokens/read_all_packages".path})"

    printf "\nreddit/trusted_client\n"
    echo "secret found at ${secrets."reddit/trusted_client".path}"
    echo "secret is $(cat ${secrets."reddit/trusted_client".path})"

    printf "\n GCP service account prj-kitchen-sink/sa-storage-uploader\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-storage-uploader".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-storage-uploader".path})"

    printf "\nstripe/personal/test\n"
    echo "secret found at ${secrets."stripe/personal/test".path}"
    echo "secret is $(cat ${secrets."stripe/personal/test".path})"

    printf "\ntelegram/personal_bot\n"
    echo "secret found at ${secrets."telegram/personal_bot".path}"
    echo "secret is $(cat ${secrets."telegram/personal_bot".path})"

    printf "\nwebmentions_io_token\n"
    echo "secret found at ${secrets."webmentions_io_token".path}"
    echo "secret is $(cat ${secrets."webmentions_io_token".path})"
  ''
