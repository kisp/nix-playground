{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) callPackage fetchFromGitHub;
  custom-lib = callPackage ./custom-lib.nix { };
  document-templates-src = fetchFromGitHub {
    owner = "kisp";
    repo = "document-templates";
    rev = "0.0.19";
    hash = "sha256-rrBs7iT54OXZ0nUxL7iZtfXd0fdD5wyA4C8FjtGDarA=";
  };
  document-templates = (callPackage document-templates-src { }).lib;
  sbcl' = pkgs.sbcl.withPackages (
    ps: with ps; [
      alexandria
      cl-ppcre
      custom-lib
      document-templates
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
