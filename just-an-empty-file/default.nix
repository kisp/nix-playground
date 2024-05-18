let
  pkgs = import <nixpkgs> { };
in
pkgs.runCommand "just-an-empty-file" { } ''
  touch $out
''
