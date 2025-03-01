{ config, pkgs, lib, ... }:

{

 wayland.windowManager.hyprland = {
   enable = true;
   xwayland.enable = true;
   settings = {
     general = {
       gaps_in = 5;
       gaps_out = 20;
       border_size = 2;
     };
   };
 };

 home = {
   sessionVariables = {
     # If cursor becomes invisible
     WLR_NO_HARDWARE_CURSORS = "1";
     # Hint electron apps (like discord) tu use wayland
     NIXOS_OZONE_WL = "1";
   };
   packages = with pkgs; [
     waybar
     mako
     libnotify
     swww
     rofi-wayland
   ];
  };

}
