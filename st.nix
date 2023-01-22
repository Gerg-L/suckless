{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  fontconfig,
  freetype,
  libX11,
  libXft,
  ncurses,
  writeText,
  nixosTests,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "st";
  version = "0.9";

  src = ./st;

  strictDeps = true;

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
  ];

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
    harfbuzz
  ];

  preInstall = ''
    export TERMINFO=$out/share/terminfo
  '';

  installFlags = ["PREFIX=$(out)"];

  passthru.tests.test = nixosTests.terminal-emulators.st;

  meta = with lib; {
    homepage = "https://st.suckless.org/";
    description = "Simple Terminal for X from Suckless.org Community";
    license = licenses.mit;
    maintainers = with maintainers; [andsild];
    platforms = platforms.unix;
  };
})
