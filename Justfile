_default:
    @just --list

# Copy all files from this repo to /etc/nixos
deploy:
    @sudo cp -r * /etc/nixos
alias d := deploy

# Activate the config in /etc/nixos, but don't add it to the bootloader
test: deploy
    @sudo nixos-rebuild test
alias t := test

# Activate the config in /etc/nixos, update packages, and add the
# new config to the bootloader
update: deploy
    @sudo nixos-rebuild switch --upgrade
alias u := update

# Delete old NixOS generations and perform garbage collection
gc age:
    @sudo nix-collect-garbage --delete-older-than {{ age }}
