#!/usr/bin/env bash
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/.." || exit 1
exceptions=(
    -e dev-python/srsly
    -e dev-python/thinc
    -e dev-util/ida-free
)
livecheck "${exceptions[@]}" "$@"
