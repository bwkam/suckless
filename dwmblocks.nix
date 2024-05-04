{ stdenv, xorg, libX11, pkg-config }:

stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = ./dwmblocks;

  strictDeps = true;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libX11 ]
    ++ builtins.attrValues { inherit (xorg) libxcb xcbutil xlsatoms xcbproto; };

  makeFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
