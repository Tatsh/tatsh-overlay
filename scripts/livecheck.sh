#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
exceptions=(
    # Needs handler
    -e dev-util/ida-free
    # Keep stable version
    -e games-arcade/outfox
    # Not yet.
    -e app-admin/padd
    -e games-emulation/gopher64
    -e net-dns/pihole
    -e net-dns/pihole-ftl
    -e www-apps/pihole-admin-lte
    # Inaccurate.
    -e app-emulation/basiliskii
    -e app-emulation/sheepshaver
    -e dev-python/thinc
    -e dev-qt/qtwebkit
    -e games-arcade/stepmania
    -e games-emulation/cemu
    -e games-emulation/mupen64plus-video-gliden64
    -e games-emulation/rpcs3
    -e media-video/vapoursynth
    # Weird tag livecheck cannot handle.
    -e games-emulation/fuse-libretro
    # Yarn packages broken?
    -e app-misc/zwave-js-server
    -e dev-util/yo
)
livecheck "${exceptions[@]}" "$@"
