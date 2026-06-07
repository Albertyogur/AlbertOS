{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./nyancatmodule.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # ==================== Bootloader ====================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  boot.loader.systemd-boot.configurationLimit = 3;

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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.nyancat.enable = false;

  # ==================== 中英文字体（已修正） ====================
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji      # ← 已修正
    sarasa-gothic
    jetbrains-mono
    fira-code
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif CJK SC" ];
    sansSerif = [ "Noto Sans CJK SC" "Sarasa Gothic SC" ];
    monospace = [ "JetBrainsMono" "Sarasa Mono SC" ];
    emoji = [ "Noto Color Emoji" ];
  };

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
    mullvad-vpn
  ];

  # ==================== 基础设置 ====================
  networking.hostName = "zenbook-air";
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "zh_CN.UTF-8";

  nixpkgs.config.allowUnfree = true;

  users.users.albert = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
  };

  system.stateVersion = "25.05";
}
