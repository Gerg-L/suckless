{
  description = "My personal suckless configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    withSystem = f:
      lib.foldAttrs lib.mergeAttrs {}
      (map (s: lib.mapAttrs (_: v: {${s} = v;}) (f s))
        ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"]);
  in
    {
      overlay = final: _: self.packages.${final.system};
    }
    // withSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;

      packages = {
        dwm = pkgs.callPackage ./dwm.nix {};
        st = pkgs.callPackage ./st.nix {};
        dmenu = pkgs.callPackage ./dmenu.nix {};
      };
    });
}
