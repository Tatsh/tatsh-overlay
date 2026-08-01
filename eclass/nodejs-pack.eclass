# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: nodejs-pack.eclass
# @MAINTAINER:
# Fco. Javier Félix <web@inode64.com>
# @AUTHOR:
# Fco. Javier Félix <web@inode64.com>
# @SUPPORTED_EAPIS: 8 9
# @BLURB: An eclass for build NodeJS projects
# @DESCRIPTION:
# An eclass providing functions to build NodeJS packages
#
# Credits and ideas from:
#   Initial version from:
#       https://github.com/gentoo/gentoo/pull/930/files
#       https://github.com/samuelbernardo/ssnb-overlay/blob/master/eclass/npm.eclass
#       https://github.com/gentoo-mirror/lanodanOverlay/blob/master/eclass/nodejs.eclass
#       https://github.com/Tatsh/tatsh-overlay/blob/master/eclass/yarn.eclass

if [[ -z ${_NODEJS_PACK_ECLASS} ]]; then
	_NODEJS_PACK_ECLASS=1

case ${EAPI} in
    8|9) ;;
    *) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

inherit nodejs

# shellcheck disable=SC2086
if has nodejs-mod ${INHERITED}; then
    die "nodejs-mod and nodejs-pack eclass are incompatible"
fi

# Upstream does not support stripping nodejs packages
RESTRICT="test strip"

# @FUNCTION: nodejs-pack_src_prepare
# @DESCRIPTION:
# Nodejs preparation phase
nodejs-pack_src_prepare() {
    debug-print-function "${FUNCNAME[0]}" "${@}"

    # Check for package.json existence
    if ! nodejs_has_package && [[ ! -e package.json ]]; then
        eerror "Unable to locate package.json"
        eerror "Consider not inheriting the nodejs-pack eclass."
        die "FATAL: Unable to find package.json"
    fi

    # Check if node and npm/yarn are available
    if ! type -P node >/dev/null; then
        eerror "Node.js is required but not installed or not in PATH"
        die "Node.js not available"
    fi

    case ${NODEJS_MANAGER} in
        npm)
            if ! type -P npm >/dev/null; then
                eerror "npm is required but not installed or not in PATH"
                die "npm not available"
            fi
            ;;
        yarn)
            if ! type -P yarn >/dev/null; then
                eerror "yarn is required but not installed or not in PATH"
                die "yarn not available"
            fi
            ;;
    esac

    default_src_prepare
}

# @FUNCTION: nodejs-pack_src_compile
# @DESCRIPTION:
# General function for compiling a NodeJS module
nodejs-pack_src_compile() {
    debug-print-function "${FUNCNAME[0]}" "${@}"

    einfo "Creating package archive..."

    # Create the package archive
    enpm --global pack || die "package creation failed"
}

# @FUNCTION: nodejs-pack_src_install
# @DESCRIPTION:
# Function for installing the package
nodejs-pack_src_install() {
    debug-print-function "${FUNCNAME[0]}" "${@}"

    nodejs_docs

    # Get the package information
    local package_name package_version package_file module_path
    package_name=$(nodejs_package)
    package_version=$(nodejs_version)
    package_file="${package_name}-${package_version}.tgz"
    module_path=$(nodejs_modules)

    # Verify package file exists
    if [[ ! -f "${package_file}" ]]; then
        die "Package file ${package_file} does not exist"
    fi

    # Install the package
    einfo "Installing package ${package_file}"
    enpm --prefix "${ED}"/usr --global install "${package_file}" || die "package installation failed"

    # Clean up unnecessary files
    if [[ -d "${ED}/${module_path}" ]]; then
        pushd "${ED}/${module_path}" >/dev/null || die "Failed to change to module directory"
        nodejs_remove_dev
        popd >/dev/null || die
    else
        eerror "Module directory ${module_path} not found in ${ED}"
        die "Installation appears to have failed"
    fi
}

fi

EXPORT_FUNCTIONS src_prepare src_compile src_install
