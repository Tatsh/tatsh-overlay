#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
exceptions=(
    # Weird tag livecheck cannot handle.
    -e games-emulation/fuse-libretro
    -e games-emulation/pcsx-rearmed-libretro
)
livecheck "${exceptions[@]}" "$@"
