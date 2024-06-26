let
  pkgs = import <nixpkgs> { };
  sbcl = pkgs.sbcl.withPackages (
    ps: with ps; [
      alexandria
      cl-ppcre
    ]
  );
  chickenSsqlSelect = builtins.derivation {
    name = "chicken-ssql-select";
    builder = "${sbcl}/bin/sbcl";
    args = [
      "--script"
      ./build.lisp
    ];
    system = builtins.currentSystem;

    SOURCE = ./select.scm;
    OUTPUT = "bin/chicken-ssql-select";

    PATH = "${pkgs.gcc}/bin:${pkgs.coreutils}/bin:${pkgs.findutils}/bin:${pkgs.patchelf}/bin";
    csc = "${pkgs.chicken}/bin/csc";

    buildInputs = with pkgs; [
      findutils
      patchelf
      chicken
      chickenPackages.chickenEggs.ssql
    ];
  };
in
{
  inherit chickenSsqlSelect;
}
