let
  pkgs = import <nixpkgs> { };
in
pkgs.runCommand "slides" { } ''
  ${pkgs.pandoc}/bin/pandoc -t slidy -s ${./slides.md} -o $out
''
