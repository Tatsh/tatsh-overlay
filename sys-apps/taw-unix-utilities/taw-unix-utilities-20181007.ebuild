# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_HASH="b7fe41c1b309fcfac8b9989486009b05d1b5b1a2"
USE_RUBY="ruby22 ruby23 ruby24 ruby25 ruby26"
RUBY_FAKEGEM_EXTRADOC="${PN:4}-${MY_HASH}/README.md"
RUBY_FAKEGEM_EXTRAINSTALL="${PN:4}-${MY_HASH}/bin"
inherit ruby-fakegem

DESCRIPTION="Various small Unix utilities"
HOMEPAGE="https://github.com/taw/unix-utilities"
SRC_URI="https://github.com/taw/unix-utilities/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="git kindle lastfm youtube ruby google progress soup nine-gag tfl extras"

EXTRAS=(
	annotate_sgf
	convert_to_png
	countdown
	e
	gzip_stream
	media_size
	rot13
	speedup_mp3
	unall
	webman
	xnorm
)

ruby_add_rdepend "dev-ruby/pry
	dev-ruby/optimist
	dev-ruby/color
	dev-ruby/rake
	dev-ruby/nokogiri
	dev-ruby/sqlite3
	lastfm? ( dev-ruby/magic-xml )
	extras? (
		media-libs/exiftool
		media-sound/sox
		app-arch/p7zip
		app-arch/unrar )"
DEPEND="${RDEPEND}"
BDEPEND=""

DOCS=( README.md )

all_ruby_prepare() {
	local -r prefix="${PN:4}-${MY_HASH}"
	rm "${prefix}/bin/rename" "${prefix}/bin/tac" \
		"${prefix}/bin/terminal_title" "${prefix}/bin/volume" \
		"${prefix}/bin/xrmdir" "${prefix}/bin/osx"* "${prefix}/bin/flickr"*
	! use git && rm "${prefix}/bin/git_hash"
	! use kindle && rm "${prefix}/bin/kindle_sync"
	! use lastfm && rm "${prefix}/bin/lastfm_status"
	! use youtube && rm "${prefix}/bin/open_youtube"
	! use ruby && rm "${prefix}/bin/rbexe"
	! use google && rm "${prefix}/bin/process_gplus_takeout"
	! use progress && rm "${prefix}/bin/progress"
	! use soup && rm "${prefix}/bin/since_soup"
	! use nine-gag && rm "${prefix}/bin/strip_9gag"
	! use tfl && rm "${prefix}/bin/tfl_travel_time"
	if ! use extras; then
		for name in ${EXTRAS[*]}; do
			rm "${prefix}/bin/${name}"
		done
	fi
	default
}

all_ruby_install() {
	local -r prefix="${PN:4}-${MY_HASH}"
	all_fakegem_install
	dobin "${prefix}/bin/colcut"
}
