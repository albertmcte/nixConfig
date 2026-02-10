{ lib
, buildNpmPackage
, fetchFromGitHub
, makeWrapper
, nodejs
}:

buildNpmPackage rec {
  pname = "camillaeq";
  version = "0.1.0-unstable-2026-02-10";

  src = fetchFromGitHub {
    owner = "AlfredJKwack";
    repo = "camillaEQ";
    rev = "87573190d9ddee79d2dbea5b444b597b812fafb5";
    hash = "sha256-y3wCZvw1R7E8u66VIHhYl2PJ1D9ED5p9SlPodphRcrk=";
  };

  npmDepsHash = "sha256-m0X9R9WWWk/wjDND/kOXtzRIpiRto6RV9wlwAjIRE6c=";

  nativeBuildInputs = [ makeWrapper ];

  # The build script compiles both client and server, then copies client into server/dist
  npmBuildScript = "build";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/camillaeq

    # Copy the compiled server (includes client assets in dist/client/)
    cp -r server/dist $out/share/camillaeq/dist
    cp server/package.json $out/share/camillaeq/

    # ESM resolves modules by walking up from the importing file looking for
    # node_modules/. Place it as a sibling of dist/ so the resolver finds it.
    # Root node_modules has hoisted deps (dotenv, fastify, etc.)
    cp -r node_modules $out/share/camillaeq/node_modules
    # Remove workspace symlinks that would be broken
    rm -f $out/share/camillaeq/node_modules/@camillaeq/server
    rm -f $out/share/camillaeq/node_modules/@camillaeq/client
    rmdir --ignore-fail-on-non-empty $out/share/camillaeq/node_modules/@camillaeq 2>/dev/null || true

    # Merge server-specific node_modules on top (if any exist beyond workspace links)
    if [ -d server/node_modules ]; then
      cp -rn server/node_modules/* $out/share/camillaeq/node_modules/ 2>/dev/null || true
    fi

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/camillaeq \
      --add-flags "$out/share/camillaeq/dist/index.js"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Browser-based graphical equalizer for CamillaDSP";
    homepage = "https://github.com/AlfredJKwack/camillaEQ";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
