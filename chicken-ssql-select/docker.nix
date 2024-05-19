{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (import ./default.nix) chickenSsqlSelect;
in
pkgs.buildEnv {
  name = "docker-env";
  paths = [
    pkgs.bashInteractive
    pkgs.coreutils
    # pkgs.ncdu
    # pkgs.busybox
    chickenSsqlSelect
  ];
}
