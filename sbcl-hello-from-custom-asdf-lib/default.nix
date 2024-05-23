{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) callPackage;
  custom-lib = callPackage ./custom-lib.nix { };
  sbcl' = pkgs.sbcl.withPackages (
    ps: with ps; [
      alexandria
      cl-ppcre
      custom-lib
    ]
  );
  app = pkgs.stdenv.mkDerivation {
    pname = "sbcl-hello-from-custom-asdf-lib-app";
    version = "0.0.1";
    src =
      let
        patterns = ''
          *
          !build.lisp
        '';
      in
      pkgs.nix-gitignore.gitignoreSourcePure patterns ./.;

    buildInputs = [ sbcl' ];

    dontStrip = true;

    buildPhase = ''
      ${sbcl'}/bin/sbcl --script build.lisp
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp app $out/bin
    '';
  };
in
{
  inherit app sbcl' custom-lib;
  sbcl = pkgs.sbcl;
}
