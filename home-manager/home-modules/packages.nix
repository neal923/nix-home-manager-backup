{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    curl
    wget
    fd
    ripgrep
    bat
    eza
    fzf
    tmuxPlugins.vim-tmux-navigator

    # --- Shell ---
    antidote
    starship

    # --- 构建/通用 ---
    pkg-config
    openssl

    docker-client
    docker-compose
    colima

    direnv
    nix-direnv
  ];
}
