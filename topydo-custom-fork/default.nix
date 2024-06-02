{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;
topydo.overrideAttrs (oldAttrs: {
  src = fetchFromGitHub {
    owner = "kisp";
    repo = "topydo";
    rev = "f3dc108d58bee8f4db577f96b311a01574b1681e";
    hash = "sha256-lmtOR0sM4QFmBM0YL0w0afbBoWUF4e6fZOgygxsre3g=";
  };
  patches = [ ];
})
