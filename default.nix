# default.nix
let
  pkgs = import <nixpkgs> { config = {}; overlays = []; };
in
{
  amd-uprof = pkgs.callPackage ./amd-uprof.nix { };
}