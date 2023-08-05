{
  stdenv,
  libX11,
  libXinerama,
  libXft,
}:
stdenv.mkDerivation {
  pname = "dwm";
  version = "6.4";

  src = ./dwm;

  buildInputs = [libX11 libXinerama libXft];

  prePatch = ''
    sed -i "s@/usr/local@$out@" config.mk
  '';

  makeFlags = ["CC=${stdenv.cc.targetPrefix}cc"];

  meta.mainProgram = "dwm";
}
