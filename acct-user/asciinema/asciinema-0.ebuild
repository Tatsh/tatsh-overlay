# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for asciinema-server"
ACCT_USER_ID=602
ACCT_USER_GROUPS=( asciinema )
ACCT_USER_HOME=/var/lib/asciinema-server

acct-user_add_deps
