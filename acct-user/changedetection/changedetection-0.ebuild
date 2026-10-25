# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for www-apps/changedetection-io"
ACCT_USER_ID=604
ACCT_USER_GROUPS=( changedetection )
ACCT_USER_HOME=/var/lib/changedetection

acct-user_add_deps
