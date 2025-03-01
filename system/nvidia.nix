{ config, ... }:

{

  hardware = {
    graphics.enable = true;
   
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
