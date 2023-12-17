{pkgs, ...}: {
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
            filetypes = ["zig"];
          };
        };
      };
    };

    extraConfig = "${builtins.readFile ./init.vim}";

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.plugins
    plugins = with pkgs.vimPlugins; let
      incsearch-fuzzy = pkgs.vimUtils.buildVimPlugin {
        pname = "incsearch-fuzzy";
        version = "2016-12-15";
        src = fetchGit {
          url = "https://github.com/haya14busa/incsearch-fuzzy.vim";
          ref = "master";
        };
      };
    in [
      coc-json # validation support for CoC
      coc-nvim # autocompletion
      coc-tsserver
      {
        plugin = ctrlp-vim;
        config = ''
          let g:ctrlp_map = '<c-p>'
          let g:ctrlp_cmd = 'CtrlP'
          let g:ctrlp_show_hidden = 1
        '';
      }
      emmet-vim
      {
        plugin = far-vim;
        # improve scrolling performance when navigating through large results
        config = "set lazyredraw";
      }
      goyo-vim
      gruvbox
      # incsearch-fuzzy
      {
        plugin = limelight-vim;
        config = "let g:limelight_conceal_ctermfg = 'gray'";
      }
      markdown-preview-nvim
      {
        plugin = nerdcommenter;
        config = "let g:NERDCreateDefaultMappings = 1";
      }
      {
        plugin = nerdtree;
        config = ''
          let NERDTreeShowHidden = 1
          let g:NERDTreeIgnore = ['^\.git$', '^node_modules$', '^zig-cache$']
        '';
      }
      vim-abolish
      {
        plugin = vim-airline;
        config = "let g:airline#extensions#tabline#enabled = 1";
      }
      vim-airline-themes
      vim-better-whitespace
      vim-easymotion
      {
        plugin = vim-floaterm;
        config = ''
          let g:floaterm_keymap_new = '<Leader>ft'
          let g:floaterm_keymap_toggle = '<Leader>t'
        '';
      }
      {
        plugin = vim-highlightedyank;
        config = "let g:highlightedyank_highlight_duration = 1000"; # in ms
      }
      {
        plugin = vim-move;
        config = "let g:move_key_modifier = 'C'"; # C means Ctrl => C-k, C-j, C-h, C-l
      }
      vim-nerdtree-syntax-highlight
      vim-nix
      {
        plugin = vim-signify;
        # default updatetime 4000ms is not good for async update
        config = "set updatetime=100";
      }
      vim-startify
      {
        plugin = zig-vim;
        config = "let g:zig_fmt_autosave = 1";
      }
    ];

    extraPackages = with pkgs; [
      nixpkgs-fmt
    ];

    viAlias = true;
    vimAlias = true;
  };
}
