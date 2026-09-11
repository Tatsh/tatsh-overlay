# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="SwitchLoader"

inherit java-utils-2 ghidra-extension

MY_PN="Ghidra-Switch-Loader"
# Upstream's newest tag is from 2019 and no longer compiles. Its releases are
# cut from the default branch instead, this being the commit behind
# 1.6.1-9bba6a6-Ghidra_12.1.2.
MY_COMMIT="9bba6a6643f41d11386ea5bb2f0bc1d2ea536e2a"

DESCRIPTION="Ghidra loader for Nintendo Switch NSO, NRO and KIP executables."
HOMEPAGE="https://github.com/Adubbz/Ghidra-Switch-Loader"
SRC_URI="https://github.com/Adubbz/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="ISC"
KEYWORDS="~amd64"

# Upstream resolves these from Maven. Ghidra loads every jar in a module's
# lib/, so the system jars are copied there, which is where upstream's own
# archive keeps its copies. Its third declared dependency,
# commons-primitives, is unused: the only primitives import in the sources is
# Guava's, which Ghidra itself provides.
DEPEND+=" dev-java/lz4-java:0
	dev-java/zstd-jni:0"

src_prepare() {
	ghidra-extension_src_prepare

	# A build file; upstream's own archive does not contain it either.
	rm gradle.properties || die

	mkdir -p lib || die
	cp "$(java-pkg_getjar lz4-java lz4-java.jar)" lib/ || die
	cp "$(java-pkg_getjar zstd-jni zstd-jni.jar)" lib/ || die
}
