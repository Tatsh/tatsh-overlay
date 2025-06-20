# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: libretro.eclass
# @MAINTAINER:
# leycec@gmail.com
# @AUTHOR:
# Original author: Cecil Curry
# @BLURB: An eclass to streamline the construction of Libretro-related ebuilds
# @DESCRIPTION:
# The libretro eclass is designed to streamline the construction of
# ebuilds for Libretro-related ebuilds, including those for both low-level
# Libretro cores and assets as well for Libretro and Retroarch themselves.

# @ECLASS-VARIABLE: LIBRETRO_DATA_DIR
# @DESCRIPTION:
# Absolute path of the directory containing Libretro data files.
LIBRETRO_DATA_DIR="${EROOT}usr/share/libretro"

# @ECLASS-VARIABLE: RETROARCH_DATA_DIR
# @DESCRIPTION:
# Absolute path of the directory containing Retroarch data files.
RETROARCH_DATA_DIR="${EROOT}usr/share/retroarch"

# @ECLASS-VARIABLE: LIBRETRO_COMMIT_SHA
# @DESCRIPTION:
# Commit SHA used for SRC_URI will die if not set in <9999 ebuilds.
# Needs to be set before inherit.
: ${LIBRETRO_COMMIT_SHA:=die}}

# @ECLASS-VARIABLE: LIBRETRO_REPO_NAME
# @DESCRIPTION:
# Contains the real repo name of the core formatted as "repouser/reponame".
# Needs to be set before inherit. Otherwise defaults to "libretro/${PN}"
: ${LIBRETRO_REPO_NAME:="libretro/${PN}"}

# Offload EGIT_REPO_URI and SRC_URI to eclass only in supported ebuilds
if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${LIBRETRO_REPO_NAME}.git"
fi

if [[ ! ${PV} = 9999 ]] && [[ ! ${PN} = retroarch ]] && [[ ! ${PN} = ppsspp-libretro ]] && [[ ! ${PN} = psp1-libretro ]] && [[ ! ${PN} = psp-assets ]] && [[ ! ${PN} = citra-libretro ]]; then
	[ ${LIBRETRO_COMMIT_SHA} = die ] && die "LIBRETRO_COMMIT_SHA must be set before inherit."
	SRC_URI="https://github.com/${LIBRETRO_REPO_NAME}/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}.tar.gz"
	RESTRICT="primaryuri"
	S="${WORKDIR}/${LIBRETRO_REPO_NAME##*/}-${LIBRETRO_COMMIT_SHA}"
fi

# Workaround for ebuilds needing submodules
if [[ ${PN} = ppsspp-libretro ]] || [[ ${PN} = psp1-libretro ]]  || [[ ${PN} = citra-libretro ]] && [[ ! ${PV} = 9999 ]]; then
	inherit git-r3
	
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/${LIBRETRO_REPO_NAME}.git"
	[ ${LIBRETRO_COMMIT_SHA} = die ] && die "LIBRETRO_COMMIT_SHA must be set before inherit."
	EGIT_COMMIT="${LIBRETRO_COMMIT_SHA}"
fi
