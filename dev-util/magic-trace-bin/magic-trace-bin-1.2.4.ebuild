# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"

DESCRIPTION="Collect and display high-resolution traces using Intel Processor Trace."
HOMEPAGE="https://magic-trace.org https://github.com/janestreet/magic-trace"
# Building from source needs a full OCaml/dune toolchain and a large set of
# Jane Street libraries that are not packaged.
SRC_URI="https://github.com/janestreet/${MY_PN}/releases/download/v${PV}/${MY_PN}
	-> ${P}"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

QA_PREBUILT="usr/bin/${MY_PN}"

src_unpack() {
	cp "${DISTDIR}/${P}" "${S}/${MY_PN}" || die
}

src_install() {
	dobin "${MY_PN}"
}

pkg_postinst() {
	elog "${MY_PN} needs a CPU with Intel Processor Trace and read access to"
	elog "performance events. If tracing fails, lower the paranoia level:"
	elog
	elog "    sysctl kernel.perf_event_paranoid=-1"
}
