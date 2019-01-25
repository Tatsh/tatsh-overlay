# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="infer"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A static analyzer for Java, C, C++, and Objective-C."
HOMEPAGE="https://fbinfer.com/"
SRC_URI="https://github.com/facebook/${MY_PN}/releases/download/v${PV}/${MY_PN}-linux64-v${PV}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-linux64-v${PV}"

QA_PREBUILT="/opt/${MY_P}/lib/infer/facebook-clang-plugins/clang/install/lib/*.so*
	/opt/${MY_P}/lib/infer/facebook-clang-plugins/clang/install/bin/*
	/opt/${MY_P}/lib/infer/facebook-clang-plugins/clang/install/lib/clang/7.0.0/lib/linux/*.so*"

src_prepare() {
	for i in share/man/man*/*.gz; do
		gzip -d "$i"
	done
	find -iname '*.dylib' -delete
	default
}

src_install() {
	mkdir -p "${D}/opt/${MY_P}/lib"
	rsync -a "${S}/lib/" "${D}/opt/${MY_P}/lib"
	for i in analyze capture compile explore report reportdiff run; do
		dosym /opt/bin/infer /opt/bin/infer-${i}
	done
	dosym /opt/${MY_P}/lib/infer/infer/bin/infer /opt/bin/infer
	doman share/man/man*/*
}
