# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bash Line Editor."
HOMEPAGE="https://github.com/akinomyoga/ble.sh"
SHA="27e6309ef2344d37a6cec49f37b958c70f660472"
CONTRIB_SHA="eff9494fe05c47adab59e7cf27e0ef557ae22138"
MY_PN="ble.sh"
SRC_URI="https://github.com/akinomyoga/${MY_PN}/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/akinomyoga/${PN}-contrib/archive/${CONTRIB_SHA}.tar.gz -> ${PN}-contrib-${CONTRIB_SHA:0:7}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-shells/bash:0"

S="${WORKDIR}/${MY_PN}-${SHA}"

src_prepare() {
	rmdir contrib || die
	mv "${WORKDIR}/${PN}-contrib-${CONTRIB_SHA}" contrib || die
	sed -re 's/ \.git //g' -e "s|doc/blesh|doc/${P}|" -i GNUmakefile || die
	sed -re "s/system\(\"git show -s --format=%h\"\)/\"${SHA}\"/" -i ble.pp || die
	default
}

src_install() {
	emake install "DESTDIR=${D}/usr"
	rm "${D}/usr/share/doc/${P}/"{LICENSE,CONTRIBUTING,Release,ChangeLog}.md \
		"${D}/usr/share/doc/${P}/contrib/LICENSE" || die
}
