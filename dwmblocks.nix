{
  stdenv,
  xorg,
  libX11,
  pkg-config,
  makeWrapper,
  lib,
  coreutils,
}:

let
  inherit (lib) makeBinPath;
in
stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = ./dwmblocks;

  strictDeps = true;

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];
  buildInputs =
    [ libX11 ]
    ++ builtins.attrValues {
      inherit (xorg)
        libxcb
        xcbutil
        xlsatoms
        xcbproto
        ;
    };

  patchPhase = ''
    ls
      substituteInPlace config.h --replace-fail "SCRIPTS_DIR" "$out/scripts"
      cat ./config.h
  '';

  postInstall = ''
    patchShebangs --host $out/scripts
    wrapProgram $out/scripts/date --prefix PATH ":" \
      "${makeBinPath [ coreutils ]}"
    wrapProgram $out/scripts/bat --prefix PATH ":" \
      "${makeBinPath [ coreutils ]}"
  '';

  makeFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
