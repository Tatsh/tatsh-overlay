# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module nodejs

DESCRIPTION="An organiser for your special videos, written in Go."
HOMEPAGE="https://github.com/stashapp/stash https://docs.stashapp.cc/"
SRC_URI="https://github.com/stashapp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-vendor.tar.xz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
LICENSE="AGPL-3 MIT 0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC-BY-3.0 CC-BY-4.0 CC0-1.0 GPL-3 ISC MIT-0 MPL-2.0 public-domain PSF-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

UI_PV="2.5"

RDEPEND="media-video/ffmpeg"

PATCHES=(
	"${FILESDIR}/${PN}-0001-makefile-remove-ui-steps.patch"
	"${FILESDIR}/${PN}-0002-makefile-do-not-fight-the-package-manager.patch"
	"${FILESDIR}/${PN}-0003-gqlgen-skip-go-mod-tidy.patch"
)

src_compile() {
	# The Makefile's ui targets are patched out; the React app is built here
	# instead and embedded into the Go binary via ui/ui.go's go:embed.
	pushd "ui/v${UI_PV}" > /dev/null || die

	enpm run gqlgen || die "graphql codegen failed"

	VITE_APP_DATE="$(date '+%Y-%m-%d %H:%M:%S')"
	VITE_APP_NOLEGACY=true
	VITE_APP_STASH_VERSION="${PV}"
	export VITE_APP_DATE VITE_APP_NOLEGACY VITE_APP_STASH_VERSION
	enpm run build || die "ui build failed"

	popd > /dev/null || die

	# The Makefile derives the version with git describe, which does not work
	# from a release tarball, so pass it in. Upstream notes the build flags
	# differ between the two binaries, so they are built in separate runs.
	emake STASH_VERSION="v${PV}" release
	emake STASH_VERSION="v${PV}" phasher
}

src_install() {
	dobin "${PN}" phasher
	einstalldocs
}
