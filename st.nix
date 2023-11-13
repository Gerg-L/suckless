{
  stdenv,
  fontconfig,
  freetype,
  libX11,
  libXcursor,
  libXft,
  ncurses,
  pkg-config,
}:
stdenv.mkDerivation {
  pname = "st";
  version = "0.9";

  src = ./st;

  strictDeps = true;

  nativeBuildInputs = [
    freetype
    ncurses
    pkg-config
  ];

  buildInputs = [
    fontconfig
    libX11
    libXcursor
    libXft
  ];

  installFlags = [ "PREFIX=$(out)" ];

  env.TERMINFO = "${placeholder "out"}/share/terminfo";

  meta.mainProgram = "st";
}
