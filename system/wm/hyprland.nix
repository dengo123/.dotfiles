{ inputs, pkgs, lib, ... }:

{
# Enabling hyprlnd on NixOS
 programs.hyprland = {
   enable = true;
   xwayland.enable = true;
   withUWSM = true;
 };

 security.pam.services.hyprlock = {};

 # environment.sessionVariables = {
   # If your cursor becomes invisible
   # WLR_NO_HARDWARE_CURSORS = "1";
   # Hint electron apps to use wayland
   # NIXOS_OZONE_WL = "1";
 # };

}
