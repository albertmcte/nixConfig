{ lib
, stdenv
, fetchurl
, pkg-config
, meson
, ninja
, curl
, libmicrohttpd
, expat
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "libnpupnp";
  version = "6.2.3";

  src = fetchurl {
    url = "https://www.lesbonscomptes.com/upmpdcli/downloads/libnpupnp-${finalAttrs.version}.tar.gz";
    sha256 = "sha256-Vj0qnkr+YDcXND3EZnwLicagFwCKxrUiYtoXoeT2u5Y=";
  };

  nativeBuildInputs = [ pkg-config meson ninja ];
  buildInputs = [ curl libmicrohttpd expat ];

  meta = with lib; {
    description = "UPnP library based on libupnp, but extensively rewritten";
    homepage = "https://www.lesbonscomptes.com/upmpdcli/";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
})
