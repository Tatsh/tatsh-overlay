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
# Upstreams publish one prebuilt archive per Ghidra release and present them as
# if each only worked with the exact Ghidra version it was built against. That
# is not what Ghidra actually enforces. The whole check is a string comparison
# of the version= property in extension.properties against
# Application.getApplicationVersion(), in ExtensionTableModel.matchesGhidraVersion()
# and ExtensionInstaller (which offers an "Install Anyway" button anyway).
# ExtensionUtils.initializeExtensions(), the startup path that loads extensions
# out of Ghidra/Extensions/, performs no version check at all.
#
# The property is also not consistently a Ghidra version: some upstreams write
# their own plugin version into it instead. So this eclass rewrites version= to
# whatever dev-util/ghidra is actually installed, which is all Ghidra's own UI
# wants to see, and gates on the constraint that genuinely matters instead:
# whether the extension's bytecode still links against that Ghidra's jars. That
# is checked with jdeps, so a real incompatibility fails the build rather than
# being papered over.
#
# The remaining risk is what jdeps cannot see. It resolves class references out
# of the constant pool, so it catches removed or renamed classes but not removed
# methods, changed behaviour or reflective lookups, and Ghidra discovers plugins
# reflectively. Ghidra patch releases have been safe in practice (upstream
# builds of the same tag against 12.1.2 and 12.1.3 are byte-identical
# bytecode), minor releases have not, so GHIDRA_PV_MIN/GHIDRA_PV_MAX default to
# a single minor series and should be widened only after re-testing.
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
# Exact version of dev-util/ghidra that the distributed archive was built
# against. Documentation only as far as this eclass is concerned; ebuilds
# generally also interpolate it into SRC_URI, which is why it must be set
# before inheriting. It does not constrain the dependency: see GHIDRA_PV_MIN
# and GHIDRA_PV_MAX.

# @ECLASS_VARIABLE: GHIDRA_PV_MIN
# @PRE_INHERIT
# @DESCRIPTION:
# Oldest dev-util/ghidra the extension is known to work with, inclusive.
# Defaults to the 12.1 series.

# @ECLASS_VARIABLE: GHIDRA_PV_MAX
# @PRE_INHERIT
# @DESCRIPTION:
# First dev-util/ghidra the extension is not known to work with, exclusive.
# Defaults to 12.2, so the generated dependency spans one minor series. Raise
# it only after checking the extension against the newer Ghidra.

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

	: "${GHIDRA_PV_MIN:=12.1}"
	: "${GHIDRA_PV_MAX:=12.2}"

	SLOT="0"
	RDEPEND=">=dev-util/ghidra-${GHIDRA_PV_MIN}
		<dev-util/ghidra-${GHIDRA_PV_MAX}"
	# Ghidra's sleigh compiler and its jars are used at build time, so it is
	# needed in DEPEND as well as RDEPEND.
	DEPEND="${RDEPEND}"
	# jdeps and the sleigh compiler both come from the JDK.
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

# @FUNCTION: _ghidra-extension_get_ghidra_version
# @INTERNAL
# @DESCRIPTION:
# Echoes the version of the installed dev-util/ghidra.
_ghidra-extension_get_ghidra_version() {
	local prop_file="${ESYSROOT}${GHIDRA_HOME}/Ghidra/application.properties"
	[[ -f ${prop_file} ]] || die "${ECLASS}: ${prop_file} not found"

	local version
	version="$(sed -n 's/^application\.version=//p' "${prop_file}")" || die
	[[ ${version} ]] || die "${ECLASS}: no application.version in ${prop_file}"

	echo "${version}"
}

# @FUNCTION: _ghidra-extension_retarget
# @INTERNAL
# @DESCRIPTION:
# Rewrites the version= property in extension.properties to the installed
# Ghidra version, so Ghidra's extension manager reports the extension as
# matching. Ghidra never consults this value when loading an extension.
_ghidra-extension_retarget() {
	local version="${1}"

	[[ -f extension.properties ]] || die "${ECLASS}: no extension.properties in ${PWD}"

	sed -i "s/^version=.*$/version=${version}/" extension.properties || die
	grep -qx "version=${version}" extension.properties ||
		die "${ECLASS}: failed to set version= in extension.properties"
}

# @FUNCTION: _ghidra-extension_check_linkage
# @INTERNAL
# @DESCRIPTION:
# Verifies with jdeps that every class the extension's jars reference resolves
# against the installed Ghidra's jars plus the JDK. This is the real
# compatibility constraint that the version= property only pretends to express.
# A no-op for extensions that ship no jars, such as script-only ones.
_ghidra-extension_check_linkage() {
	local jars=()
	readarray -d '' jars < <(find lib -name '*.jar' -print0 2>/dev/null)
	(( ${#jars[@]} )) || return 0

	local classpath
	classpath="$(find "${ESYSROOT}${GHIDRA_HOME}" -name '*.jar' -printf '%p:')" || die
	[[ ${classpath} ]] || die "${ECLASS}: found no Ghidra jars to link against"

	# jdeps reports findings on stdout and exits 0 either way, so the output
	# itself is the verdict.
	local jar missing
	for jar in "${jars[@]}"; do
		einfo "Checking ${jar} against Ghidra ${1}"
		missing="$(jdeps --multi-release 21 --class-path "${classpath}" \
			--missing-deps "${jar}" 2>/dev/null)" || die "jdeps failed on ${jar}"
		if [[ ${missing} ]]; then
			eerror "${jar} references classes that Ghidra ${1} does not provide:"
			eerror "${missing}"
			die "${ECLASS}: ${jar} is not binary compatible with Ghidra ${1}"
		fi
	done
}

# @FUNCTION: ghidra-extension_src_compile
# @DESCRIPTION:
# Retargets the extension at the installed Ghidra, verifies that it actually
# links against it, and precompiles every data/languages/*.slaspec with
# Ghidra's sleigh compiler so that Ghidra never has to write into the read-only
# installed extension directory.
ghidra-extension_src_compile() {
	local ghidra_version
	ghidra_version="$(_ghidra-extension_get_ghidra_version)" || die

	_ghidra-extension_check_linkage "${ghidra_version}"
	_ghidra-extension_retarget "${ghidra_version}"

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
