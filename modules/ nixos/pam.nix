{ config, lib, pkgs, ... }:

{
  # Improve fingerprinting workflow (see https://github.com/NixOS/nixpkgs/issues/171136#issuecomment-1627779037)
  security.pam.services.login.fprintAuth = false;
  security.pam.services.gdm-fingerprint = lib.mkIf (config.services.fprintd.enable) {
    text = ''
      auth       required                    pam_shells.so
      auth       requisite                   pam_nologin.so
      auth       requisite                   pam_faillock.so      preauth
      auth       required                    ${pkgs.fprintd}/lib/security/pam_fprintd.so
      auth       optional                    pam_permit.so
      auth       required                    pam_env.so
      auth       [success=ok default=1]      ${pkgs.gdm}/lib/security/pam_gdm.so
      auth       optional                    ${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so

      account    include                     login

      password   required                    pam_deny.so

      session    include                     login
      session    optional                    ${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start
    '';
  };

  # This changes the /etc/pam.d/sudo file in a way that fingerprinting is not allowed for sudo privilege escalation
  security.pam.services.sudo = {
    text = ''
      # Account management.
      account required ${pkgs.linux-pam}/lib/security/pam_unix.so # unix

      # Authentication management.
      auth sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so likeauth try_first_pass # unix
      auth required ${pkgs.linux-pam}/lib/security/pam_deny.so # deny

      # Password management.
      password sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so nullok yescrypt # unix

      # Session management.
      session required ${pkgs.linux-pam}/lib/security/pam_env.so conffile=/etc/pam/environment readenv=0 # env
      session required ${pkgs.linux-pam}/lib/security/pam_unix.so # unix
      session required ${pkgs.linux-pam}/lib/security/pam_limits.so # limits - NOTE: We're omitting the "conf=" part here since the system-wide config will be used by default.
    '';
  };
}
