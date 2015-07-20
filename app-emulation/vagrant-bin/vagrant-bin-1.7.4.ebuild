# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit rpm

DESCRIPTION="Binary distribution of Vagrant."
HOMEPAGE="https://www.vagrantup.com/"
SRC_URI="amd64? ( https://dl.bintray.com/mitchellh/vagrant/vagrant_${PV}_x86_64.rpm )
x86? ( https://dl.bintray.com/mitchellh/vagrant/vagrant_${PV}_i686.rpm )"
RESTRICT="mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="!!app-emulation/vagrant"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install () {
	mv {opt,usr} ${ED} || die 'mv failed'
}
