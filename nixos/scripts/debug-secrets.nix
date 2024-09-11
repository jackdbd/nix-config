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

    printf "\nAWS configuration profile: default\n"
    echo "secret found at ${secrets."aws/default".path}"
    echo "secret is $(cat ${secrets."aws/default".path})"

    printf "\ncal\n"
    echo "secret found at ${secrets."cal".path}"
    echo "secret is $(cat ${secrets."cal".path})"

    printf "\ncloudflare_r2/personal\n"
    echo "secret found at ${secrets."cloudflare_r2/personal".path}"
    echo "secret is $(cat ${secrets."cloudflare_r2/personal".path})"

    printf "\ncloudinary\n"
    echo "secret found at ${secrets."cloudinary".path}"
    echo "secret is $(cat ${secrets."cloudinary".path})"

    printf "\nelevenlabs/api_key\n"
    echo "secret found at ${secrets."elevenlabs/api_key".path}"
    echo "secret is $(cat ${secrets."elevenlabs/api_key".path})"

    printf "\nfastly/api_token\n"
    echo "secret found at ${secrets."fastly/api_token".path}"
    echo "secret is $(cat ${secrets."fastly/api_token".path})"

    printf "\ngithub-tokens/semantic_release_bot\n"
    echo "secret found at ${secrets."github-tokens/semantic_release_bot".path}"
    echo "secret is $(cat ${secrets."github-tokens/semantic_release_bot".path})"

    printf "\ngithub-tokens/workflow_developer\n"
    echo "secret found at ${secrets."github-tokens/workflow_developer".path}"
    echo "secret is $(cat ${secrets."github-tokens/workflow_developer".path})"

    echo "gh auth status (to check that GITHUB_TOKEN is set)"
    export GITHUB_TOKEN=$(cat ${secrets."github-tokens/workflow_developer".path})
    gh auth status

    printf "\nhacker-news/credentials\n"
    echo "secret found at ${secrets."hacker-news/credentials".path}"
    echo "secret is $(cat ${secrets."hacker-news/credentials".path})"

    printf "\nindiekit\n"
    echo "secret found at ${secrets."indiekit".path}"
    echo "secret is $(cat ${secrets."indiekit".path})"

    printf "\nlinkedin/trusted_client\n"
    echo "secret found at ${secrets."linkedin/trusted_client".path}"
    echo "secret is $(cat ${secrets."linkedin/trusted_client".path})"

    printf "\nmastodon\n"
    echo "secret found at ${secrets."mastodon".path}"
    echo "secret is $(cat ${secrets."mastodon".path})"

    printf "\nminiflux\n"
    echo "secret found at ${secrets."miniflux".path}"
    echo "secret is $(cat ${secrets."miniflux".path})"

    printf "\nngrok/auth_token\n"
    echo "secret found at ${secrets."ngrok/auth_token".path}"
    echo "secret is $(cat ${secrets."ngrok/auth_token".path})"

    printf "\nnpm\n"
    echo "secret found at ${secrets."npm".path}"
    echo "secret is $(cat ${secrets."npm".path})"

    printf "\nnpm-tokens/read_all_packages\n"
    echo "secret found at ${secrets."npm-tokens/read_all_packages".path}"
    echo "secret is $(cat ${secrets."npm-tokens/read_all_packages".path})"

    printf "\nnpm-tokens/semantic_release_bot\n"
    echo "secret found at ${secrets."npm-tokens/semantic_release_bot".path}"
    echo "secret is $(cat ${secrets."npm-tokens/semantic_release_bot".path})"

    printf "\nplausible/test_site\n"
    echo "secret found at ${secrets."plausible/test_site".path}"
    echo "secret is $(cat ${secrets."plausible/test_site".path})"

    printf "\npulumi/access_token\n"
    echo "secret found at ${secrets."pulumi/access_token".path}"
    echo "secret is $(cat ${secrets."pulumi/access_token".path})"

    printf "\nreddit/trusted_client\n"
    echo "secret found at ${secrets."reddit/trusted_client".path}"
    echo "secret is $(cat ${secrets."reddit/trusted_client".path})"

    printf "\nGCP service account prj-kitchen-sink/sa-storage-uploader\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-storage-uploader".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-storage-uploader".path})"

    printf "\nstripe/personal/test\n"
    echo "secret found at ${secrets."stripe/personal/test".path}"
    echo "secret is $(cat ${secrets."stripe/personal/test".path})"

    printf "\nsyncthing/api_key\n"
    echo "secret found at ${secrets."syncthing/api_key".path}"
    echo "secret is $(cat ${secrets."syncthing/api_key".path})"

    printf "\nsyncthing/gui_credentials\n"
    echo "secret found at ${secrets."syncthing/gui_credentials".path}"
    echo "secret is $(cat ${secrets."syncthing/gui_credentials".path})"

    printf "\ntelegram/personal_bot\n"
    echo "secret found at ${secrets."telegram/personal_bot".path}"
    echo "secret is $(cat ${secrets."telegram/personal_bot".path})"

    printf "\nGCP Application Default Credentials (ADC) virtual-machines/adc\n"
    echo "secret found at ${secrets."virtual-machines/adc".path}"
    echo "secret is $(cat ${secrets."virtual-machines/adc".path})"

    printf "\nwebmentions_io_token\n"
    echo "secret found at ${secrets."webmentions_io_token".path}"
    echo "secret is $(cat ${secrets."webmentions_io_token".path})"
  ''
