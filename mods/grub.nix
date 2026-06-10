{ lib, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = lib.mkDefault true;
      efiSupport = true;
      devices = [ "nodev" ];
      timeout = null;
      minegrub-theme = {
        enable = true;
        splash = "AlbertOS SO NB!";
        background = "background_options/1.20 - [Trails & Tales].png";
        boot-options-count = 4;
      };
    };
  };
}
