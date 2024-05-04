{
  description = "my dwm config";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      withSystem = f:
        lib.fold lib.recursiveUpdate { } (map f [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ]);

      mkPackages = pkgs: {
        dwm = pkgs.callPackage ./dwm.nix { };
        dwmblocks = pkgs.callPackage ./dwmblocks.nix { };
      };
    in withSystem (system: {
      packages.${system} = mkPackages nixpkgs.legacyPackages.${system};
    });
}
