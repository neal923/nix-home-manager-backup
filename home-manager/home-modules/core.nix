{ ... }:
{
  # username / homeDirectory 按机器写在 hosts/<主机名>.nix，
  # 这里只放所有机器共用、且不应随机器改动的值。
  home.stateVersion = "25.11";
}
