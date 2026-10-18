# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open source SDK for the PlayStation 2"
HOMEPAGE="https://github.com/ps2dev/ps2sdk"
SHA="3304cd864748ce40b1ff9fb41cc5a700f5e573a0"
LWIP_TAG="STABLE-2_2_1_RELEASE"
FATFS_SHA="18cc3d9e07473a6aa3d783a66224b243a7b4974c"
SRC_URI="
	https://github.com/ps2dev/ps2sdk/archive/${SHA}.tar.gz -> ${PN}-${SHA}.tar.gz
	https://github.com/lwip-tcpip/lwip/archive/refs/tags/${LWIP_TAG}.tar.gz -> lwip-${LWIP_TAG}.tar.gz
	https://github.com/fjtrujy/FatFs/archive/${FATFS_SHA}.tar.gz -> FatFs-${FATFS_SHA}.tar.gz
"
S="${WORKDIR}/${PN}-${SHA}"

LICENSE="AFL-2.0 BSD FatFs"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"
# Target objects must not be touched by the host strip.
RESTRICT="strip test"

DEPEND="
	dev-games/ps2-ee-gcc
	dev-games/ps2-iop-gcc
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

# Spans both the EE and IOP, so it lives outside either target sysroot.
PS2DEV_DIR="/usr/lib/ps2dev"
# Bare-metal target objects carry no .note.GNU-stack section.
QA_EXECSTACK="${PS2DEV_DIR#/}/* usr/mips64r5900el-ps2-elf/lib/crt0.o usr/mipsel-none-elf/lib/crt0.o"
# Linked IOP modules and samples have a single RWX segment.
QA_WX_LOAD="${PS2DEV_DIR#/}/*"

src_prepare() {
	mv "${WORKDIR}/lwip-${LWIP_TAG}" common/external_deps/lwip || die
	mv "${WORKDIR}/FatFs-${FATFS_SHA}" common/external_deps/fatfs || die
	# Warnings must not break the build.
	sed -i -e 's/ -Werror\([[:space:]]\|$\)/\1/g' {ee,iop,tools}/Rules.make || die
	# Do not clone dependencies at build time.
	sed -i -e '/download_dependencies\.sh/d' common/external_deps/Makefile || die
	# Install crt0.o into the crossdev-style sysroots instead of upstream's ${PS2DEV}/{ee,iop}.
	# shellcheck disable=SC2016
	sed -i -e 's#$(PS2DEV)/\(ee\|iop\)/#$(SYSROOT_PREFIX)/#' {ee,iop}/startup/Makefile || die
	default
}

ps2sdk_emake() {
	unset PS2SDKSRC
	# The recursive makefiles build the same directories from two rule chains under -j, and the
	# racing jobs truncate each other's objects.
	emake -j1 "$@"
}

src_compile() {
	PS2DEV="${EPREFIX}${PS2DEV_DIR}" PS2SDK="${EPREFIX}${PS2DEV_DIR}/ps2sdk" ps2sdk_emake
}

src_install() {
	local lib

	dodir /usr/{mips64r5900el-ps2-elf,mipsel-none-elf}/lib
	PS2DEV="${ED}${PS2DEV_DIR}" PS2SDK="${ED}${PS2DEV_DIR}/ps2sdk" ps2sdk_emake \
		SYSROOT_PREFIX="${ED}/usr" install
	# Only the Makefile.* fragments in samples are needed to build PS2 software.
	local samples="${ED}${PS2DEV_DIR}/ps2sdk/samples"
	if use examples; then
		mkdir -p "${ED}/usr/share/doc/${PF}/examples" || die
		find "${samples}" -mindepth 1 -maxdepth 1 \( -type d -o -name Makefile \) \
			-exec mv -t "${ED}/usr/share/doc/${PF}/examples" {} + || die
		docompress -x "/usr/share/doc/${PF}/examples"
	else
		find "${samples}" -mindepth 1 -maxdepth 1 \( -type d -o -name Makefile \) \
			-exec rm -r {} + || die
	fi
	# GCC links these by default as part of the standard libraries.
	for lib in cdvd cglue kernel pthreadglue profglue; do
		dosym -r "${PS2DEV_DIR}/ps2sdk/ee/lib/lib${lib}.a" "/usr/mips64r5900el-ps2-elf/lib/lib${lib}.a"
	done
	newenvd - 50ps2sdk <<-EOF2
		PATH="${EPREFIX}${PS2DEV_DIR}/ps2sdk/bin"
		PS2DEV="${EPREFIX}${PS2DEV_DIR}"
		PS2SDK="${EPREFIX}${PS2DEV_DIR}/ps2sdk"
	EOF2
}
