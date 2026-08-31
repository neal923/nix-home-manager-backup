# 新机器模板。
#
# 用法：
#   1. scutil --get LocalHostName            # 查本机主机名
#   2. cp example.nix <主机名小写>.nix
#   3. 在仓库根 flake.nix 的 hosts 里加一条，属性名用主机名
#   4. git add，否则 flake 看不到新文件
#
# 这个文件本身不会被任何配置 import，纯粹是模板。
{ ... }:
{
  # 本机没有代理就什么都不用写：env.nix 默认不设 http_proxy。
  # 本机有代理时改成实际端口后取消注释：
  #
  # home.sessionVariables = {
  #   http_proxy  = "http://127.0.0.1:7890";
  #   https_proxy = "http://127.0.0.1:7890";
  # };

  # 本机专属软件包（用到 pkgs 时记得把上面的 { ... } 改成 { pkgs, ... }）：
  #
  # home.packages = with pkgs; [ ];
}
