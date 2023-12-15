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

    # https://nix-community.github.io/home-manager/options.html#opt-programs.neovim.plugins
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
      ctrlp-vim
      emmet-vim
      far-vim
      goyo-vim
      gruvbox
      # incsearch-fuzzy
      limelight-vim
      markdown-preview-nvim
      nerdcommenter
      nerdtree
      vim-abolish
      vim-airline
      vim-airline-themes
      vim-better-whitespace
      vim-easymotion
      vim-floaterm
      vim-highlightedyank
      vim-move
      vim-nerdtree-syntax-highlight
      vim-nix
      vim-signify
      vim-startify
      zig-vim
    ];

    extraPackages = with pkgs; [
      nixpkgs-fmt
    ];

    viAlias = true;
    vimAlias = true;
  };
}
