{
  description = "my suckless flake";

  inputs = {nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";};

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    withSystem = f:
      lib.fold lib.recursiveUpdate {} (map f [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ]);

    mkPackages = pkgs: {
      dwm = pkgs.callPackage ./dwm.nix {};
      dwmblocks = pkgs.callPackage ./dwmblocks.nix {};
    };

    mkShells = pkgs: {
      default = pkgs.mkShell {
        nativeBuildInputs = [pkgs.pkg-config];
        buildInputs = with pkgs; [gcc gnumake bear xorg.libX11 xorg.libXinerama xorg.libXft];
      };
    };
  in
    withSystem (system: {
      packages.${system} = mkPackages nixpkgs.legacyPackages.${system};
      devShells.${system} = mkShells nixpkgs.legacyPackages.${system};
    });
}
