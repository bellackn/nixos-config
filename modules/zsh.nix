{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ". ~/.nix-profile/etc/profile.d/hm-session-vars.sh";

    shellAliases = {
      cdd = "cd ~/dev";
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

}
