# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools cmake flag-o-matic multiprocessing

DESCRIPTION="An active fork of curl-impersonate with more versions and build targets."
HOMEPAGE="https://github.com/lexiforest/curl-impersonate"
BORINGSSL_SHA="cd95210465496ac2337b313cf49f607762abe286"
CURL_VERSION="curl-8_7_1"
SRC_URI="https://github.com/lexiforest/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/google/boringssl/archive/${BORINGSSL_SHA}.tar.gz -> boringssl-${BORINGSSL_SHA}.tar.gz
	https://github.com/curl/curl/archive/${CURL_VERSION}.tar.gz -> ${CURL_VERSION//_/.}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clients"

DEPEND="app-arch/brotli:=
	dev-libs/nss:=
	llvm-runtimes/libcxx:=
	net-libs/nghttp2:="
RDEPEND="${DEPEND}"
BDEPEND="dev-build/ninja
	dev-build/cmake"

DOCS=( README.md )

# This package is cURL built with boringssl with a few patches (both in cURL and boringssl). This
# ebuild skips over curl-impersonate's not so great autotools use and just builds boringssl then
# cURL with the patches.

src_prepare() {
	mv "${WORKDIR}/boringssl-${BORINGSSL_SHA}" "${S}/" || die
	pushd "boringssl-${BORINGSSL_SHA}" || die
	eapply ../chrome/patches/boringssl.patch
	touch .patched || die
	cmake_src_prepare
	popd || die
	mv "${WORKDIR}/curl-${CURL_VERSION}" "${S}/${CURL_VERSION}" || die
	pushd "${CURL_VERSION}" || die
	eapply ../chrome/patches/curl-impersonate.patch
	eautoreconf
	touch .patched-chrome || die
	popd || die
	default
}

src_configure() {
	pushd "boringssl-${BORINGSSL_SHA}" || die
	append-cxxflags -Wno-error=maybe-uninitialized -Wno-unknown-warning-option
	filter-lto
	local mycmakeargs=( -DBUILD_SHARED_LIBS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON )
	cmake_src_configure
	popd || die
}

src_compile() {
	pushd "boringssl-${BORINGSSL_SHA}" || die
	cmake_src_compile
	popd || die
	mkdir "boringssl-${BORINGSSL_SHA}/lib" || die
	cp "boringssl-${BORINGSSL_SHA}_build"/*.a "boringssl-${BORINGSSL_SHA}/lib" || die
	pushd "${CURL_VERSION}" || die
	# This configure has to be here to see the libraries just built
	append-cxxflags -stdlib=libc++
	append-ldflags -lc++
	econf \
		"--with-brotli=${EPREFIX}/usr/$(get_libdir)" \
		"--with-ca-bundle=${EPREFIX}/etc/ssl/certs/ca-certificates.crt" \
		"--with-nghttp2=${EPREFIX}/usr/$(get_libdir)" \
		"--with-openssl=${S}/boringssl-${BORINGSSL_SHA}" \
		"--with-zlib=${EPREFIX}/usr/$(get_libdir)" \
		"--with-zstd=${EPREFIX}/usr/$(get_libdir)" \
		--enable-ech \
		--enable-ipv6 \
		--disable-static \
		--enable-websockets \
		LIBS="-pthread -lbrotlidec -lc++" \
		USE_CURL_SSLKEYLOGFILE=true
	emake
	popd || die
}

src_install() {
	pushd "${CURL_VERSION}" || die
	emake DESTDIR="${D}" install
	rm -fR "${D}/usr/share/man" "${D}/usr/share/aclocal" "${D}/usr/include" || die
	popd || die
	if use clients; then
		local bn i
		for i in chrome/curl_*; do
			bn=$(basename "$i")
			newbin "$i" "${bn//_/-}"
		done
	fi
	einstalldocs
}
