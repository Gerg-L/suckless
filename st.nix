{
  stdenv,
  pkg-config,
  fontconfig,
  freetype,
  libX11,
  libXft,
  ncurses,
  nixosTests,
  xorg,
}:
stdenv.mkDerivation {
  pname = "st";
  version = "0.9";

  src = ./st;

  strictDeps = true;

  makeFlags = [ "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config" ];

  nativeBuildInputs = [
    pkg-config
    ncurses
    fontconfig
    freetype
  ];
  buildInputs = [
    libX11
    libXft
    #required by patches
    xorg.libXcursor
  ];

  preInstall = ''
    export TERMINFO=$out/share/terminfo
  '';

  installFlags = [ "PREFIX=$(out)" ];

  passthru.tests.test = nixosTests.terminal-emulators.st;

  meta.mainProgram = "st";
}
