{ pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      tree-sitter
    ];

    plugins = with pkgs.vimPlugins; [
      # UI
      tokyonight-nvim
      lualine-nvim

      # File Tree
      nvim-tree-lua
      nvim-web-devicons

      # Syntax
      nvim-treesitter.withAllGrammars

      # Editing
      vim-surround
      vim-repeat
      comment-nvim

      # Git
      gitsigns-nvim

      # tmux
      vim-tmux-navigator
    ];
  };
}
