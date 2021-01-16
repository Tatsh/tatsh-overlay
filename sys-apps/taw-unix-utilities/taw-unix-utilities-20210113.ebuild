# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_SHA="05ee03fd89c967846e4f84fd2647bb2b2b2ae09a"
USE_RUBY="ruby25 ruby26 ruby27"
RUBY_FAKEGEM_EXTRADOC="${PN:4}-${MY_SHA}/README.md"
RUBY_FAKEGEM_EXTRAINSTALL="${PN:4}-${MY_SHA}/bin"
RUBY_S="${PN}-*"
inherit ruby-fakegem

DESCRIPTION="Various small Unix utilities"
HOMEPAGE="https://github.com/taw/unix-utilities"
SRC_URI="https://github.com/taw/unix-utilities/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="git kindle lastfm youtube ruby google progress soup jpeg tfl extras mp3
	png zlib"

EXTRAS=(
	annotate_sgf
	countdown
	e
	media_size
	rot13
	unall
	webman
	xnorm
)

RDEPEND="
	git? ( dev-vcs/git )
	google? ( dev-ruby/hpricot )
	kindle? ( app-text/calibre )
	mp3? ( media-video/ffmpeg[mp3] media-sound/id3v2 media-sound/sox )
	jpeg? ( media-gfx/imagemagick )
	progress? ( !sys-apps/progress )
	youtube? ( x11-misc/xdg-utils )
	extras? (
		app-arch/p7zip
		app-arch/tar
		media-gfx/imagemagick
		media-libs/exiftool
		sys-apps/coreutils
		sys-apps/file
		sys-apps/groff
		virtual/man )"
ruby_add_rdepend "dev-ruby/color
	dev-ruby/fileutils
	dev-ruby/nokogiri
	dev-ruby/optimist:3
	dev-ruby/pry
	dev-ruby/rake
	dev-ruby/sqlite3
	google? ( dev-ruby/hpricot )
	extras? ( dev-ruby/moneta )"
DEPEND="${RDEPEND}"
BDEPEND=""

DOCS=( README.md )
_PATCHES=(
	"${FILESDIR}/kindle_sync.patch"
	"${FILESDIR}/open_youtube.patch"
	"${FILESDIR}/strip_9gag.patch"
	"${FILESDIR}/unall.patch"
	"${FILESDIR}/webman.patch"
)

all_ruby_prepare() {
	local -r prefix="${PN:4}-${MY_SHA}"

	pushd "$prefix"
	for patch in ${_PATCHES[*]}; do
		eapply "$patch"
	done
	popd

	rm "${prefix}/bin/rename" "${prefix}/bin/tac" \
		"${prefix}/bin/terminal_title" "${prefix}/bin/volume" \
		"${prefix}/bin/xrmdir" "${prefix}/bin/osx"* "${prefix}/bin/flickr"*
	mv "${prefix}/bin/git_hash" "${prefix}/bin/git-hash"
	! use git && rm "${prefix}/bin/git-hash"
	! use kindle && rm "${prefix}/bin/kindle_sync"
	! use lastfm && rm "${prefix}/bin/lastfm_status"
	! use youtube && rm "${prefix}/bin/open_youtube"
	! use ruby && rm "${prefix}/bin/rbexe"
	! use google && rm "${prefix}/bin/process_gplus_takeout"
	! use progress && rm "${prefix}/bin/progress"
	! use soup && rm "${prefix}/bin/since_soup"
	! use jpeg && rm "${prefix}/bin/strip_9gag"
	! use tfl && rm "${prefix}/bin/tfl_travel_time"
	! use mp3 && rm "${prefix}/bin/speedup_mp3"
	! use png && rm "${prefix}/bin/convert_to_png"
	! use zlib && rm "${prefix}/bin/gzip_stream"
	if ! use extras; then
		for name in ${EXTRAS[*]}; do
			rm "${prefix}/bin/${name}"
		done
	fi
}

all_ruby_install() {
	local -r prefix="${PN:4}-${MY_SHA}"
	all_fakegem_install
	dobin "${prefix}/bin/colcut"
}
