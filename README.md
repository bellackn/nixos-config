# nixos-config

# Prerequisites

## nixos

We have this setting here for SOPS:

```
sops.age.keyFile = "/home/n2o/.config/sops/age/keys.txt";
```

This means, before building the system, you need to put your AGE-SECRET-KEY there.

## nix-darwin

Same thing about SOPS, but the location is different:

```
sops.age.keyFile = "/Users/${user}/.config/sops/age/keys.txt";
```

Also, the Gradle config gets decrypted "manually" because setting up sops-nix with
nix-darwin is a PITA.

# Memos to Myself

- If an app just doesn't want to disappear from Launchpad, although you've
  installed and uninstalled it several times through Nix and whatnot, this
  command will definitely remove it:
  ```
  sqlite3 $(find /private/var/folders \( -name com.apple.dock.launchpad -a -user $USER \) 2> /dev/null)/db/db "DELETE FROM apps WHERE title='APP_NAME_CASE_SENSITIVE';" && killall Dock
  ```
- Use Homebrew to install GUI apps. This will save you hours of debugging why an
  app doesn't want to attach to the Dock and shit like that.

- Excellent resource: <https://github.com/dustinlyons/nixos-config>
