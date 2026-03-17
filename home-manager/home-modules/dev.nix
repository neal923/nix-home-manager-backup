{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_24
    pnpm
    yarn

    rustc
    cargo
    rustfmt
    clippy
    bun

    # Java（需要再开）
    # jdk21
  ];
}
