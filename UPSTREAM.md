# Source provenance

Engine: https://github.com/streetpea/chiaki-ng

Pinned commit: `c20ff6ac1b3f3a479c5004c74268025051cb109b`

Flatpak recipe: https://github.com/flathub/io.github.streetpea.Chiaki4deck

Recipe snapshot: `e6e915bd85305bd1bf7401c12590983bfa0aa8a6`

SofaLink includes modifications to the application identity, home view, theme, PS4 settings default, and resource list. The added screens, launcher and build scripts are licensed under AGPL-3.0-only. The metadata XML is CC0-1.0 as declared in that file. Original authorship and license texts remain intact. Third-party dependencies retain their own licenses.

The build fetches the engine's exact source revision, including Git submodules, then applies `patches/sofalink.patch` and adds `custom/*.qml`. All changes needed to recreate this fork are present in this package. Dependency versions and source hashes are in the manifest. Some upstream Git dependencies are pinned by release tag rather than commit hash.

If distributing a compiled build, provide its corresponding source, modifications and build instructions under the applicable licenses. This source package has not been published to an external service.
