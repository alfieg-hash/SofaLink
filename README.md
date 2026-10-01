# SofaLink 0.1.0 — SteamOS / DualShock 4 edition

A custom PS4 Remote Play client built as a source modification of **chiaki-ng**, with a new home screen, live controller status, and an integrated DualShock 4 setup guide. Target: **x86_64 SteamOS**, including Steam Deck.

## Current status

**This delivery contains source modifications and Flatpak build files. It does not contain a compiled `.flatpak`.** The available development computer runs Windows without a Linux build environment. Interface checks passed with simulated controller data; a full Linux build, real controller input, and PS4 streaming have not been tested.

## Build on SteamOS

1. Switch to Desktop Mode, download and extract the source ZIP into a folder you own.
2. Open that extracted `SofaLink` folder in Dolphin. Right-click inside the folder and choose **Open Terminal Here**.
3. Run:

   ```bash
   bash build-flatpak.sh
   ```

The script installs the Flatpak builder into your user account if needed and downloads the pinned Remote Play source and its build dependencies. It does not require disabling SteamOS read-only mode. Keep the device plugged in, allow at least 20 GB free space, and expect a substantial first build. The script stops if any build step fails.

After a successful build, the installer is:

```text
dist/SofaLink-0.1.0-x86_64.flatpak
```

Install it with:

```bash
bash install-flatpak.sh
```

Launch **SofaLink** from the application menu, or:

```bash
flatpak run io.local.SofaLink
```

The compiled bundle can be copied to another x86_64 SteamOS/Linux computer and installed with `flatpak install --user SofaLink-0.1.0-x86_64.flatpak`. An internet connection may be needed to install the KDE runtime. The source ZIP itself cannot be installed as a Flatpak.

## Optional: build using GitHub

Create a repository containing the contents of this folder at its root, including `.github`. Under **Actions**, run **Build SofaLink Flatpak**. If the Linux build succeeds, download the `SofaLink-0.1.0-x86_64` artifact and extract the `.flatpak` from it. The workflow has been supplied but has not been run. No repository has been created or published for you.

## Pair the controller and PS4

1. Connect the DualShock 4 to your SteamOS computer with a USB data cable, or hold **SHARE + PS** until the light flashes and pair **Wireless Controller** through SteamOS Bluetooth settings.
2. On PS4, enable **Settings → Remote Play Connection Settings → Enable Remote Play**. Activate the console as your primary PS4. Keep both devices on the same network for initial setup.
3. Open SofaLink, select the discovered console, and register it. Manual registration needs your **PSN account ID**, rather than your online name, and the temporary PIN shown in **Remote Play Connection Settings → Add Device**. Account-ID options are available in the registration dialog. Select the PS4 firmware option appropriate to your console.
4. Start with **720p / 60 fps**. PS4 video uses H.264 through the existing engine. Use a wired network connection to the PS4 where practical.
5. Select the registered PS4 to connect. **L3** opens the built-in setup guide; **Options** opens settings; **R3** adds a console by IP address.

To use Gaming Mode, add SofaLink as a non-Steam game in Desktop Mode. For direct DualShock 4 touchpad and motion input, select the connected DualShock 4 in the game's controller properties and **disable Steam Input for SofaLink**. The home screen should report a PlayStation controller. A generic controller message can mean Steam Input is presenting a virtual gamepad. Only a real-device test can confirm every feature works on your system.

To wake the PS4 from rest mode, enable its internet connection and network wake options in Power Save Settings. Registration must already be complete. Configure the stream-menu shortcut in SofaLink settings so you can disconnect from the controller.

## What is custom

- SofaLink app identity, desktop launcher and icon, with separate application settings.
- Compact home toolbar, controller status, and console discovery help.
- Four-page PS4 / DualShock 4 guide usable with the D-pad and Cross/Circle.
- PS4 selected by default in the video settings page.
- Direct DualShock 4 SDL HID support enabled in the launcher; inherited controller mapping, touchpad, motion and rumble handling.
- Flatpak recipe with the original streaming engine and its dependencies, rather than requiring a separately installed Chiaki app.

Streaming, authentication, console registration, wake-up, video decoding, sound and controller transport come from **chiaki-ng**, not newly implemented protocol code. Optional upstream Steam-shortcut automation is disabled; add SofaLink to Steam manually. PS5 capabilities remain in the underlying engine, but this package targets your PS4 use case.

## Build layout and checks

`io.local.SofaLink.json` pins the engine source and includes its dependency build recipe. `patches/sofalink.patch` modifies that exact revision. `custom/` contains the new Qt Quick screens. `packaging/` contains the launcher and desktop files. Run `python3 scripts/check-project.py` for basic package checks. See `VALIDATION.md` for the checks actually performed and the remaining hardware tests.

The app has network, audio, GPU and controller-device access. Like its upstream Flatpak, it uses `--device=all` for controller input; it is not restricted to one controller. It does not request access to your entire home folder or Steam library. Registration data and settings are stored in its own Flatpak application directory, `~/.var/app/io.local.SofaLink/`.

## Credits and source

SofaLink is an independent personal fork, not an official Sony, Valve or chiaki-ng release. It is licensed under **AGPL-3.0-only**, with upstream license notices retained. See `COPYING`, `LICENSES/`, and `UPSTREAM.md`.

- Engine: https://github.com/streetpea/chiaki-ng
- Original Flatpak recipe: https://github.com/flathub/io.github.streetpea.Chiaki4deck
- Controller reference: https://streetpea.github.io/chiaki-ng/setup/controlling/
- Registration reference: https://streetpea.github.io/chiaki-ng/setup/configuration/
- Flatpak bundle reference: https://docs.flatpak.org/en/latest/single-file-bundles.html
