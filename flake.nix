{
  inputs.nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    {
      packages.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        {
          dwm = pkgs.callPackage ./dwm.nix { };
          st = pkgs.callPackage ./st.nix { };
          dmenu = pkgs.callPackage ./dmenu.nix { };
        };
    };
}
