# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: ps2-port.eclass
# @MAINTAINER:
# Andrew Udvare <audvare@gmail.com>
# @AUTHOR:
# Andrew Udvare <audvare@gmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: build CMake libraries for the PlayStation 2 Emotion Engine
# @DESCRIPTION:
# Builds a CMake project with ps2sdk's ps2dev.cmake toolchain file and installs it into the ps2sdk
# ports prefix, as ps2sdk-ports' build-cmakelibs.sh does. Set mycmakeargs before calling
# ps2-port_src_configure to pass extra options.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_PS2_PORT_ECLASS} ]]; then
_PS2_PORT_ECLASS=1

inherit edo

# @ECLASS_VARIABLE: PS2_PORT_CMAKE_DIR
# @DESCRIPTION:
# Directory containing the top-level CMakeLists.txt. Defaults to S.
: "${PS2_PORT_CMAKE_DIR:=}"

# @ECLASS_VARIABLE: mycmakeargs
# @DEFAULT_UNSET
# @DESCRIPTION:
# Optional array of extra arguments passed to cmake by ps2-port_src_configure.

# @ECLASS_VARIABLE: PS2_PORTS
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# The ports installation prefix.
PS2_PORTS="/usr/lib/ps2dev/ps2sdk/ports"

# Target objects must not be touched by the host strip, and tests would need a PS2.
RESTRICT="strip test"
# @ECLASS_VARIABLE: QA_EXECSTACK
# @INTERNAL
# @DESCRIPTION:
# Bare-metal target objects carry no .note.GNU-stack section.
QA_EXECSTACK="${PS2_PORTS#/}/*"

DEPEND="dev-embedded/ps2sdk"
BDEPEND="
	${DEPEND}
	app-alternatives/ninja
	dev-build/cmake
"

# @FUNCTION: ps2-port_src_configure
# @DESCRIPTION:
# Configure with the EE toolchain file. Host compiler flags are dropped because CMake would append
# them to the target flags.
ps2-port_src_configure() {
	unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
	local -x PS2DEV="${EPREFIX}/usr/lib/ps2dev"
	local -x PS2SDK="${PS2DEV}/ps2sdk"
	# shellcheck disable=SC2154
	edo cmake -S "${PS2_PORT_CMAKE_DIR:-${S}}" -B "${WORKDIR}/build" -G Ninja -Wno-dev \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}${PS2_PORTS}" \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
		-DCMAKE_PREFIX_PATH="${EPREFIX}${PS2_PORTS}" \
		-DCMAKE_TOOLCHAIN_FILE="${PS2DEV}/share/ps2dev.cmake" \
		"${mycmakeargs[@]}"
}

# @FUNCTION: ps2-port_src_compile
# @DESCRIPTION:
# Build the project.
ps2-port_src_compile() {
	edo cmake --build "${WORKDIR}/build"
}

# @FUNCTION: ps2-port_src_install
# @DESCRIPTION:
# Install the project into the image.
ps2-port_src_install() {
	DESTDIR="${D}" edo cmake --install "${WORKDIR}/build"
}

fi

EXPORT_FUNCTIONS src_configure src_compile src_install
