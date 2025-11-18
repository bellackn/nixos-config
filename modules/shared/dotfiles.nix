{ pkgs }:

let
  fullName = "Nico Bellack";
  email = "nico@bellack.dev";
  localDomain = "z.lan";
in
{

  alacritty = {
    enable = true;
    settings = {
      # The theme path is different because of the exercise overlay. Normally
      # you could've just used "${pkgs.alacritty-theme}/gruvbox_material_medium_dark.toml".
      general.import = [
        "${pkgs.alacritty-theme}/share/alacritty/themes/gruvbox_material_medium_dark.toml"
      ];

      font = {
        normal.family =
          {
            x86_64-linux = "DroidSansM Nerd Font";
            aarch64-darwin = "DroidSansM Nerd Font Mono";
          }
          .${pkgs.system};
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
    settings = {
      user.name = fullName;
      user.email = email;
      push.autosetupremote = true;
      branch.autosetuprebase = "always";
    };
  };

  mcfly = {
    enable = true;
    fzf.enable = true;
    keyScheme = "vim";
  };

  nixvim = {
    enable = true;
    opts = {
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
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";

    extraConfig = ''
      # Use Ctrl-A and Ctrl-E to jump to begin/end of line
      bind a send-prefix

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

    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        alesbrelih.gitlab-ci-ls
        charliermarsh.ruff
        dracula-theme.theme-dracula
        eamodio.gitlens
        esbenp.prettier-vscode
        fill-labs.dependi
        gitlab.gitlab-workflow
        hashicorp.terraform
        jnoortheen.nix-ide
        ms-azuretools.vscode-docker
        ms-python.python
        nefrob.vscode-just-syntax
        nicolasvuillamy.vscode-groovy-lint
        pkief.material-icon-theme
        redhat.ansible
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        svelte.svelte-vscode
        yeshan333.jenkins-pipeline-linter-connector-fork
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
        "editor.rulers" = [ 120 ];

        # Git
        "git.enableCommitSigning" = true;
        "gitlens.telemetry.enabled" = false;

        # Ansible
        "[ansible]"."editor.defaultFormatter" = "redhat.vscode-yaml";
        "[ansible]"."editor.detectIndentation" = true;
        "[ansible]"."editor.insertSpaces" = true;
        "[ansible]"."editor.tabSize" = 2;
        "redhat.telemetry.enabled" = false;

        # Docker
        "[dockerfile]"."editor.defaultFormatter" = "ms-azuretools.vscode-docker";

        # Jenkins
        "jenkins.pipeline.linter.connector.url" =
          "http://jenkins.${localDomain}/pipeline-model-converter/validate";
        "jenkins.pipeline.linter.connector.user" = "validator";
        "jenkins.pipeline.linter.connector.pass" = "validator";
        "jenkins.pipeline.linter.connector.crumbUrl" =
          "http://jenkins.${localDomain}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)";

        # Python
        "[python]"."editor.formatOnSave" = true;
        "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
        "[python]"."editor.codeActionsOnSave" = {
          "source.fixAll" = "explicit";
          "source.organizeImports" = "explicit";
        };

        # Web
        "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "svelte.enable-ts-plugin" = true;
        "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

        # YAML
        "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
        "[yaml]"."editor.formatOnSave" = false;
      };
    };
  };

  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.extended = true;

    initContent = ''
      export EDITOR="nvim"

      # Accept autosuggest with Ctrl+Space
      bindkey '^ ' autosuggest-accept

      # Function to manage WireGuard VPN connections
      vpn() {
          # Check if both action and connection name are provided
          if [[ $# -lt 2 ]]; then
              echo "Usage: vpn <action> <connection>"
              echo "Actions: start, stop, restart, status"
              echo "Example: vpn start home"
              return 1
          fi

        local action=$1
        local connection=$2
        local service="wg-quick-''${connection}"

        # Validate action
        case "$action" in
            start|stop|restart|status)
                ;;
            *)
                echo "Invalid action: $action"
                echo "Valid actions are: start, stop, restart, status"
                return 1
                ;;
        esac

        # Check if the service exists
        if ! sudo systemctl list-unit-files | grep -q "$service.service"; then
            echo "Error: Wireguard VPN '$service' not found"
            echo "Available Wireguard VPNs:"
            sudo systemctl list-unit-files | grep wg-quick | cut -d'@' -f2 | cut -d'.' -f1
            return 1
        fi

        # Execute the requested action
        case "$action" in
            status)
                sudo systemctl status "$service"
            ;;
            *)
                sudo systemctl "$action" "$service"
                # Show brief status after action
                sleep 1
                sudo systemctl is-active --quiet "$service" && \
                    echo "VPN '$connection' is now active" || \
                    echo "VPN '$connection' is inactive"
                ;;
        esac
      }
    '';

    shellAliases = {
      ag = "ansible-galaxy";
      ap = "ansible-playbook";
      avd = "ansible-vault decrypt";
      ave = "ansible-vault encrypt";
      aved = "ansible-vault edit";
      c = "codium";
      cdd = "cd ~/dev";
      j = "just";
      k = "kubectl";
      kn = "kubens"; # installed manually via "krew install ns"
      kx = "kubectx";
      ssh = "TERM=xterm-256color ssh";
      syu = "systemctl --user";
      tm = "tmux attach || tmux";
      v = "~/.config/vault/v.sh";
      vv = "~/.config/vault-vino/v.sh";
      vsf = "~/.config/vault-sf/v.sh";
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vscode"
      ];
      theme = "agnoster";
    };
  };

}
