{
  description = "my dwm config";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:

    let
      system = "x86_64-linux";
      overlay = final: prev: {
        dwm = prev.dwm.overrideAttrs (old: {
          version = "6.5";
          src = builtins.path {
            path = ./.;
            name = "dwm";
          };
        });
      };

      dwm = (import nixpkgs {
        inherit system;
        overlays = [ overlay ];
      }).dwm;
    in {
      overlays.default = overlay;
      packages.${system}.default = dwm;
    };
}
