# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A powerful tool to check TSS signing status of various devices and firmwares."
HOMEPAGE="https://github.com/tihmstar/tsschecker"
MY_COMMIT_COUNT="319"
MY_SHA="bdeed20aadb644239a2a50aae15af08a18b44d81"
JSSY_SHA="e17d3c8ec5216692efbbe59bbe9801bb7661e07d"
SRC_URI="https://github.com/tihmstar/tsschecker/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/tihmstar/jssy/archive/${JSSY_SHA}.tar.gz -> ${P}-jssy.tar.gz"

# jssy is MIT
LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libfragmentzip
	app-pda/libplist
	net-misc/curl
	dev-libs/openssl:0
	app-pda/libirecovery"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=(
	"${FILESDIR}/saveblobs.patch"
	"${FILESDIR}/xopen-source-500.patch"
)

DOCS=( LICENSE README.md )

src_prepare() {
	default
	local -r quoted_commit_count='\\\\\\"'"${MY_COMMIT_COUNT}"'\\\\\\"'
	local -r quoted_sha='\\\\\\"'"${MY_SHA}"'\\\\\\"'
	sed -i "s/^CFLAGS+=\" -D TSSCHECKER_VERSION_COUNT=.*/CFLAGS+=\" -D TSSCHECKER_VERSION_COUNT=${quoted_commit_count}\"/" \
		./configure.ac || die "Failed to patch"
	sed -i "s/^CFLAGS+=\" -D TSSCHECKER_VERSION_SHA=.*/CFLAGS+=\" -D TSSCHECKER_VERSION_SHA=${quoted_sha}\"/" \
		./configure.ac || die "Failed to patch"
	eautoreconf
	mkdir "${S}/external/jssy"
	cp -R "${WORKDIR}/jssy-${JSSY_SHA}/"* "${S}/external/jssy/" || die
}

src_install() {
	default
	einstalldocs
	dobin saveblobs.sh
	insinto /etc/${PN}
	rm "${D}/usr/$(get_libdir)/libjssy.a"
	rmdir "${D}/usr/lib64"
}
