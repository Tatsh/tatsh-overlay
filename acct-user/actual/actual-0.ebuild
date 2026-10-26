# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for www-apps/actual-server"
ACCT_USER_ID=605
ACCT_USER_GROUPS=( actual )
ACCT_USER_HOME=/var/lib/actual

acct-user_add_deps
