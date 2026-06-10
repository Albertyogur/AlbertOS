{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myHomeModules.collaboraDesktop;
in
{
  options.myHomeModules.collaboraDesktop = {
    enable = lib.mkEnableOption "Enable Collabora Desktop (modern Collabora Office)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.collabora-desktop
    ];

  };
}
