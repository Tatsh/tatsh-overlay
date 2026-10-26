#!/bin/sh
# The game is installed into, and run from, the working directory.
dir="${XDG_DATA_HOME:-${HOME}/.local/share}/UnleashedRecomp"
mkdir -p "${dir}" && cd "${dir}" || exit 1
exec /usr/libexec/unleashedrecomp/UnleashedRecomp "$@"
