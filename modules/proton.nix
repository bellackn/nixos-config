{ pkgs, ... }:

{
  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "Proton Mail Bridge";
      After = [ "network.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --log-level info";
    };
  };
}
