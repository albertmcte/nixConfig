{ lib
, stdenv
, fetchurl
, fetchFromGitHub
, python3
, makeWrapper
, unzip
}:

let
  # pycamilladsp is not in nixpkgs, build from source
  pycamilladsp = python3.pkgs.buildPythonPackage rec {
    pname = "pycamilladsp";
    version = "3.0.0";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "HEnquist";
      repo = "pycamilladsp";
      rev = "v${version}";
      hash = "sha256-WyyeYAEi2s46WSSuSl/s04+yW4rXWMPUx+oT1bVP3HM=";
    };

    build-system = [ python3.pkgs.setuptools ];

    dependencies = with python3.pkgs; [
      websocket-client
      pyyaml
    ];

    pythonImportsCheck = [ "camilladsp" ];
  };

  pycamilladsp-plot = python3.pkgs.buildPythonPackage rec {
    pname = "pycamilladsp-plot";
    version = "3.0.0";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "HEnquist";
      repo = "pycamilladsp-plot";
      rev = "v${version}";
      hash = "sha256-o6KQKYkWBJaj//ab8zdGF+G2q+KsybPgBR5oQoV3NBU=";
    };

    build-system = [ python3.pkgs.setuptools ];

    dependencies = [
      pycamilladsp
      python3.pkgs.numpy
      python3.pkgs.jsonschema
    ];

    pythonImportsCheck = [ "camilladsp_plot" ];
  };

  pythonEnv = python3.withPackages (ps: with ps; [
    aiohttp
    jsonschema
    pyyaml
    websocket-client
    numpy
    jinja2
    pycamilladsp
    pycamilladsp-plot
  ]);
in
stdenv.mkDerivation rec {
  pname = "camillagui";
  version = "3.0.3";

  src = fetchurl {
    url = "https://github.com/HEnquist/camillagui-backend/releases/download/v${version}/camillagui.zip";
    hash = "sha256-g0R66f3vwMu52v4Hc3rKJUAuxkMIhz+qfL51PLWuH+I=";
  };

  nativeBuildInputs = [ unzip makeWrapper ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/camillagui
    cp -r . $out/share/camillagui/

    mkdir -p $out/bin
    makeWrapper ${pythonEnv}/bin/python3 $out/bin/camillagui \
      --add-flags "$out/share/camillagui/main.py" \
      --prefix PYTHONPATH : "$out/share/camillagui"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Web-based GUI for CamillaDSP";
    homepage = "https://github.com/HEnquist/camillagui-backend";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
