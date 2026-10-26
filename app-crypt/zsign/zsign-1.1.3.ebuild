# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Cross-platform tool to sign iOS app bundles and IPA files"
HOMEPAGE="https://github.com/zhlynn/zsign"
SRC_URI="https://github.com/zhlynn/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/openssl:=
	virtual/minizip:=
	virtual/zlib:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

# shellcheck disable=SC2016
src_prepare() {
	default
	# Respect the user's flags.
	sed -e 's/^CXXFLAGS = -std=c++11 -O3 /CXXFLAGS = -std=c++11 $(USER_CXXFLAGS) /' \
		-e 's/\$(LIBS) -o \$(TARGET)$/$(LDFLAGS) $(LIBS) -o $(TARGET)/' \
		-i build/linux/Makefile || die
	grep -q 'USER_CXXFLAGS' build/linux/Makefile || die "failed to patch CXXFLAGS"
	grep -q '$(LDFLAGS) $(LIBS)' build/linux/Makefile || die "failed to patch LDFLAGS"
	# Use the system zlib and minizip.
	rm -r src/third-party/{minizip,zlib} || die
}

src_compile() {
	emake -C build/linux \
		CXX="$(tc-getCXX)" \
		USER_CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		SYSTEM_MINIZIP=1 \
		VERSION="${PV}"
}

src_install() {
	dobin bin/zsign
	einstalldocs
}
