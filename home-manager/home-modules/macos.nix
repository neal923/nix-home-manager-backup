{ pkgs, ... }:

{
  home.packages = pkgs.lib.optionals pkgs.stdenv.isDarwin [
    pkgs.coreutils
  ];
}
