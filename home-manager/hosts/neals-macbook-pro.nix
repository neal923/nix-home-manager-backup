# A 机：Neals-MacBook-Pro
#
# 只放本机独有的配置，公共部分在 home-manager/home.nix 里 import。
{ ... }:
{
  home.username = "neal";
  home.homeDirectory = "/Users/neal";

  # 本机跑着 privoxy，监听 8118。
  home.sessionVariables = {
    http_proxy  = "http://127.0.0.1:8118";
    https_proxy = "http://127.0.0.1:8118";
  };
}
