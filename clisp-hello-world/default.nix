let
  pkgs = import <nixpkgs> { };
in
pkgs.runCommand "clisp-hello-world" { } ''
  mkdir -p $out/bin

  echo "#!${pkgs.clisp}/bin/clisp" >$out/bin/clisp-hello-world

  ${pkgs.clisp}/bin/clisp -q -c ${./hello.lisp} -o hello.fas
  cat hello.fas >>$out/bin/clisp-hello-world

  chmod +x $out/bin/clisp-hello-world
''
