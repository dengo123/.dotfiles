{

 description = "The Ultimate Flake";

 inputs = {
   nixpkgs.url = "nixpkgs/nixos-24.11";
   nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
   home-manager.url = "github:nix-community/home-manager/release-24.11";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
 };

 outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
   let
     system = "x86_64-linux";
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "main"; # hostname
        profile = "main"; # select a profile defined from my profiles directory
        timezone = "Europe/Berlin"; # select timezone
        locale = "de_DE.UTF-8"; # select locale
        grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
        gpuType = "nvidia";
      };

      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "dengo123"; # username
        name = "Deniz"; # name/identifier
        email = "deniz@hotmail.com"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme = ""; # selcted theme from my themes directory (./themes/)
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
        browser = ""; # Default browser; must select one from ./user/app/browser/
        term = "alacritty"; # Default terminal command;
        font = "Intel One Mono"; # Selected font
        fontPkg = pkgs.intel-one-mono; # Font package
        editor = "neovim"; # Default editor;
     };

     # ----- PACKAGES ----- #
     lib = nixpkgs.lib;
     pkgs = import inputs.nixpkgs {
       system = systemSettings.system;
       config = {
         allowUnfree = true;
         allowUnfreePredicate = (_: true);
       };
     };
     pkgs-unstable = import inputs.nixpkgs-unstable {
       system = systemSettings.system;
       config = {
         allowUnfree = true;
	 allowUnfreePredicate = (_: true);
       };
     };

   in {
   nixosConfigurations = {
     system = lib.nixosSystem {
       system = systemSettings.system;
       modules = [ 
         (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
       ];
       specialArgs = {
         inherit systemSettings;
         inherit userSettings;
         inherit pkgs;
	 inherit pkgs-unstable;
	 inherit inputs;
       };
     };
   };
   homeConfigurations = {
     user = home-manager.lib.homeManagerConfiguration {
     inherit pkgs;
       modules = [ 
        (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") # load home.nix from selected PROFILE; 
       ];
       extraSpecialArgs = {
	 inherit systemSettings;
	 inherit userSettings;
	 inherit inputs;
	 inherit pkgs-unstable;
       };
     };
   };
 };

}
