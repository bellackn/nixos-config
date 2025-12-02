_default:
    @just --list

alias t := test
alias u := update
alias f := flake

# Activate the config, but don't add it to the bootloader
test:
    @sudo nixos-rebuild test --impure --flake .

# Activate the config, update packages, and add the
# new config to the bootloader
[linux]
update:
    @sudo nixos-rebuild switch --impure --flake .

# Activate the config, update packages, and decrypt the Gradle config
[macos]
update:
    @sudo darwin-rebuild switch --impure --flake .
    @./scripts/decrypt-gradle.sh || echo "↪️ Not on emeldir, nevermind!"

# Update flake and rebuild system
[linux]
flake:
    @sudo nix flake update
    @just update

# Update flake and rebuild system
[macos]
flake:
    @nix flake update
    @just update
