{ pkgs, ...}:

let
  add    = "${pkgs.openssh}/bin/ssh-add";
  agent  = "${pkgs.openssh}/bin/ssh-agent";
  keygen = "${pkgs.openssh}/bin/ssh-keygen";
in
  pkgs.writeShellScriptBin "gen-ssh-key" ''
    # Generate a SSH keypair (public + private key) and add them to the system
    # Usage:
    # gen-ssh-key "john.smith@acme.com"
    ${keygen} -t ed25519 -C $1
    eval $(${agent} -s)
    ${add} $HOME/.ssh/id_rsa
  ''