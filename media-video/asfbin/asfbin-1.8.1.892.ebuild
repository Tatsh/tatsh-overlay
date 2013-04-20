# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils pax-utils

DESCRIPTION="Intuitive, fast and reliable tool for processing ASF and WMV files"
HOMEPAGE="http://www.radioactivepages.com/asfbin.aspx"
SRC_URI=""

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pax_kernel"
RESTRICT="strip" # Who knows if strip will cause problems..

DEPEND="app-arch/unzip"
RDEPEND="
	amd64? (
	sys-devel/gcc[multilib]
	)
${DEPEND}"

S="${WORKDIR}"

URI="http://www.radioactivepages.com/downloading.ashx?file=${PN}/${PN}linux${PV}.zip"

src_unpack() {
	# evil stuff below
	local DISTFILES="${S}" # Cannot write to $DISTDIR even if it was readable here
	local fn="$PN-$PV.zip"

	grep -s "^\s*FETCHCOMMAND=" /etc/make.globals > myenv
	grep -s "^\s*FETCHCOMMAND=" /etc/make.conf >> myenv

	if grep -s wget myenv 2>&1 > /dev/null; then
		sed -i myenv -r -e "s#(\/)?wget\s#\1wget --referer=${HOMEPAGE} -O $fn #"
	else
		echo "FETCHCOMMAND=\"/usr/bin/wget --referer=${HOMEPAGE} \${URI} -O $fn -P \${DISTFILES}\"" > myenv
	fi

	. myenv
	eval ${FETCHCOMMAND}
	unzip -qq "$fn" || die "Failed to unpack"
}

src_install() {
	into /opt
	dobin asfbin
	dodoc readme.txt whatsnew.txt

	if use pax_kernel; then
		pax-mark Cm "${ED}"/opt/bin/${PN} || die
		eqawarn "You have set USE=pax_kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel.  To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!  If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi
}

# kate: replace-tabs false;
