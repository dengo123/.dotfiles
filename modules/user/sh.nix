{ config, pkgs, ... }:

{

 programs.zsh = {
   enable = true;
   autosuggestion.enable = true;
   syntaxHighlighting.enable = true;
   shellAliases = {
     ll = "ls -l";
     ".." = "cd ..";
   };
 };
}
