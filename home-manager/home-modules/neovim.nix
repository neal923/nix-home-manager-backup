{ pkgs, ...}:

{
  # 源配置位于仓库根的 nvim/，由 Home Manager 部署到 ~/.config/nvim
  xdg.configFile."nvim".source = ../../nvim;

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
