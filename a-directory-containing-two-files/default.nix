let
  pkgs = import <nixpkgs> { };
in
pkgs.runCommand "directory" { } ''
  mkdir $out

  echo 'Hello, world!' >$out/hello.txt

  echo 'Bye...' >$out/bye.txt
''
