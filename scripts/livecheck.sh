#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
exceptions=(
    # Need to keep older version for yt-dlp
    #-e dev-python/curl-cffi
    # Needs handler
    -e dev-util/ida-free
    # Keeps downgrading for some reason
    #-e dev-util/vscode-vsce
    # Keep stable version
    -e games-arcade/outfox
    # Needs handler
    #-e net-print/epson-printer-utility
    # Need to stay behind for kokoro-fastapi and tabbyAPI.
    #-e dev-libs/marisa
    #-e dev-python/catalogue
    #-e dev-python/curated-tokenizers
    #-e dev-python/curated-transformers
    #-e dev-python/fugashi
    #-e dev-python/openai
    #-e dev-python/preshed
    #-e dev-python/rfc3986
    #-e dev-python/smart-open
    #-e dev-python/spacy-curated-transformers
    #-e dev-python/thinc
    # Not yet.
    -e app-admin/padd
    -e app-admin/padd
    -e app-admin/padd
    -e app-admin/padd
    -e net-dns/pihole-ftl
    -e net-dns/pihole
    -e www-apps/pihole-admin-lte
    # Inaccurate.
    -e app-emulation/basiliskii
    -e app-emulation/sheepshaver
    -e dev-qt/qtwebkit
    -e games-emulation/cemu
    -e games-arcade/stepmania
    -e games-emulation/mupen64plus-video-gliden64
    # Weird tag livecheck cannot handle.
    -e games-emulation/fuse-libretro
    # Yarn packages broken?
    -e app-misc/zwave-js-server
    -e dev-util/yo
)
livecheck "${exceptions[@]}" "$@"
