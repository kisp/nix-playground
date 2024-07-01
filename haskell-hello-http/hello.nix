{ mkDerivation, base, http-conduit, lib }:
mkDerivation {
  pname = "hello";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base http-conduit ];
  license = "unknown";
  mainProgram = "hello-world";
}
