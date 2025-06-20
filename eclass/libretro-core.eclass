# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: libretro-core.eclass
# @MAINTAINER:
# leycec@gmail.com
# @AUTHOR:
# Original author: Cecil Curry
# @BLURB: An eclass to streamline the construction of Libretro core ebuilds
# @DESCRIPTION:
# The libretro eclass is designed to streamline the construction of
# ebuilds for low-level Libretro core ebuilds.

inherit flag-o-matic libretro

IUSE+="custom-cflags debug"

# @ECLASS-VARIABLE: LIBRETRO_CORE_NAME
# @DESCRIPTION:
# Name of this Libretro core. The libretro-core_src_install() phase function
# will install the shared library "${S}/${LIBRETRO_CORE_NAME}_libretro.so" as a
# Libretro core. Defaults to the name of the current package excluding the
# "-libretro" suffix and replacing dashes by underlines (e.g., "foo_bar" for
# the package "foo-bar-libretro").
PN_UNDERLINES=${PN//-/_}
: ${LIBRETRO_CORE_NAME:=${PN_UNDERLINES%_libretro}}

# @ECLASS-VARIABLE: LIBRETRO_CORE_LIB_FILE
# @DESCRIPTION:
# Absolute path of this Libretro core's shared library. Defaults to
# "${S}/${LIBRETRO_CORE_NAME}_libretro.so".
LIBRETRO_CORE_LIB_FILE=

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install

# @FUNCTION: libretro-core_src_unpack
# @DESCRIPTION:
# The libretro-core src_unpack function which is exported.
#
# This function retrieves the remote Libretro core info files.
libretro-core_src_unpack() {
	# If this is a live ebuild, retrieve this core's remote repository.
	if [[ ${PV} = 9999 ]]; then
		git-r3_src_unpack
		# Add used commit SHA for version information, the above could also work. Needs proper testing with all cores
		LIBRETRO_COMMIT_SHA=$(git -C "${EGIT3_STORE_DIR}/${LIBRETRO_REPO_NAME//\//_}.git" rev-parse HEAD)
	# Else, unpack this core's local tarball.
	else
		default_src_unpack
	fi

	# Absolute path of this Libretro core's shared library, deferred until the
	# child ebuild has had the opportunity to redefine ${LIBRETRO_CORE_NAME}
	[[ -n "${LIBRETRO_CORE_LIB_FILE}" ]] ||
		LIBRETRO_CORE_LIB_FILE=()
		for i in "${LIBRETRO_CORE_NAME[@]}"
		do
			LIBRETRO_CORE_LIB_FILE+=( "${S}/${i}"_libretro.so )
		done

}

# @FUNCTION: libretro-core_src_prepare
# @DESCRIPTION:
# The libretro-core src_prepare function which is exported.
#
# This function prepares the source by making custom modifications.
libretro-core_src_prepare() {
	if use custom-cflags; then
		local flags_modified=0
		ebegin "Attempting to hack Makefiles to use custom-cflags"
		for makefile in "${S}"/?akefile* "${S}"/target-libretro/?akefile*; do
			# * Convert CRLF to LF
			# * Expand *FLAGS to prevent potential self-references
			# * Where LDFLAGS directly define the link version 
			#   script append LDFLAGS and LIBS
			# * Where SHARED is used to provide shared linking
			#   flags ensure final link command includes LDFLAGS
			#   and LIBS
			# * Always use $(CFLAGS) when calling $(CC)
			sed \
				-e 's/\r$//g' \
				-e "/flags.*=/s/-O[[:digit:]]/${CFLAGS}/g" \
				-e "/CFLAGS.*=/s/-O[[:digit:]]/${CFLAGS}/g" \
				-e "/.*,--version-script=.*/s/$/ ${LDFLAGS} ${LIBS}/g" \
				-e "/\$(CC)/s/\(\$(SHARED)\)/\1 ${LDFLAGS} ${LIBS}/" \
				-e 's/\(\$(CC)\)/\1 \$(CFLAGS)/g' \
				-i "${makefile}" \
				&> /dev/null && flags_modified=1
		done
		[[ ${flags_modified} == 1 ]] && true || false
		eend $?
		export OPTFLAGS="${CFLAGS}"
	fi

	# Populate COMMIT for GIT_VERSION
	if [[ -z "${CUSTOM_LIBRETRO_COMMIT_SHA}" ]]; then
		CUSTOM_LIBRETRO_COMMIT_SHA="\" ${LIBRETRO_COMMIT_SHA:0:7}\""
	fi

	for makefile in "${S}"/?akefile* "${S}"/target-libretro/?akefile*; do
		# Add short-rev to Makefile
		sed \
			-e "s/GIT_VERSION\s.=.*$/GIT_VERSION=${CUSTOM_LIBRETRO_COMMIT_SHA}/g" \
			-i "${makefile}" \
			&> /dev/null
	done
	default_src_prepare
}

# @FUNCTION: libretro-core_src_compile
# @DESCRIPTION:
# The libretro-core src_compile function which is exported.
#
# This function compiles the shared library for this Libretro core.
libretro-core_src_compile() {
	use custom-cflags || filter-flags -O*
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) \
		$(usex debug "DEBUG=1" "") "${myemakeargs[@]}" \
		$([ -f makefile.libretro ] && echo '-f makefile.libretro') \
		$([ -f Makefile.libretro ] && echo '-f Makefile.libretro')
}

# @FUNCTION: libretro-core_src_install
# @DESCRIPTION:
# The libretro-core src_install function which is exported.
#
# This function installs the shared library for this Libretro core.
libretro-core_src_install() {
	# Absolute path of the directory containing Libretro shared libraries.
	LIBRETRO_LIB_DIR="${EROOT%/}/usr/$(get_libdir)/libretro"
	# If this core's shared library exists, install that.
	for i in "${LIBRETRO_CORE_LIB_FILE[@]}"
	do
		if [[ -f "${i}" ]]; then
			insinto "${LIBRETRO_LIB_DIR}"
			doins "${i}"
		else
			# Basename of this library.
			local lib_basename="${i##*/}"

			# Absolute path to which this library was installed.
			local lib_file_target="${ED}/${LIBRETRO_LIB_DIR}/${lib_basename}"

			# If this library was *NOT* installed, fail.
			[[ -f "${lib_file_target}" ]] ||
				die "Libretro core shared library \"${lib_file_target}\" not installed."
		fi
	done
}

