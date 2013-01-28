# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils user

DESCRIPTION="Full-featured web server written in Java"
HOMEPAGE="http://jetty.codehaus.org/jetty/"
SRC_URI="http://git.eclipse.org/c/jetty/org.eclipse.jetty.project.git/snapshot/jetty-8.1.8.v20121106.tar.bz2 -> ${PN}-${PV}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+logrotate doc"

DEPEND="dev-java/maven-bin:3.0"
RDEPEND="${DEPEND}
	virtual/jre:1.6"

S="${WORKDIR}/jetty-8.1.8.v20121106"

pkg_setup() {
	enewgroup jetty
	enewuser jetty 765 -1 /dev/null jetty
}

src_compile() {
	mkdir temp-repo
	mvn -Dmaven.repo.local="$PWD/temp-repo" -Dmaven.test.skip=true clean install
}

src_install() {
	cd jetty-distribution/target/distribution

	insinto /etc/${PN}
	doins etc/* start.ini
	doins -r contexts resources

	insinto /usr/share/${PN}
	for i in lib overlays webapps; do
		doins -r "$i"
	done
	doins start.jar # Because of class-path java-pkg is not used

	keepdir /var/log/${PN}
	fowners jetty:jetty /var/log/${PN}
	fperms 0755 /etc/${PN} /var/log/${PN}

	dodoc LICENSE-* README* VERSION*

	use doc && dohtml javadoc

	newinitd "${FILESDIR}/$PN" $PN

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/${PN}.logrotate" $PN
	fi
}

src_test() {
	mvn test
}

# kate: replace-tabs false;
