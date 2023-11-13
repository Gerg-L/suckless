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

  strictDeps = true;

  buildInputs = [
    libX11
    libXinerama
    libXft
  ];

  installFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwm";
}
