#!/bin/bash

set -e

mkdir -p $out/bin
csc $HELLO -o $out/bin/chicken-hello-world
