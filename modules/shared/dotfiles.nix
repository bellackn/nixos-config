{ pkgs }:

let
  fullName = "Nico Bellack";
  email = "nico@bellack.dev";
in
{

  alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "DroidSansM Nerd Font";
        size = 14;
      };
    };
  };

  eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  git = {
    enable = true;
    signing = {
      key = "E0BBEA7A2F210D3C98856711F492D6B0CD155CD3";
      signByDefault = true;
    };
    userName = fullName;
    userEmail = email;
  };

  mcfly = {
    enable = true;
    fzf.enable = true;
    keyScheme = "vim";
  };

  nixvim = {
    enable = true;
    opts =
      {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };
    plugins = {
      lightline.enable = true;
    };
  };

  starship = {
    enable = true;
  };

  tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-a";

    extraConfig = ''
      # Split panes with + and -
      bind + split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
  
      # Switch panes using Alt-Arrow w/o prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
  
      # Synchronize panes on/off
      bind-key X set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,on,off}"
    '';

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = "set -g @tmux_power_theme 'sky'";
      }
    ];
  };

  vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      hashicorp.terraform
      jnoortheen.nix-ide
      ms-python.python
      pkief.material-icon-theme
      redhat.ansible
      #wolfmah-vscode.just-syntax
    ];

    userSettings = {
      # General
      "files.autoSave" = "afterDelay";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.fontFamily" = "DroidSansM Nerd Font Mono";
      "terminal.integrated.fontSize" = 14;
      "window.autoDetectColorScheme" = true;
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.preferredDarkColorTheme" = "Dracula Theme";
      "workbench.preferredLightColorTheme" = "Default Light Modern";

      # Editor
      "editor.bracketPairColorization.enabled" = true;
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
      "editor.guides.bracketPairs" = true;
      "editor.rulers" = [ 80 ];

      # Git
      # "git.enableCommitSigning" = true;
      "gitlens.telemetry.enabled" = false;
      # "pre-commit-helper.runOnSave" = "all hooks";     

      # Ansible
      "[ansible]"."editor.detectIndentation" = true;
      "[ansible]"."editor.insertSpaces" = true;
      "[ansible]"."editor.tabSize" = 2;
      "[ansible]"."editor.quickSuggestions.comments" = true;
      "[ansible]"."editor.quickSuggestions.other" = true;
      "[ansible]"."editor.quickSuggestions.strings" = true;
      "redhat.telemetry.enabled" = false;

      # Docker
      "[dockerfile]"."editor.defaultFormatter" = "ms-azuretools.vscode-docker";

      # Python
      "python.createEnvironment.trigger" = "prompt";
      "python.terminal.activateEnvInCurrentTerminal" = true;
      "python.venvPath" = "~/.local/share/virtualenvs";
      "autoDocstring.docstringFormat" = "sphinx";

      # Web
      "debug.javascript.defaultRuntimeExecutable.pwa-node" = "node";
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "svelte.enable-ts-plugin" = true;
      "svelte.plugin.svelte.note-new-transformation" = false;
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

      # Vim bindings
      "vim.digraphs" = { };
      "vim.smartRelativeLine" = true;
      "vim.useSystemClipboard" = true;
    };
  };

  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      export EDITOR="nvim";
    '';

    shellAliases = {
      ap = "ansible-playbook";
      avd = "ansible-vault decrypt";
      ave = "ansible-vault encrypt";
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