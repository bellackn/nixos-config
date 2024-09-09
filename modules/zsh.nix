{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      export EDITOR="nvim";
    '';

    shellAliases = {
      ap = "ansible-playbook";
      cdd = "cd ~/dev";
      j = "just";
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
