{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    # 快捷键	作用
    # Ctrl-a	行首
    # Ctrl-e	行尾
    # Alt-b	  左跳一个词
    # Alt-f	  右跳一个词
    # Ctrl-w	删除左侧一个词
    # Alt-d	  删除右侧一个词
    # Ctrl-u	删到行首
    # Ctrl-k	删到行尾
    initContent = ''
      # 使用 Emacs 风格（Ctrl-n / Ctrl-p）
      bindkey -e
      bindkey '^W' backward-kill-word
      bindkey '^U' backward-kill-line
      bindkey '^R' history-incremental-search-backward

      # 补全菜单：Tab 后用 Ctrl-n / Ctrl-p 选择
      zstyle ':completion:*' menu select

      # 补全忽略大小写
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      # Ctrl x / e 编辑缓存区
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^Xe' edit-command-line
      
      # !* !?
      bindkey ' ' magic-space

      # Suffix Aliases
      alias -s md="bat"
      alias -s png="open"
      alias -s js="$EDITOR"
      alias -s ts="$EDITOR"

      # Clear screen, keep buffer
      clear-keep-buffer() {
        zle clear-screen
      }
      zle -N clear-keep-buffer
      bindkey '^Xl' clear-keep-buffer

      # Copy current command to clipboard
      copy-command() {
        echo -n $BUFFER | pbcopy # or xclip
        zle -M "Copied to clipboard"
      }
      zle -N copy-command
      bindkey '^Xc' copy-command

      # 连续 Tab 显示列表
      setopt AUTO_LIST
      setopt AUTO_MENU
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_VERIFY
    '';
    history = {
      size = 100000;
      save = 100000;
      share = true;
    };
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML
      (builtins.readFile ../starship.toml);
  };

  programs.fzf = {
    # Ctrl-R  history
    # Alt-C   目录跳转
    # Ctrl-T  文件选择

    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--reverse"
      "--border"
    ];
  };

  programs.zoxide = {
    # z
    # zi

    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    keyMode = "vi";

    extraConfig = ''
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      set -g mouse on
      setw -g mode-keys vi

      # pane move
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}

