#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-only
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if [[ $(uname -s) != Linux || $(uname -m) != x86_64 ]]; then
  printf '%s\n' 'This build targets x86_64 Linux, including Steam Deck / SteamOS.' >&2
  exit 1
fi
command -v flatpak >/dev/null || { printf '%s\n' 'Install Flatpak first, then run this script again.' >&2; exit 1; }
printf '%s\n' 'Building SofaLink. The first build downloads several GB of development tools.'
printf '%s\n' 'Allow at least 20 GB of free space. Keep your device plugged in.'
# Git sources are downloaded under this directory, not necessarily /tmp.
# Probe it before downloading large runtimes, and preserve the OS error message.
mkdir -p .flatpak-builder/git
if ! sofalink_probe=$(mktemp -d "$PWD/.flatpak-builder/git/sofalink-check.XXXXXX"); then
  printf '%s\n' 'Cannot create a directory in the source cache. Check space, free inodes and folder permissions below.' >&2
  df -h .
  df -i .
  ls -ld . .flatpak-builder .flatpak-builder/git
  exit 1
fi
rmdir -- "$sofalink_probe"
printf '%s\n' 'Available build storage:'
df -h .
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# SteamOS can use the sandboxed builder without unlocking the operating system.
if command -v flatpak-builder >/dev/null; then
  builder=(flatpak-builder)
else
  flatpak install --user -y flathub org.flatpak.Builder
  builder=(flatpak run org.flatpak.Builder)
fi

mkdir -p build dist
"${builder[@]}" --user --arch=x86_64 --jobs=2 --force-clean \
  --install-deps-from=flathub --repo=build/repo \
  build/app io.local.SofaLink.json
flatpak build-bundle --arch=x86_64 \
  --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo \
  build/repo dist/SofaLink-0.1.0-x86_64.flatpak io.local.SofaLink stable
sha256sum dist/SofaLink-0.1.0-x86_64.flatpak > dist/SHA256SUMS
printf '\n%s\n' 'Build finished: dist/SofaLink-0.1.0-x86_64.flatpak'
printf '%s\n' 'To install it: bash install-flatpak.sh'
