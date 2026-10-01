# Validation — 1 October 2026

## Passed locally

- Patch applicability checked against the exact pinned chiaki-ng source revision using `git apply --check`.
- Modified and added QML files parsed with Qt 6.9.3 tooling.
- New setup guide and status header instantiated with Qt Quick and a mock controller backend.
- Controller status bindings exercised with no controller, a generic controller, one PlayStation controller, two PlayStation controllers, and disconnection.
- Setup page navigation exercised using the same key events the existing controller bridge emits: Left/Right, Return, Escape, Up/Down. First/last page bounds and close actions checked.
- Custom screens exercised at 1280×800 and 960×600 without QML runtime warnings. A 1280×800 setup-guide preview was rendered and visually inspected. Its controller status is simulated.
- Manifest JSON, source paths, archive hash fields, desktop metadata XML, SVG icon and Linux script line endings checked.

## Not yet verified

- Linux dependency compilation and final Flatpak export.
- GitHub Actions workflow execution.
- Full application launch inside the Flatpak sandbox on SteamOS.
- PS4 discovery, registration, streaming, audio or network wake in this fork.
- Physical DualShock 4 buttons, sticks, touchpad, gyro, rumble, Bluetooth reconnect and Steam Gaming Mode.

The Windows development workspace has no installed Linux/WSL build environment and no connected PS4 or controller. There is no compiled installer in this delivery. Passing UI checks is not evidence that end-to-end Remote Play works.

## First-device acceptance check

Build and install on x86_64 SteamOS. Pair a DS4; check that SofaLink reports PlayStation input with Steam Input disabled. Register a PS4 and stream a game. Check all buttons, both sticks, L2/R2, touchpad, sound, and disconnection. Repeat over Bluetooth, then test reconnect and rest-mode wake. Record build or runtime errors before considering this a tested release.
