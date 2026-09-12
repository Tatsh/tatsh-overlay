# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="GhidraApple"

inherit ghidra-extension

MY_COMMIT="828847d8e705e1373ac87620adeeef448edecd54"

DESCRIPTION="Better Apple binary analysis for Ghidra."
HOMEPAGE="https://github.com/ReverseApple/GhidraApple"
# The only release, v0.0.1-alpha1, is a prebuilt archive for Ghidra 11.3.1 from
# March 2025. Building the sources against the installed Ghidra is what makes
# this work at all, so the snapshot is used instead.
SRC_URI="https://github.com/ReverseApple/${GHIDRA_EXT_NAME}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${GHIDRA_EXT_NAME}-${MY_COMMIT}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

# 56 of the module's 57 sources are Kotlin.
BDEPEND="dev-lang/kotlin-bin"

PATCHES=( "${FILESDIR}/${P}-ghidra-12.patch" )
