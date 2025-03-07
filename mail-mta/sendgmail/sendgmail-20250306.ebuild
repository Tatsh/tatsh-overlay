# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"cloud.google.com/go/compute v1.23.3"
	"cloud.google.com/go/compute v1.23.3/go.mod"
	"cloud.google.com/go/compute/metadata v0.2.3"
	"cloud.google.com/go/compute/metadata v0.2.3/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.2/go.mod"
	"github.com/golang/protobuf v1.5.3"
	"github.com/golang/protobuf v1.5.3/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/uuid v1.4.0"
	"github.com/google/uuid v1.4.0/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/oauth2 v0.14.0"
	"golang.org/x/oauth2 v0.14.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/appengine v1.6.8"
	"google.golang.org/appengine v1.6.8/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.33.0"
	"google.golang.org/protobuf v1.33.0/go.mod"
)

go-module_set_globals

DESCRIPTION="Tool that uses Gmail in order to mimic sendmail for 'git send-email'."
HOMEPAGE="https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail"
SHA="85c6b4f07e637683cc5e0ec6a66ce8e4397a4b18"
SRC_URI="https://github.com/google/gmail-oauth2-tools/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/gmail-oauth2-tools-${SHA}/go/${PN}"

src_compile() {
	go build -o "${PN}" || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
