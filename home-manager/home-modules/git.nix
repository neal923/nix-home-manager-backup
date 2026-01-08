{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "neal";
      user.email = "neal.technology@outlook.com";
    };
  };
}
