# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Open source Nintendo 64 SDK and asset tools"
HOMEPAGE="https://libdragon.dev/ https://github.com/n64brew/libdragon"
# The preview branch.
SHA="f26e1c16145e4d6ad7e391e1306513d684083c02"
SRC_URI="
	https://github.com/n64brew/libdragon/archive/${SHA}.tar.gz -> ${PN}-${SHA}.tar.gz
	roms? (
		https://archive.org/download/CaminandesLlamigos/Caminandes_%20Llamigos-1080p.ogv
			-> ${PN}-caminandes.ogv
	)
"
S="${WORKDIR}/${PN}-${SHA}"

LICENSE="Unlicense FatFs ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples roms"
# Target objects must not be touched by the host strip, and tests need an N64.
RESTRICT="strip test"

DEPEND="dev-embedded/libdragon-gcc"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

TARGET="mips64-libdragon-elf"
# Bare-metal target objects carry no .note.GNU-stack section.
QA_EXECSTACK="usr/${TARGET}/lib/*"

src_unpack() {
	unpack "${PN}-${SHA}.tar.gz"
}

src_prepare() {
	# Warnings must not break the build here or in projects that include n64.mk.
	sed -i -e 's/ -Werror\([[:space:]]\|$\)/\1/g' n64.mk boot/Makefile tools/Makefile || die
	default
	if use examples; then
		cp -a examples "${WORKDIR}/examples" || die
	fi
	if use roms; then
		# The videoplayer example otherwise downloads this at build time.
		cp "${DISTDIR}/${PN}-caminandes.ogv" examples/videoplayer/caminandes.ogv || die
	fi
}

libdragon_emake() {
	emake N64_INST="${EPREFIX}/usr" N64_TARGET="${TARGET}" "$@"
}

# The library build appends the environment's flags to the target flags.
libdragon_target_emake() {
	(
		unset ASFLAGS CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
		libdragon_emake "$@"
	)
}

libdragon_tools_emake() {
	libdragon_emake -C tools CC="$(tc-getCC)" CXX="$(tc-getCXX)" AR="$(tc-getAR)" "$@"
}

src_compile() {
	libdragon_target_emake libdragon
	libdragon_tools_emake

	if use roms; then
		# The examples build against an installed SDK, so stage one. They include source files
		# by relative path, so they are built in place.
		local stage="${WORKDIR}/stage/usr"
		libdragon_target_emake INSTALLDIR="${stage}" install
		libdragon_tools_emake INSTALLDIR="${stage}" install
		(
			unset ASFLAGS CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
			local -x N64_INST="${stage}" N64_GCCPREFIX="${EPREFIX}/usr" N64_TARGET="${TARGET}"
			emake -C examples
		)
	fi
}

src_install() {
	libdragon_target_emake INSTALLDIR="${ED}/usr" install
	libdragon_tools_emake INSTALLDIR="${ED}/usr" install
	if use examples; then
		docinto examples
		dodoc -r "${WORKDIR}"/examples/.
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
	if use roms; then
		insinto "/usr/share/${PN}/roms"
		find examples -name '*.z64' -exec doins {} + || die
	fi
	newenvd - 50libdragon <<-EOF2
		N64_INST="${EPREFIX}/usr"
		N64_TARGET="${TARGET}"
	EOF2
	einstalldocs
}
