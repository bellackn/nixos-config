(final: prev: {
  lixPackageSets = prev.lixPackageSets // {
    stable = prev.lixPackageSets.stable // {
      # functional-nix-shell-basic fails in the macOS sandbox; skip tests since
      # the lix binary cache doesn't carry aarch64-darwin builds for this nixpkgs rev
      lix = prev.lixPackageSets.stable.lix.overrideAttrs (_: { doInstallCheck = false; });
    };
  };
  inherit (final.lixPackageSets.stable)
    nixpkgs-review
    nix-eval-jobs
    nix-fast-build
    colmena
    ;
})
