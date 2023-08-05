{
  stdenv,
  libX11,
  libXinerama,
  libXft,
  zlib,
}:
stdenv.mkDerivation {
  pname = "dmenu";
  version = "5.2";

  src = ./dmenu;

  buildInputs = [libX11 libXinerama zlib libXft];

  postPatch = ''
    sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
    sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
  '';

  preConfigure = ''
    sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
  '';

  makeFlags = ["CC:=$(CC)"];

  meta.mainProgram = "dmenu_run";
}
