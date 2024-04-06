{
  inputs.nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-unstable";
  };

  outputs =
    { nixpkgs, self }:
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
      overlays = {
        default = self.overlays.override;
        override = final: _: mkPackages final;
        insert = final: _: self.packages.${final.stdenv.hostPlatform.system};
      };

      packages.${system} = mkPackages nixpkgs.legacyPackages.${system};
    });
}
