{ stdenv, meson, ninja, pkg-config, xorg }:

stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = ./dwmblocks;

  strictDeps = true;
  buildInputs = builtins.attrValues { inherit (xorg) libxcb xcbutil; }
    ++ [ meson ninja pkg-config ];

  installFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
