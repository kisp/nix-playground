let
  pkgs = import <nixpkgs> { };
in
builtins.derivation {
  name = "clisp-iterate-count-to-10";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./build.sh ];
  system = builtins.currentSystem;

  COUNT = ./count.lisp;
  PATH = "${pkgs.clisp}/bin:${pkgs.coreutils}/bin:${pkgs.which}/bin";

  ITERATE = pkgs.fetchzip {
    name = "iterate";
    url = "https://gitlab.common-lisp.net/iterate/iterate/-/archive/1.5.4/iterate-1.5.4.tar.gz";
    sha256 = "sha256-1qkaZbghNAHj7/FsuJXNqREjJdsGXEDu4WHMclz7oWU=";
  };
}
