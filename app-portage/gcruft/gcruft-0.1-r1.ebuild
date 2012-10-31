# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils multilib

DESCRIPTION="helps finding orphaned files on a gentoo system"
HOMEPAGE="http://www.genoetigt.de/site/projects/gcruft"
SRC_URI="http://files.keksbude.net/gentoo/distfiles/${P}.tar.bz2"
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""

src_prepare() {
	if has_multilib_profile; then
		local multilib="yes";
	else
		local multilib="no";
	fi
	echo -e "
our \$DISTDIR = '${PORTAGE_ACTUAL_DISTDIR}';
our \$CHOST = '${CHOST}';
our \$PKGDIR = '${PKGDIR}';
our \$PORTAGE_TMPDIR = '${PORTAGE_TMPDIR}';
our \$PORTDIR = '${PORTDIR}';
our @PORTDIR_OVERLAY = ('$(env -i portageq portdir_overlay 2>/dev/null|sed -e "s/ /', '/g")');
our \$installedbase = '$(portageq vdb_path)';
our \$multilib = '$multilib';
our \$libmap = '$(get_libdir)';
our \$man_ext = '$(ecompress --suffix)';
" > config.pm.new
	sed -e '1,/^# == PORTAGE VARIABLES BEGIN ==/ w config.pm.start' "${S}"/config.pm >/dev/null
	sed -e '/^# == PORTAGE VARIABLES END ==/,999 w config.pm.end' "${S}"/config.pm >/dev/null
	cat config.pm.{start,new,end} > "${S}"/config.pm
	sed -e 's/^\(use warnings;use diagnostics;\)/#\1/' -i "${S}"/gcruft.pl
}

src_install() {
	local cfdir='/etc/gcruft'
	dodir /usr/share/gcruft
	mv "${S}"/share/{exceptions,functions.pl} "${D}"/usr/share/gcruft || die "couldn't move directories"
	dobin "${S}"/gcruft.pl
	dodoc "${S}"/README
	dodoc "${S}"/README.html
	dodoc "${S}"/exception.example.pl
	insinto $cfdir
	doins "${S}"/config.pm
	dodir $cfdir/exceptions
}

pkg_postinst() {
	einfo "Please check the files gcruft reports carefully"
	einfo "before deleting them! There are most probably false positives!"
	einfo "For further information take a look at the provided"
	einfo "README/README.html in /usr/share/doc/${PF}"
	einfo "Examples for custom exceptions can be found in the"
	einfo "exception.example.pl, which can also be found in"
	einfo "/usr/share/doc/${PF}"
}
