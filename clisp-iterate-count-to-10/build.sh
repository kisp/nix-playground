#!/bin/bash

set -e

mkdir -p $out/bin

clisp -q -c $ITERATE/package.lisp -o out.fas
cat out.fas >>iterate.fas

clisp -q -i iterate.fas -c $ITERATE/iterate.lisp -o out.fas
cat out.fas >>iterate.fas

clisp -q -i iterate.fas -c $COUNT -o out.fas
cat out.fas >>count.fas

echo "#!$(which clisp)" >$out/bin/clisp-iterate-count-to-10
cat count.fas >>$out/bin/clisp-iterate-count-to-10
chmod +x $out/bin/clisp-iterate-count-to-10
