let
  more = { lib, pkgs, ... }: {
    programs = {
      bat.enable = true;

      broot.enable = true;

      # Configuration for Chromium and its extensions
      # https://codeberg.org/davidak/nixos-config/src/branch/main/profiles/desktop.nix
      # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/chromium.nix
      # https://github.com/gvolpe/nix-config/blob/master/home/programs/browsers/extensions.nix
      chromium = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.chromium.commandLineArgs
        commandLineArgs = [];
        # https://nix-community.github.io/home-manager/options.html#opt-programs.chromium.extensions
        extensions = [
          # Lastpass
          { id = "hdokiejnpimakedhajhdlcegeplioahd"; }
          # Vimium
          { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
        ];
      };
 
      direnv = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.direnv.config
        # https://direnv.net/man/direnv.toml.1.html
        config = {
          global = {
            strict_env = true;
          };
        };
        enableBashIntegration = true; # see note on other shells below
        # https://github.com/nix-community/nix-direnv
        nix-direnv.enable = true;
      };

      feh.enable = true;

      htop.enable = true;

      lazygit = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.lazygit.settings
        settings = {};
      };
        

      neovim = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.neovim.enable
      };

      rofi = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.rofi.extraConfig
        extraConfig = {
          icon-theme = "Papirus";
          show-icons = true;
        };
        font = "JetBrainsMono Nerd Font 14";
        # https://nix-community.github.io/home-manager/options.html#opt-programs.rofi.plugins
        plugins = [];
        # Available named themes can be viewed using the rofi-theme-selector tool.
        theme = "gruvbox-dark";
      };

      starship = {
        enable = true;
        enableBashIntegration = true;
        # https://starship.rs/config/#prompt
        # https://raw.githubusercontent.com/onlyvip/starship.toml/main/starship.toml
        # https://nix-community.github.io/home-manager/options.html#opt-programs.starship.settings
        settings = {
          add_newline = true;
          format = "$all";
          # format = lib.concatStrings [
          #   # "$shlvl"
          #   "$shell"
          #   "$username"
          #   "$hostname"
          #   "$nix_shell"
          #   "$git_branch"
          #   "$git_commit"
          #   "$git_state"
          #   "$git_status"
          #   "$directory"
          #   "$jobs"
          #   "$cmd_duration"
          #   "$character"
          # ];
          # character = {
          #   error_symbol = "➜";
          #   success_symbol = "➜";
          # };
          # scan_timeout = 10;
          # shlvl = {
          #   disabled = false;
          #   symbol = "ﰬ";
          #   style = "bright-red bold";
          # };
          # shell = {
          #   disabled = false;
          #   format = "$indicator";
          #   bash_indicator = "[BASH](bright-white) ";
          #   zsh_indicator = "[ZSH](bright-white) ";
          # };
          # https://starship.rs/config/#google-cloud-gcloud
          gcloud = {
            disabled = true;
          };
          # https://starship.rs/config/#hostname
          hostname = {
            ssh_only = true;
          };
          jobs.disabled = true;
          # https://starship.rs/config/#os
          os.disabled = true;
          # https://starship.rs/config/#username
          username = {
            show_always = false;
            # style_user = "bright-white bold";
            style_root = "bright-red bold";
          };
        };
      };

      tealdeer = {
        enable = true;
        # https://nix-community.github.io/home-manager/options.html#opt-programs.tealdeer.settings
        # https://dbrgn.github.io/tealdeer/config.html
        settings = {};
      };

      vim.enable = true;

      zathura.enable = true;

      zoxide.enable = true;
    };
  };
in
[
  ./alacritty
  ./atuin
  ./bash
  ./git
  ./vscode
  more
]