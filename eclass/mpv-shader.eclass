# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: mpv-shader.eclass
# @MAINTAINER:
# Andrew Udvare <audvare@gmail.com>
# @AUTHOR:
# Andrew Udvare <audvare@gmail.com>
# @BLURB: install mpv shaders
# @DESCRIPTION:
# Install MPV shaders to /usr/share/mpv/shaders.

case ${EAPI:-0} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported." ;;
esac

EXPORT_FUNCTIONS src_install pkg_postinst

# @ECLASS_VARIABLE: MPV_REQ_USE
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# The list of USE flags required to be enabled on mpv, formed as a
# USE-dependency string. Default is MPV_REQ_USE=""
#
# Example:
# @CODE@
#
# MPV_REQ_USE="vulkan"
#
# @CODE@

if [[ -z ${_MPV_SHADER_ECLASS} ]]; then
	# @FUNCTION: _mpv-shader_set_globals
	# @INTERNAL
	# @DESCRIPTION:
	# Sets globals for an mpv shader ebuild.
	_mpv-shader_set_globals() {
		local mpv_pkg_dep
		mpv_pkg_dep="media-video/mpv"
		if [ "${MPV_REQ_USE}" ]; then
			mpv_pkg_dep+="[${MPV_REQ_USE}]"
		fi
		# shellcheck disable=SC2034
		SLOT="0"
		# shellcheck disable=SC2034
		RDEPEND="${mpv_pkg_dep}"
	}
	_mpv-shader_set_globals

	# @FUNCTION: mpv-shader_src_install
	# @USAGE:
	# @DESCRIPTION:
	# Install the specified files in ${D}.
	# The ebuild must specify the file list in the MPV_SHADER_FILES array.
	mpv-shader_src_install() {
		if [[ ! ${MPV_SHADER_FILES} ]]; then
			die "${ECLASS}: no files specified in MPV_PLUGIN_FILES, cannot install"
		fi
		insinto /usr/share/mpv/shaders
		for f in "${MPV_SHADER_FILES[@]}"; do
			doins "${f}"
		done
		einstalldocs
	}

	# @FUNCTION: mpv-shader_pkg_postinst
	# @USAGE:
	# @DESCRIPTION:
	# Display a message about how to use the shaders.
	mpv-shader_pkg_postinst() {
		elog
		elog "To use the shader, specify --glsl-shader=<PATH> or use the option"
		elog "in the configuration file."
		elog
	}

	_MPV_SHADER_ECLASS=1
fi
