# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_HASH="b7fe41c1b309fcfac8b9989486009b05d1b5b1a2"
USE_RUBY="ruby22 ruby23 ruby24 ruby25 ruby26"
RUBY_FAKEGEM_EXTRADOC="${PN:4}-${MY_HASH}/README.md"
RUBY_FAKEGEM_EXTRAINSTALL="${PN:4}-${MY_HASH}/bin"
RUBY_S="${PN}-*"
inherit ruby-fakegem

DESCRIPTION="Various small Unix utilities"
HOMEPAGE="https://github.com/taw/unix-utilities"
SRC_URI="https://github.com/taw/unix-utilities/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="git kindle lastfm youtube ruby google progress soup nine-gag tfl extras mp3"

EXTRAS=(
	annotate_sgf
	convert_to_png
	countdown
	e
	gzip_stream
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
	nine-gag? ( media-gfx/imagemagick )
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
	dev-ruby/optimist
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
	local -r prefix="${PN:4}-${MY_HASH}"

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
	! use nine-gag && rm "${prefix}/bin/strip_9gag"
	! use tfl && rm "${prefix}/bin/tfl_travel_time"
	! use mp3 && rm "${prefix}/bin/speedup_mp3"
	if ! use extras; then
		for name in ${EXTRAS[*]}; do
			rm "${prefix}/bin/${name}"
		done
	fi
}

all_ruby_install() {
	local -r prefix="${PN:4}-${MY_HASH}"
	all_fakegem_install
	dobin "${prefix}/bin/colcut"
}
