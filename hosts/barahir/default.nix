{ config, inputs, lib, pkgs, ... }:

let user = "n2o"; in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/shared
      ../../modules/nixos/networking.nix
      ../../modules/nixos/pam.nix
    ];

  boot = {
    initrd.luks.devices."luks-8b7351d2-9042-4529-8de4-dbd11728ab35".device = "/dev/disk/by-uuid/8b7351d2-9042-4529-8de4-dbd11728ab35";
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
  };

  nix = {
    settings = {
      allowed-users = [ "${user}" ];
      trusted-users = [ "${user}" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  # Set default Shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.n2o = {
    isNormalUser = true;
    description = "n2o";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Make /etc/hosts editable by root
  environment.etc.hosts.mode = "0644";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    age
    #gnome-extension-manager -> broken; see https://github.com/NixOS/nixpkgs/issues/371171
    gnome-keyring
    gnome-tweaks
    gnupg
    home-manager
    pinentry-gnome3
    sops
    zlib
  ];

  services.gnome.gnome-keyring.enable = true;

  # Enable fingerprint scanning
  services.fprintd = {
    enable = true;
  };

  # Install and configure Docker.
  virtualisation = {
    docker = {
      enable = true;
      extraOptions = "--insecure-registry 'http://git.wg.hof-trotzdem.de";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # SOPS setup
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/n2o/.config/sops/age/keys.txt";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
