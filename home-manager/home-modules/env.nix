{ ... }:
{
  home.sessionVariables = {
    NO_PROXY = "localhost,127.0.0.1,::1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12";
    http_proxy  = "http://127.0.0.1:8118";
    https_proxy = "http://127.0.0.1:8118";
  };
}
