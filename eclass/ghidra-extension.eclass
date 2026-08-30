# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: ghidra-extension.eclass
# @MAINTAINER:
# Andrew Udvare <audvare@gmail.com>
# @AUTHOR:
# Andrew Udvare <audvare@gmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: install Ghidra extensions
# @DESCRIPTION:
# Installs a Ghidra extension into the installation-wide extension directory,
# /usr/share/ghidra/Ghidra/Extensions/, where Ghidra picks it up for every user
# of the installation. See "Ghidra Extension Notes" in
# /usr/share/ghidra/GettingStarted.md.
#
# Upstreams publish one prebuilt archive per Ghidra release, and an archive only
# works with the exact Ghidra version it was built against. Ebuilds must
# therefore set GHIDRA_PV before inheriting and bump it in lockstep with
# dev-util/ghidra. Where upstream publishes no archive for the packaged Ghidra
# version, build the extension out of tree and upload the result to the
# __distfiles__ release.
#
# Ghidra compiles any data/languages/*.slaspec on first use and writes the
# resulting .sla back into the extension's own directory. That works for a
# per-user install but fails once the extension is root-owned under /usr, so
# this eclass precompiles them using Ghidra's own sleigh compiler, exactly as
# Ghidra does for its bundled processor modules at build time.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported." ;;
esac

# @ECLASS_VARIABLE: GHIDRA_PV
# @REQUIRED
# @PRE_INHERIT
# @DESCRIPTION:
# Exact version of dev-util/ghidra that the extension was built against. Used
# to generate the dependency, so it must be set before inheriting.

# @ECLASS_VARIABLE: GHIDRA_EXT_NAME
# @REQUIRED
# @DESCRIPTION:
# Name of the installed extension directory. Ghidra identifies a module by its
# directory name, so this must be upstream's own name, which never matches the
# -bin package names used here.

if [[ ! ${_GHIDRA_EXTENSION_ECLASS} ]]; then

inherit edo java-pkg-2

EXPORT_FUNCTIONS src_prepare src_compile src_install

# @ECLASS_VARIABLE: GHIDRA_HOME
# @DESCRIPTION:
# Directory dev-util/ghidra installs into.
GHIDRA_HOME="/usr/share/ghidra"

# @FUNCTION: _ghidra-extension_set_globals
# @INTERNAL
# @DESCRIPTION:
# Sets the global output variables provided by this eclass. Must be called once
# in global scope.
_ghidra-extension_set_globals() {
	[[ ${GHIDRA_PV} ]] || die "${ECLASS}: GHIDRA_PV must be set before inherit"

	SLOT="0"
	RDEPEND="~dev-util/ghidra-${GHIDRA_PV}"
	# Ghidra's sleigh compiler is run at build time, so it is needed in DEPEND
	# as well as RDEPEND.
	DEPEND="${RDEPEND}"
	BDEPEND="app-arch/unzip
		virtual/jdk:21"
}
_ghidra-extension_set_globals

# @FUNCTION: ghidra-extension_src_prepare
# @DESCRIPTION:
# Runs java-pkg-2_src_prepare, then removes build-system and CI files that
# upstreams routinely ship inside the extension archive but which have no
# runtime role.
ghidra-extension_src_prepare() {
	java-pkg-2_src_prepare

	local cruft
	for cruft in .github gradle gradlew gradlew.bat build.gradle \
		settings.gradle certification.manifest lib/*-src.zip; do
		[[ -e ${cruft} ]] && { rm -r "${cruft}" || die; }
	done

	return 0
}

# @FUNCTION: ghidra-extension_src_compile
# @DESCRIPTION:
# Precompiles every data/languages/*.slaspec with Ghidra's sleigh compiler so
# that Ghidra never has to write into the read-only installed extension
# directory. A no-op for extensions that ship no sleigh sources.
ghidra-extension_src_compile() {
	local langdir=data/languages
	local specs=( "${langdir}"/*.slaspec )
	[[ -f ${specs[0]} ]] || return 0

	local -x JAVA_HOME
	JAVA_HOME="$(java-config -O)" || die
	local -x XDG_CONFIG_HOME="${T}/config"
	local -x _JAVA_OPTIONS="-Djava.io.tmpdir=${T}"
	mkdir -p "${XDG_CONFIG_HOME}" || die

	# dev-util/ghidra does not install support/sleigh executable.
	edo bash "${BROOT}${GHIDRA_HOME}/support/sleigh" -a "${langdir}"

	local spec
	for spec in "${specs[@]}"; do
		[[ -f ${spec%.slaspec}.sla ]] || die "sleigh produced no .sla for ${spec}"
	done
}

# @FUNCTION: ghidra-extension_src_install
# @DESCRIPTION:
# Installs the whole extension tree under the Ghidra installation's extension
# directory, using upstream's module name.
ghidra-extension_src_install() {
	[[ ${GHIDRA_EXT_NAME} ]] || die "${ECLASS}: GHIDRA_EXT_NAME must be set"

	insinto "${GHIDRA_HOME}/Ghidra/Extensions/${GHIDRA_EXT_NAME}"
	doins -r ./*
}

_GHIDRA_EXTENSION_ECLASS=1
fi
