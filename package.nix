{
  lib,
  fetchFromGitHub,
  libcosmicAppHook,
  pkg-config,
  rustPlatform,
  wayland,
  wayland-protocols,
  libxkbcommon,
  nix-update-script,
}:
let
  appName = "cosmic-next-meeting";
  appId = "com.dangrover.next-meeting-app";
in
rustPlatform.buildRustPackage {
  pname = appName;
  version = "0-unstable-2026-01-19";

  src = fetchFromGitHub {
    owner = "dangrover";
    repo = "next-meeting-for-cosmic";
    rev = "2188fcb49028399f49cef559106aadd384881186";
    hash = "sha256-sE9Z5oc71VfDm5RMQeEoX7AtEKFuXElIzRmZUzC3vdg=";
  };

  cargoHash = "sha256-3tgxN8HoXaCBXK61+F+yNiz+uwQiUj2iLC52bNeCNuc=";

  nativeBuildInputs = [
    libcosmicAppHook
    pkg-config
  ];

  buildInputs = [
    wayland
    wayland-protocols
    libxkbcommon
  ];

  postInstall = ''
    install -Dm0644 resources/app.desktop \
      "$out/share/applications/${appId}.desktop"
    install -Dm0644 resources/app.metainfo.xml \
      "$out/share/metainfo/${appId}.metainfo.xml"
    install -Dm0644 resources/icon.svg \
      "$out/share/icons/hicolor/scalable/apps/${appId}.svg"
    install -Dm0644 resources/icon-symbolic.svg \
      "$out/share/icons/hicolor/symbolic/apps/${appId}-symbolic.svg"
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "Applet for Cosmic DE that shows your next meeting with button to join";
    homepage = "https://github.com/dangrover/next-meeting-for-cosmic";
    license = lib.licenses.gpl3Only;
    mainProgram = appName;
    maintainers = [ lib.maintainers.mugiwarix ];
    platforms = lib.platforms.linux;
  };
}
