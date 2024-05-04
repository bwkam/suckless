{ stdenv, xorg, libX11, pkg-config }:

stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = ./dwmblocks;

  strictDeps = true;

  buildInputs = [ libX11 pkg-config ] ++ builtins.attrValues {
    inherit (xorg)
      libxcb xcbutil xlsatoms xcbutilwm xcbutilrenderutil xcbutilkeysyms
      xcbproto;
  };

  makeFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
