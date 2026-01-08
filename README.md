```bash
## Nix
sh <(curl -L https://nixos.org/nix/install)

## flakes (once)
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

## git clone
git clone git@github.com:xxx.git ~/.config

## start
home-manager switch -b backup
```
