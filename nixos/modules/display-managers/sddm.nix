{...}: {
  meta = {
    # TODO: I don't know why, but NixOS tells me meta.description does not exist.
    # description = "A custom NixOS module for configuring SDDM";
    # license = pkgs.lib.licenses.mit;
  };

  imports = [];

  options = {};

  config = {
    # Enables autologin. See also here to configure a fingerprint reader.
    # https://timothymiller.dev/posts/2024/auto-login-with-nixos-and-kde-plasma/
    # services.displayManager = {
    #   autoLogin.enable = true;
    #   autoLogin.user = "jack";
    # };

    services.displayManager.sddm = {
      enable = true;

      # Uncomment the following 2 lines to enable Wayland support in SDDM.
      # services.xserver.enable = false;
      # wayland.enable = true;
    };
  };
}
