{ stdenv, xorg }:

stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = ./dwmblocks;

  strictDeps = true;

  buildInputs = builtins.attrValues { inherit (xorg) libxcb xcbutil; };

  installFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
