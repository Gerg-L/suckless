{
  description = "My personal suckless configurations";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs?ref=nixos-unstable;
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    formatter = genSystems (system: pkgs.${system}.alejandra);
    packages = genSystems (system: rec {
      dwm = pkgs.${system}.callPackage ./dwm.nix {};
      st = pkgs.${system}.callPackage ./st.nix {};
      dmenu = pkgs.${system}.callPackage ./dmenu.nix {};
    });
    overlay = _: prev: {
      dwm = self.packages.${prev.system}.dwm;
      st = self.packages.${prev.system}.st;
      dmenu = self.packages.${prev.system}.dmenu;
    };
  };
}
