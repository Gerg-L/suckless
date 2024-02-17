{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      withSystem =
        f:
        lib.fold lib.recursiveUpdate { } (
          map f [
            "x86_64-linux"
            "x86_64-darwin"
            "aarch64-linux"
            "aarch64-darwin"
          ]
        );
      mkPackages = pkgs: {
        dwm = pkgs.callPackage ./dwm.nix { };
        st = pkgs.callPackage ./st.nix { };
        dmenu = pkgs.callPackage ./dmenu.nix { };
      };
    in
    withSystem (system: {
      overlays.default = final: _: mkPackages final;

      packages.${system} = mkPackages nixpkgs.legacyPackages.${system};
    });
}
