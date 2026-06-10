{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nyancatmodule.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.enableAllFirmware = true;

  # ==================== Zenbook 显卡修复 ====================
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "xe.force_probe=*" ];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  # ==================== GNOME 桌面 ====================
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # ==================== 中文输入法 ====================
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ rime ];
  };

  # ==================== Firefox 高 DPI 修复 + 默认浏览器 ====================
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1.75";
  };

  programs.firefox.enable = true;

  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  programs.nyancat.enable = false;

  # ==================== 常用软件 ====================
  environment.systemPackages = with pkgs; [
    firefox
    vscode
    git
    clash-verge-rev
    yazi
    nh
    gh
    zoxide
    lazygit
    gnumake
    inkscape
    neovide
    imv
    vlc
  ];

  # ==================== 基础设置 ====================
  networking.hostName = "zenbook-air";
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "zh_CN.UTF-8";

  nixpkgs.config.allowUnfree = true;

  users.users.albert = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
  };

  system.stateVersion = "26.05";
}
