let
  pkgs = import <nixpkgs> { };
in
pkgs.runCommand "a-file-containing-hello-world" { } ''
  echo 'Hello, world!' >$out
''
