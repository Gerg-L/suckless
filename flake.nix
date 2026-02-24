{
  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
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
