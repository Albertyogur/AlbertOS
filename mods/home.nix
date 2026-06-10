{
  ...
}:

{
  imports = [
    ./home/collabora-desktop.nix
  ];

  home.username = "albert";
  home.homeDirectory = "/home/albert";

  myHomeModules.collaboraDesktop.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "albert";
        email = "albertyogur@gmail.com";
      };
    };
  };

  home.stateVersion = "26.05";
}
