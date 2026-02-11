{ lib
, stdenv
, fetchurl
, pkg-config
, qt6
, libupnpp
, jsoncpp
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "upplay";
  version = "1.9.9";

  src = fetchurl {
    url = "https://www.lesbonscomptes.com/upplay/downloads/upplay-${finalAttrs.version}.tar.gz";
    sha256 = "sha256-PJHRpCL4+HXSbmyiia0jaKMb5Fr60CWjm9WSsbGh1o4=";
  };

  nativeBuildInputs = [
    pkg-config
    qt6.wrapQtAppsHook
    qt6.qmake
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtwebchannel
    qt6.qtwebengine
    libupnpp
    jsoncpp
  ];

  postPatch = ''
    # Fix hardcoded /bin/qmake6 in amber-mpris sub-project Makefile
    find . -name Makefile -exec sed -i 's|/bin/qmake6|qmake|g' {} +

    # Fix hardcoded /usr/include/jsoncpp include path
    find . -name '*.pro' -exec sed -i "s|-I/usr/include/jsoncpp||g" {} +
  '';

  qmakeFlags = [
    "PREFIX=${placeholder "out"}"
  ];

  meta = with lib; {
    description = "Qt-based UPnP audio control point";
    homepage = "https://www.lesbonscomptes.com/upplay/";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    mainProgram = "upplay";
  };
})
