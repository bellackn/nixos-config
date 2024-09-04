{ pkgs, ... }:

{
  programs.vscode = {
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
}
