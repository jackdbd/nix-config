{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    # https://nix-community.github.io/home-manager/options.html#opt-programs.neovim.coc.settings
    coc = {
      enable = true;
      settings = {
        # https://github.com/neoclide/coc-tsserver?tab=readme-ov-file#configuration-options
        javascript = {
          format = {
            enable = true;
          };
          showUnused = true;
        };
        # https://github.com/neoclide/coc-json?tab=readme-ov-file#configuration-options
        json = {
          enable = true;
          validate.enable = true;
        };
        languageserver = {
          zls = {
            command = "zls";
            filetypes = [ "zig" ];
          };
        };
      };
    };

    extraConfig = "${builtins.readFile ./init.vim}";

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.plugins
    plugins = with pkgs.vimPlugins; [
      coc-json
      coc-nvim
      gruvbox
      vim-airline-themes
      vim-nix

      {
        plugin = ctrlp-vim;
        type = "viml";
        config = ''
          let g:ctrlp_map = '<c-p>'
          let g:ctrlp_cmd = 'CtrlP'
          let g:ctrlp_show_hidden = 1
        '';
      }
      {
        plugin = nerdtree;
        type = "viml";
        config = ''
          let NERDTreeShowHidden = 1
          let g:NERDTreeIgnore = ['^\.git$', '^node_modules$', '^zig-cache$']
        '';
      }
      {
        plugin = zig-vim;
        type = "viml";
        config = "let g:zig_fmt_autosave = 1";
      }
    ];

    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

  };
}
