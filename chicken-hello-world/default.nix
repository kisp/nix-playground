let
  pkgs = import <nixpkgs> { };
in
builtins.derivation {
  name = "chicken-hello-world";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./build.sh ];
  system = builtins.currentSystem;

  HELLO = ./hello.scm;
  PATH = "${pkgs.chicken}/bin:${pkgs.gcc}/bin:${pkgs.coreutils}/bin:${pkgs.which}/bin";
}
