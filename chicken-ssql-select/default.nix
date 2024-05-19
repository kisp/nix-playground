let
  pkgs = import <nixpkgs> { };
  sbcl = pkgs.sbcl.withPackages (
    ps: with ps; [
      alexandria
      cl-ppcre
    ]
  );
in
builtins.derivation {
  name = "chicken-ssql-select";
  builder = "${sbcl}/bin/sbcl";
  args = [
    "--script"
    ./build.lisp
  ];
  system = builtins.currentSystem;

  SOURCE = ./select.scm;
  OUTPUT = "bin/chicken-ssql-select";

  PATH = "${pkgs.gcc}/bin:${pkgs.coreutils}/bin";
  csc = "${pkgs.chicken}/bin/csc";

  buildInputs = with pkgs; [
    chicken
    chickenPackages.chickenEggs.ssql
  ];
}
