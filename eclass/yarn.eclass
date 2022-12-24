# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: mpv-shader.eclass
# @MAINTAINER:
# Andrew Udvare <audvare@gmail.com>
# @AUTHOR:
# Andrew Udvare <audvare@gmail.com>
# @BLURB: Install a Node based package offline with Yarn.
# @DESCRIPTION:

case ${EAPI:-0} in
8) ;;
*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported." ;;
esac

EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_install

if [[ ! ${_YARN_ECLASS} ]]; then
	_yarn_set_globals() {
		# shellcheck disable=SC2034
		BDEPEND="sys-apps/yarn dev-util/node-gyp"
		# shellcheck disable=SC2034
		RDEPEND="net-libs/nodejs:="
		# shellcheck disable=SC2034
		RESTRICT="strip"
		# shellcheck disable=SC2034
		SLOT="0"
	}
	_yarn_set_globals

	yarn_uris() {
		local -r regex='^(@[a-zA-Z0-9_-]+/)?([a-zA-Z0-9\._-]+)-([0-9]+\.[0-9]+\.[0-9]+.*)'
		if [[ -z ${YARN_PKGS} ]]; then
			eerror "YARN_PKGS variable is not defined"
			die "Can't generate SRC_URI from empty input"
		fi
		for pkg in ${YARN_PKGS}; do
			local name version url prefix
			[[ $pkg =~ $regex ]] || die "Could not parse name and version from spec: $pkg"
			scope="${BASH_REMATCH[1]}"
			name="${BASH_REMATCH[2]}"
			version="${BASH_REMATCH[3]}"
			prefix=
			if [ -n "$scope" ]; then
				prefix="-${scope/\//}"
			fi
			echo "https://registry.yarnpkg.com/${scope}${name}/-/${name}-${version}.tgz -> node${prefix}-${name}-${version}.tgz"
		done
	}

	yarn_src_unpack() {
		local archive
		for archive in ${A}; do
			case "${archive}" in
			*.tgz) ;;

			*)
				unpack "${archive}"
				;;
			esac
		done
	}

	yarn_src_prepare() {
		mkdir lib packages || die
		local file bn
		for file in "${DISTDIR}"/node-*.tgz; do
			bn=$(basename "$file")
			ln -s "${file}" "packages/${bn:5}" || die
		done
		default
	}

	yarn_src_configure() {
		yarn config set prefix "${HOME}/.node" || die
		yarn config set yarn-offline-mirror "$(realpath "${WORKDIR}/packages")" || die
	}

	yarn_src_compile() {
		cd lib || die
		cp "${YARN_PACKAGE_JSON:-${FILESDIR}/${PN}-package.json}" package.json || die
		cp "${YARN_LOCK:-${FILESDIR}/${PN}-yarn.lock}" yarn.lock || die
		env \
			"npm_config_jobs=$(makeopts_jobs)" \
			npm_config_verbose=true \
			npm_config_release=true \
			"npm_config_nodedir=${EPREFIX}/usr/include/node" \
			yarn install --production --offline --verbose --no-progress \
			--non-interactive --build-from-source || die
		rm -fR node_modules/@serialport/bindings-cpp/prebuilds/{darwin,android,win32,linux-arm}* \
			node_modules/@serialport/bindings-cpp/prebuilds/linux-x64/*musl.node \
			package.json || die
		find . -type d -empty -delete || die
		find . -type f '(' -name '*.ts*' -o -name '*.map' -o -iname '*.md' ')' -delete || die
		find . -type f -iname 'license*' -exec bzip2 {} \; || die
	}

	yarn_src_install() {
		insinto "/usr/$(get_libdir)/${PN}/node_modules"
		doins -r lib/node_modules/*
		einstalldocs
	}
	_YARN_ECLASS=1
fi
