# dotfiles

macOS (Apple Silicon) 上的 Nix + Home Manager 配置，包含 Neovim 配置。

## 目录结构

```
~/dotfiles/
├── flake.nix               # Flake 入口，定义 homeConfigurations."nealwang"
├── flake.lock              # 锁定 nixpkgs / home-manager 版本，保证多机一致
├── home-manager/
│   ├── home.nix            # Home Manager 主配置，只负责 import 各模块
│   ├── starship.toml       # 被 home-modules/shell.nix 读取
│   └── home-modules/
│       ├── core.nix        # username / homeDirectory / stateVersion
│       ├── env.nix         # 环境变量
│       ├── packages.nix    # 常用软件包
│       ├── dev.nix         # 开发工具链
│       ├── shell.nix       # zsh / starship / tmux
│       ├── git.nix         # git 配置
│       ├── neovim.nix      # Neovim 包与插件，并把 nvim/ 部署到 ~/.config/nvim
│       └── macos.nix       # macOS 专属设置
└── nvim/                   # Neovim 源配置（本仓库唯一的 Neovim 真实来源）
    ├── init.lua
    └── lua/
        ├── options.lua     # 行号、缩进、剪贴板等
        ├── keymaps.lua     # 快捷键
        ├── lsp.lua         # 原生 LSP（nil / ts / rust-analyzer / jdtls）
        ├── theme.lua       # tokyonight + lualine
        └── treesitter.lua  # treesitter 高亮与缩进
```

## Neovim 配置是怎么生效的

```
~/dotfiles/nvim/          ← 你编辑这里
      ↓  home-modules/neovim.nix 里的 xdg.configFile."nvim".source = ../../nvim
   /nix/store/...-home-manager-files/.config/nvim
      ↓  Home Manager 建立软链接
~/.config/nvim            ← 只读软链接，不要直接编辑
      ↓
    Neovim
```

`~/.config/nvim` 是指向 `/nix/store` 的**只读**软链接，改不动也别去改。
Neovim 插件不由 lazy.nvim 之类管理，而是通过 `neovim.nix` 里的 `programs.neovim.plugins` 由 Nix 提供，走 packpath 自动加载，所以不需要 `:TSInstall`、也没有 lockfile 要维护。

## 日常使用

改完任何配置（Neovim 或 Home Manager）都要 switch 一次才生效：

```bash
home-manager switch --flake ~/dotfiles#nealwang -b backup
```

常见操作：

| 想做的事 | 改哪里 |
| --- | --- |
| 改 Neovim 选项 / 快捷键 / 主题 | `nvim/lua/` 下对应文件 |
| 加 Neovim 插件 | `home-manager/home-modules/neovim.nix` 的 `plugins` 列表 |
| 加命令行软件 | `home-manager/home-modules/packages.nix` |
| 改 shell / starship | `home-manager/home-modules/shell.nix`、`starship.toml` |

`-b backup` 表示遇到已存在的非托管文件时改名为 `.backup` 而不是报错，建议一直带着。

## 常用命令

```bash
# 应用配置
home-manager switch --flake ~/dotfiles#nealwang -b backup

# 只构建不激活，用来检查配置是否有错
nix build ~/dotfiles#homeConfigurations.nealwang.activationPackage

# 检查 nix 文件语法
nix flake check ~/dotfiles

# 查看历史 generation，出问题可以回滚
home-manager generations
/nix/store/xxx-home-manager-generation/activate   # 回滚到指定 generation
```

注意 Flake 只读取 **已被 git 跟踪** 的文件。新增文件后至少要 `git add`，否则 switch 时看不到它。

## 升级版本

```bash
cd ~/dotfiles
nix flake update                                          # 更新 nixpkgs 与 home-manager
home-manager switch --flake ~/dotfiles#nealwang -b backup
```

升级可能引入上游破坏性变更（例如 nvim-treesitter 重写后移除了 `nvim-treesitter.configs`），
switch 后建议启动一次 `nvim` 确认主题、行号、插件、LSP 都正常。
出问题就把 `flake.lock` 用 `git checkout flake.lock` 还原再 switch 回去。

## 新机器部署

```bash
# 1. 装 Nix
sh <(curl -L https://nixos.org/nix/install)

# 2. 开启 flakes（只需一次）
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# 3. 拉配置
git clone git@github.com:neal923/nix-home-manager-backup.git ~/dotfiles

# 4. 首次部署（此时还没有 home-manager 命令，用 nix run）
nix run home-manager/master -- switch --flake ~/dotfiles#nealwang -b backup
```

之后本机就有 `home-manager` 命令了，直接用上面「日常使用」里的写法。

需要调整的地方：

- 非 Apple Silicon 机器要改 `flake.nix` 里的 `system`（如 `x86_64-darwin`）
- 用户名不同要改 `home-manager/home-modules/core.nix` 的 `home.username` / `home.homeDirectory`，以及 `flake.nix` 里 `homeConfigurations` 的名字

## 故障排查

**`cannot connect to socket at '/nix/var/nix/daemon-socket/socket'`**

nix-daemon 没在跑，macOS 大版本升级后常见：

```bash
sudo launchctl kickstart -k system/org.nixos.nix-daemon
# 上面无效再试
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nix-daemon.plist
nix store info   # 确认恢复
```

**`Existing file ... is in the way`**

该路径存在非 Home Manager 管理的文件。确认可弃后删掉，或直接用 `-b backup` 让它自动改名。

**Neovim 报某个 lua 模块 not found**

通常是升级后上游插件 API 变了。先看报错来自 `nvim/lua/` 哪个文件，再对照该插件当前版本的 API 修改。
