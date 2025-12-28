#!/usr/bin/env bash
set -euo pipefail
workspace="${1}"
sudo apt-get -qq update
sudo apt-get -y install build-essential curl wget
curl -fsSL \
	https://gitweb.gentoo.org/repo/proj/prefix.git/plain/scripts/bootstrap-prefix.sh \
	-o bootstrap-prefix.sh
chmod +x bootstrap-prefix.sh
export LATEST_TREE_YES=1 \
	EMERGE_DEFAULT_OPTS="--jobs 1 --quiet-build=y" \
	ACCEPT_KEYWORDS="~amd64" \
	ACCEPT_LICENSE="*" \
	FEATURES="clean-logs"
bash bootstrap-prefix.sh "${workspace}/gentoo" noninteractive
# shellcheck disable=SC1091
. "${workspace}/gentoo/etc/profile"
mkdir -p "${workspace}/gentoo/etc/portage/repos.conf"
emerge -v --ask=n dev-util/pkgcheck dev-python/requests
cat > "${workspace}"/gentoo/etc/portage/repos.conf/guru.conf <<EOF
[guru]
location = ${workspace}/gentoo/var/db/repos/guru
sync-type = git
sync-uri = https://github.com/gentoo-mirror/guru.git
EOF
cat > "${workspace}"/gentoo/etc/portage/repos.conf/gentoo.conf <<EOF
[DEFAULT]
main-repo = gentoo
[gentoo]
location = ${workspace}/gentoo/var/db/repos/gentoo
sync-type = rsync
sync-uri = rsync://rsync.gentoo.org/gentoo-portage
auto-sync = yes
EOF
emerge --sync
cat > "${workspace}"/gentoo/etc/portage/repos.conf/tatsh-overlay.conf <<EOF
[tatsh-overlay]
location = ${workspace}
EOF
