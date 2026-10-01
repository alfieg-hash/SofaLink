#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
bundle=dist/SofaLink-0.1.0-x86_64.flatpak
[[ -f "$bundle" ]] || { printf '%s\n' 'No compiled Flatpak found. Run: bash build-flatpak.sh' >&2; exit 1; }
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user "$bundle"
printf '%s\n' 'Launch SofaLink from the application menu, or run: flatpak run io.local.SofaLink'
