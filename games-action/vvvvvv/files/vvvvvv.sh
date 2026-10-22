#!/bin/sh
data=/usr/share/vvvvvv/data.zip
[ -f "${data}" ] || data="${XDG_DATA_HOME:-${HOME}/.local/share}/VVVVVV/data.zip"
exec /usr/libexec/vvvvvv/VVVVVV -assets "${data}" \
	-langdir /usr/share/vvvvvv/lang -fontsdir /usr/share/vvvvvv/fonts "$@"
