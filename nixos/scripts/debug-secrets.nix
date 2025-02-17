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

    printf "\nclojars\n"
    echo "secret found at ${secrets."clojars".path}"
    echo "secret is $(cat ${secrets."clojars".path})"

    printf "\ncloudflare/r2\n"
    echo "secret found at ${secrets."cloudflare/r2".path}"
    echo "secret is $(cat ${secrets."cloudflare/r2".path})"

    printf "\ncloudflare/tokens\n"
    echo "secret found at ${secrets."cloudflare/tokens".path}"
    echo "secret is $(cat ${secrets."cloudflare/tokens".path})"

    printf "\ncloudinary\n"
    echo "secret found at ${secrets."cloudinary".path}"
    echo "secret is $(cat ${secrets."cloudinary".path})"

    printf "\ncodecov/token\n"
    echo "secret found at ${secrets."codecov/token".path}"
    echo "secret is $(cat ${secrets."codecov/token".path})"

    printf "\nelevenlabs/api_key\n"
    echo "secret found at ${secrets."elevenlabs/api_key".path}"
    echo "secret is $(cat ${secrets."elevenlabs/api_key".path})"

    printf "\nfastly/api_token\n"
    echo "secret found at ${secrets."fastly/api_token".path}"
    echo "secret is $(cat ${secrets."fastly/api_token".path})"

    printf "\nfly/indiekit\n"
    echo "secret found at ${secrets."fly/indiekit".path}"
    echo "secret is $(cat ${secrets."fly/indiekit".path})"

    printf "\nfly/micropub\n"
    echo "secret found at ${secrets."fly/micropub".path}"
    echo "secret is $(cat ${secrets."fly/micropub".path})"

    printf "\nfly/tokens\n"
    echo "secret found at ${secrets."fly/tokens".path}"
    echo "secret is $(cat ${secrets."fly/tokens".path})"

    printf "\ngithub-tokens/crud_contents_api\n"
    echo "secret found at ${secrets."github-tokens/crud_contents_api".path}"
    echo "secret is $(cat ${secrets."github-tokens/crud_contents_api".path})"

    printf "\ngithub-tokens/dispatch_to_personal_website\n"
    echo "secret found at ${secrets."github-tokens/dispatch_to_personal_website".path}"
    echo "secret is $(cat ${secrets."github-tokens/dispatch_to_personal_website".path})"

    printf "\ngithub-tokens/github_packages_push\n"
    echo "secret found at ${secrets."github-tokens/github_packages_push".path}"
    echo "secret is $(cat ${secrets."github-tokens/github_packages_push".path})"

    printf "\ngithub-tokens/semantic_release_bot\n"
    echo "secret found at ${secrets."github-tokens/semantic_release_bot".path}"
    echo "secret is $(cat ${secrets."github-tokens/semantic_release_bot".path})"

    printf "\ngithub-tokens/workflow_developer\n"
    echo "secret found at ${secrets."github-tokens/workflow_developer".path}"
    echo "secret is $(cat ${secrets."github-tokens/workflow_developer".path})"

    echo "gh auth status (to check that GITHUB_TOKEN is set)"
    export GITHUB_TOKEN=$(cat ${secrets."github-tokens/workflow_developer".path})
    gh auth status

    printf "\ngo-jamming\n"
    echo "secret found at ${secrets."go-jamming".path}"
    echo "secret is $(cat ${secrets."go-jamming".path})"

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

    printf "\nmicropub\n"
    echo "secret found at ${secrets."micropub".path}"
    echo "secret is $(cat ${secrets."micropub".path})"

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

    printf "\nopenai/personal_api_key\n"
    echo "secret found at ${secrets."openai/personal_api_key".path}"
    echo "secret is $(cat ${secrets."openai/personal_api_key".path})"

    printf "\nplausible/test_site\n"
    echo "secret found at ${secrets."plausible/test_site".path}"
    echo "secret is $(cat ${secrets."plausible/test_site".path})"

    printf "\npulumi/access_token\n"
    echo "secret found at ${secrets."pulumi/access_token".path}"
    echo "secret is $(cat ${secrets."pulumi/access_token".path})"

    printf "\nreddit/trusted_client\n"
    echo "secret found at ${secrets."reddit/trusted_client".path}"
    echo "secret is $(cat ${secrets."reddit/trusted_client".path})"

    printf "\nGCP service account prj-kitchen-sink/sa-firestore-user-test\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-firestore-user-test".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-firestore-user-test".path})"

    printf "\nGCP service account prj-kitchen-sink/sa-firestore-viewer-test\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-firestore-viewer-test".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-firestore-viewer-test".path})"

    printf "\nGCP service account prj-kitchen-sink/sa-notifier\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-notifier".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-notifier".path})"

    printf "\nGCP service account prj-kitchen-sink/sa-secret-manager-admin-test\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-secret-manager-admin-test".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-secret-manager-admin-test".path})"

    printf "\nGCP service account prj-kitchen-sink/sa-storage-uploader\n"
    echo "secret found at ${secrets."prj-kitchen-sink/sa-storage-uploader".path}"
    echo "secret is $(cat ${secrets."prj-kitchen-sink/sa-storage-uploader".path})"

    printf "\nstripe/personal/live\n"
    echo "secret found at ${secrets."stripe/personal/live".path}"
    echo "secret is $(cat ${secrets."stripe/personal/live".path})"

    printf "\nstripe/personal/test\n"
    echo "secret found at ${secrets."stripe/personal/test".path}"
    echo "secret is $(cat ${secrets."stripe/personal/test".path})"

    printf "\nsyncthing/api_key\n"
    echo "secret found at ${secrets."syncthing/api_key".path}"
    echo "secret is $(cat ${secrets."syncthing/api_key".path})"

    printf "\nsyncthing/gui_credentials\n"
    echo "secret found at ${secrets."syncthing/gui_credentials".path}"
    echo "secret is $(cat ${secrets."syncthing/gui_credentials".path})"

    printf "\ntelegram/jackdbd_github_bot\n"
    echo "secret found at ${secrets."telegram/jackdbd_github_bot".path}"
    echo "secret is $(cat ${secrets."telegram/jackdbd_github_bot".path})"

    printf "\ntelegram/jackdbd_youtube_videos_bot\n"
    echo "secret found at ${secrets."telegram/jackdbd_youtube_videos_bot".path}"
    echo "secret is $(cat ${secrets."telegram/jackdbd_youtube_videos_bot".path})"

    printf "\ntelegram/personal_bot\n"
    echo "secret found at ${secrets."telegram/personal_bot".path}"
    echo "secret is $(cat ${secrets."telegram/personal_bot".path})"

    printf "\nturso/micropub\n"
    echo "secret found at ${secrets."turso/micropub".path}"
    echo "secret is $(cat ${secrets."turso/micropub".path})"

    printf "\nturso/tweedler\n"
    echo "secret found at ${secrets."turso/tweedler".path}"
    echo "secret is $(cat ${secrets."turso/tweedler".path})"

    printf "\nGCP Application Default Credentials (ADC) virtual-machines/adc\n"
    echo "secret found at ${secrets."virtual-machines/adc".path}"
    echo "secret is $(cat ${secrets."virtual-machines/adc".path})"

    printf "\nwebmentions_io_token\n"
    echo "secret found at ${secrets."webmentions_io_token".path}"
    echo "secret is $(cat ${secrets."webmentions_io_token".path})"
  ''
