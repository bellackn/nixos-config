_default:
    @just --list

alias t := test
alias u := update
alias f := flake

# Activate the config, but don't add it to the bootloader
test:
    @sudo nixos-rebuild test --flake .

# Activate the config, update packages, and add the
# new config to the bootloader
[linux]
update:
    @sudo nixos-rebuild switch --flake .

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
