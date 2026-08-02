#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
exceptions=(
    # Cannot uupdate yet.
    -e dev-python/thinc
    # Inaccurate.
    -e games-emulation/cemu
    # Needs a patch to use zstd from pkg-config not CMake.
    -e games-emulation/mupen64plus-video-gliden64
    # Upgrade handled incorrectly.
    -e media-video/vapoursynth
    # Weird tag livecheck cannot handle.
    -e games-emulation/fuse-libretro
    -e games-emulation/pcsx-rearmed-libretro
)
livecheck "${exceptions[@]}" "$@"
