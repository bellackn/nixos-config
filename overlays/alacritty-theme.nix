# This is an exercise overlay to make the alacritty-theme package export the
# theme files to another location. Note how /share/alacritty/themes will be
# part of the theme definition path in modules/shared/dotfiles.nix.
final: prev: {
  alacritty-theme = prev.alacritty-theme.overrideAttrs (old: {
    installPhase = ''
      runHook preInstall
      install -Dm644 -t $out/share/alacritty/themes/ *.toml
      runHook postInstall
    '';
  });
}
