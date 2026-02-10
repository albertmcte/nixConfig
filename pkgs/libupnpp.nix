{ lib
, stdenv
, fetchurl
, pkg-config
, meson
, ninja
, libnpupnp
, curl
, expat
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "libupnpp";
  version = "1.0.3";

  src = fetchurl {
    url = "https://www.lesbonscomptes.com/upmpdcli/downloads/libupnpp-${finalAttrs.version}.tar.gz";
    sha256 = "sha256-07IBYZqEg3J53Ebut8yqp5YNQ3LbEbQ88rFDtdm9Mi4=";
  };

  nativeBuildInputs = [ pkg-config meson ninja ];
  buildInputs = [ libnpupnp curl expat ];

  meta = with lib; {
    description = "C++ wrapper library for libnpupnp";
    homepage = "https://www.lesbonscomptes.com/upmpdcli/";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
  };
})
