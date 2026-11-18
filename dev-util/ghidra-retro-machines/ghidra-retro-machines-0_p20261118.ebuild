# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_EXT_NAME="ghidra-retro-machines"
GHIDRA_PV_MIN=12.2
GHIDRA_EXT_TESTS=1
# Upstream's test task leaves these out too: they need full SingleStepTests
# clones or user-supplied ROMs.
GHIDRA_EXT_TEST_EXCLUDE=(
	retromachines/corpus/SnesRomCorpusTest.java
	retromachines/corpus/Spc700DisCorpusTest.java
	retromachines/vectors/Mos6502VectorExhaustiveTest.java
	retromachines/vectors/Spc700VectorExhaustiveTest.java
	retromachines/vectors/W65816VectorExhaustiveTest.java
)

inherit edo java-utils-2 ghidra-extension

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="da7aebc7b6b3c54b388b40253b15f84670d4b088"

DESCRIPTION="Ghidra processor modules and loaders for retro home computers"
HOMEPAGE="https://github.com/CBongo/ghidra-retro-machines"
SRC_URI="https://github.com/CBongo/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND+=" dev-java/snakeyaml:0"
DEPEND="${RDEPEND}"

src_prepare() {
	ghidra-extension_src_prepare
	mkdir -p lib || die
	java-pkg_jar-from --into lib snakeyaml
}

src_compile() {
	ghidra-extension_src_compile

	# Upstream's Gradle build compiles the charset maps and the machine and game
	# descriptors from machines/ with the build-only tools/gdtbuilder.
	local -x JAVA_PKG_WANT_SOURCE JAVA_PKG_WANT_TARGET
	JAVA_PKG_WANT_SOURCE="$(sed -n 's/^application\.java\.compiler=//p' \
		"${ESYSROOT}${GHIDRA_HOME}/Ghidra/application.properties")" || die
	JAVA_PKG_WANT_TARGET="${JAVA_PKG_WANT_SOURCE}"
	local classpath
	classpath="$(ghidra-extension_get_classpath)" || die
	ejavac -d "${T}/gdtbuilder" -encoding UTF-8 -proc:none -classpath "${classpath}" \
		tools/gdtbuilder/src/main/java/gdtbuilder/*.java
	classpath="${T}/gdtbuilder:${classpath}"

	local -x JAVA_HOME XDG_CACHE_HOME="${T}/cache" XDG_CONFIG_HOME="${T}/config" XDG_STATE_HOME="${T}/state"
	local -x _JAVA_OPTIONS="-Djava.io.tmpdir=${T} -Djava.awt.headless=true"
	JAVA_HOME="$(java-config -O)" || die
	mkdir -p "${XDG_CACHE_HOME}" "${XDG_CONFIG_HOME}" "${XDG_STATE_HOME}" data/{games,machines} || die

	local gen=machines/generated
	edo java -cp "${classpath}" gdtbuilder.PetsciiCompiler "${gen}/petscii.yaml" data/petscii.map
	edo java -cp "${classpath}" gdtbuilder.ScreencodeCompiler "${gen}/petscii.yaml" \
		"${gen}/screencode.yaml" data/screencode.map
	local yaml name
	for yaml in machines/*.yaml; do
		name=$(basename "${yaml}" .yaml)
		edo java -cp "${classpath}" gdtbuilder.GdtBuilder "${yaml}" "data/machines/${name}.gdt"
		edo java -cp "${classpath}" gdtbuilder.MapCompiler "${yaml}" "data/machines/${name}.map"
	done
	for yaml in machines/games/*.yaml; do
		name=$(basename "${yaml}" .yaml)
		edo java -cp "${classpath}" gdtbuilder.GameCompiler "${yaml}" "data/games/${name}.gmap"
	done

	# RetroCharsetProvider loads the charset maps from the classpath.
	local res="${T}/charset-resources"
	mkdir -p "${res}/retromachines/charset" || die
	cp data/{petscii,screencode}.map "${res}/retromachines/charset/" || die
	jar --update --file "lib/${GHIDRA_EXT_NAME}.jar" -C "${res}" retromachines || die

	# The descriptor fingerprint upstream ships beside them.
	pushd machines >/dev/null || die
	find . -type f -printf '%P\0' | xargs -0 sha256sum | LC_ALL=C sort \
		> ../data/descriptor-sources.sha256 || die
	popd >/dev/null || die
}

src_test() {
	# What upstream's Gradle test task provides.
	local GHIDRA_EXT_TEST_CLASSPATH="${T}/gdtbuilder"
	local -x JAVA_TOOL_OPTIONS="-Dgrm.moduleDir=${S} -Xmx2g"
	# The vector samples are read from the module tree, which the eclass moved
	# the tests out of.
	mkdir -p src || die
	ln -sfn "${WORKDIR}/ghidra-extension-tests" src/test || die
	ghidra-extension_src_test
}

src_install() {
	# Only what upstream's own distribution ships; the rest is repository and
	# build-time material.
	local f
	for f in *; do
		case ${f} in
			data|extension.properties|ghidra_scripts|lib|LICENSE|Module.manifest|NOTICE|README.md) ;;
			*) rm -r "${f}" || die ;;
		esac
	done
	ghidra-extension_src_install
}
