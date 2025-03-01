{ config, ... }:

{

 programs.hyprland = {
   enable = true;
   nvidiaPatches = true;
   xwayland.enable = true;
 };

 environment.sessionVariables = {
   # If cursor becomes invisible
   WLR_NO_HARDWARE_CURSORS = "1";
   # Hint electron apps (like discord) tu use wayland
   NIXOS_OZONE_WL = "1";
 };

 environment.systemPackages = with pkgs; [
   waybar
   mako
   libnotify
   swww
   rofi-wayland
 ];

}
