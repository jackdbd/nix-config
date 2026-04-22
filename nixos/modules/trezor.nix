{
  pkgs,
  ...
}:
{
  meta = { };

  imports = [ ];

  options = { };

  # TODO: the overall support for hardware devices like the Trezor does not seem great among email clients:
  # - https://github.com/openpgpjs/openpgpjs/issues/362
  # - https://github.com/FlowCrypt/flowcrypt-browser/issues/964
  # - https://github.com/ProtonMail/WebClients/issues/122
  # So, for the time being I have decided NOT to store my private OpenPGP key on the Trezor.
  # If and when I decide to change my mind about this, I will enable trezor_agent and set the GNUPGHOME environment variable.

  # https://nixos.org/manual/nixos/stable/#trezor
  # https://mynixos.com/nixpkgs/package/trezord
  # https://docs.trezor.io/trezor-user-env/development.html
  config = {
    environment.systemPackages = with pkgs; [
      trezor-suite # Desktop App for managing crypto
      # trezor_agent # hardware-based agent for SSH/OpenPGP/age keys
    ];

    environment.sessionVariables = {
      # This tells trezor-agent that all my private keys are backed by my Trezor.
      # Unset this environment variable if you wish to switch back to your software keys.
      # https://github.com/romanz/trezor-agent/blob/master/doc/README-GPG.md
      # GNUPGHOME = "$HOME/.gnupg/trezor";
    };
  };
}
