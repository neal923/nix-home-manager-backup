{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/core.nix
    ./home-modules/env.nix
    ./home-modules/packages.nix
    ./home-modules/dev.nix
    ./home-modules/shell.nix
    ./home-modules/git.nix
    ./home-modules/neovim.nix
    ./home-modules/macos.nix
  ];
}

