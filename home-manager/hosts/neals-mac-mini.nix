# 本机：Neals-Mac-mini
#
# 只放本机独有的配置，公共部分在 home-manager/home.nix 里 import。
{ ... }:
{
  # username 必须等于 `whoami`，不能写成家目录名。
  # 这台机器两者一致：whoami=nealwang，HOME=/Users/nealwang。
  home.username = "nealwang";
  home.homeDirectory = "/Users/nealwang";

  # 本机没有 privoxy。env.nix 默认不设 http_proxy，这里也不开代理。
}
