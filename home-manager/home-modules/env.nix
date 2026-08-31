{ ... }:
{
  # 公共环境变量。默认不设 http_proxy / https_proxy：
  # 代理是每台机器各不相同的东西，放在 hosts/<主机名>.nix 里按机器开。
  # 没有代理的机器如果继承了死代理地址，curl / git / nix 会全部超时失败。
  home.sessionVariables = {
    NO_PROXY = "localhost,127.0.0.1,::1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12";
  };
}
