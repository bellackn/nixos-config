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
      k = "kubectl";
      kn = "kubens"; # installed manually via "krew install ns"
      kx = "kubectx";
      syu = "systemctl --user";
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
