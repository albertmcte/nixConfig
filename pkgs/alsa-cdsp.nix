{ lib
, stdenv
, fetchFromGitHub
, alsa-lib
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "alsa-cdsp";
  version = "unstable-2024-01-15";

  src = fetchFromGitHub {
    owner = "scripple";
    repo = "alsa_cdsp";
    rev = "1a1b0a3e452f87372881ffaa9391a11d0ff6d541";
    sha256 = "sha256-QmQpLTcQ2VJPQeGN2G1y7LTEu1nHck5/LzVumuVroP0=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ alsa-lib ];

  makeFlags = [
    "LIBDIR=$(out)/lib"
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/alsa-lib
    cp libasound_module_pcm_cdsp.so $out/lib/alsa-lib/
    runHook postInstall
  '';

  meta = with lib; {
    description = "ALSA plugin for CamillaDSP with automatic sample rate switching";
    homepage = "https://github.com/scripple/alsa_cdsp";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
