{ config, ... }:

{

  hardware = {
    graphics.enable = true;
   
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      nvidia-settings = true;
      nvidia-persistenced = true;
      nvidia-x11 = true;
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
