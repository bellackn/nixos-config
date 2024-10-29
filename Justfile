_default:
    @just --list

alias t := test
alias u := update
alias f := flake

# Copy all files from this repo to /etc/nixos
deploy:
    @sudo cp -r * /etc/nixos

# Activate the config in /etc/nixos, but don't add it to the bootloader
test: deploy
    @sudo nixos-rebuild test

# Activate the config in /etc/nixos, update packages, and add the
# new config to the bootloader
[linux]
update: deploy
    @sudo nixos-rebuild switch --upgrade

[macos]
update:
    @darwin-rebuild switch --flake .

# Delete old NixOS generations and perform garbage collection
gc age:
    @sudo nix-collect-garbage --delete-older-than {{ age }}
    @nix-env --delete-generations {{ age }}

# Update flake and rebuild system
flake:
    @sudo nix flake update
    @just update
