{ config, lib, pkgs, ... }:

{
  options.programs.nyancat = {
    enable = lib.mkEnableOption "nyancat";
  };

  config = lib.mkIf config.programs.nyancat.enable {
    environment.systemPackages = with pkgs; [ nyancat ];
  };
}
