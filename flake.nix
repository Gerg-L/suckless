{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    withSystem = f:
      lib.fold lib.recursiveUpdate {}
      (map f ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"]);
  in
    withSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      overlays.default = final: _: self.packages.${final.system};
      overlay = self.overlays.default;

      formatter.${system} = pkgs.alejandra;

      packages.${system} = {
        dwm = pkgs.callPackage ./dwm.nix {};
        st = pkgs.callPackage ./st.nix {};
        dmenu = pkgs.callPackage ./dmenu.nix {};
      };
      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = lib.attrValues self.packages.${system};
      };
    });
}
