{
  description = "Neal's macOS Nix + Home Manager dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      # 公共配置 + 该机器独有的 host 模块。
      mkHome = { system, hostModule }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home-manager/home.nix
            hostModule
          ];
        };

      # 每台机器一条，属性名用主机名（scutil --get LocalHostName）。
      # 新机器照 home-manager/hosts/example.nix 复制一份再加到这里。
      hosts = {
        "Neals-MacBook-Pro" = mkHome {
          system = "aarch64-darwin";
          hostModule = ./home-manager/hosts/neals-macbook-pro.nix;
        };
        "Neals-Mac-mini" = mkHome {
          system = "aarch64-darwin";
          hostModule = ./home-manager/hosts/neals-mac-mini.nix;
        };
      };
    in
    {
      homeConfigurations = hosts // {
        # 旧名字，留作别名避免记混
        nealwang = hosts."Neals-MacBook-Pro";
      };
    };
}
