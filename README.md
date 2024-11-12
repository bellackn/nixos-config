# nixos-config

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
