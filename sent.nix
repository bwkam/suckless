{ lib, stdenv, fetchurl, farbfeld, libX11, libXft, makeWrapper}:

stdenv.mkDerivation rec {
  pname = "sent";
  version = "1";

  strictDeps = true;

  src = ./sent;

  buildInputs = [ libX11 libXft ];
  nativeBuildInputs = [ makeWrapper ];

  installFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "sent";

}
