{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ". ~/.nix-profile/etc/profile.d/hm-session-vars.sh";

    shellAliases = {
      cdd = "cd ~/dev";
      tm = "tmux attach";
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vscode" ];
      theme = "agnoster";
    };
  };

}
