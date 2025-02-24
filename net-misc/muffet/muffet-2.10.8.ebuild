# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/andybalholm/brotli v1.1.1"
	"github.com/andybalholm/brotli v1.1.1/go.mod"
	"github.com/benbjohnson/clock v1.3.0"
	"github.com/benbjohnson/clock v1.3.0/go.mod"
	"github.com/bradleyjkemp/cupaloy v2.3.0+incompatible"
	"github.com/bradleyjkemp/cupaloy v2.3.0+incompatible/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/jessevdk/go-flags v1.6.1"
	"github.com/jessevdk/go-flags v1.6.1/go.mod"
	"github.com/klauspost/compress v1.17.11"
	"github.com/klauspost/compress v1.17.11/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/logrusorgru/aurora/v3 v3.0.0"
	"github.com/logrusorgru/aurora/v3 v3.0.0/go.mod"
	"github.com/mattn/go-colorable v0.1.14"
	"github.com/mattn/go-colorable v0.1.14/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/oxffaa/gopher-parse-sitemap v0.0.0-20191021113419-005d2eb1def4"
	"github.com/oxffaa/gopher-parse-sitemap v0.0.0-20191021113419-005d2eb1def4/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/temoto/robotstxt v1.1.2"
	"github.com/temoto/robotstxt v1.1.2/go.mod"
	"github.com/valyala/bytebufferpool v1.0.0"
	"github.com/valyala/bytebufferpool v1.0.0/go.mod"
	"github.com/valyala/fasthttp v1.58.0"
	"github.com/valyala/fasthttp v1.58.0/go.mod"
	"github.com/xyproto/randomstring v1.0.5"
	"github.com/xyproto/randomstring v1.0.5/go.mod"
	"github.com/yhat/scrape v0.0.0-20161128144610-24b7890b0945"
	"github.com/yhat/scrape v0.0.0-20161128144610-24b7890b0945/go.mod"
	"go.uber.org/atomic v1.7.0"
	"go.uber.org/atomic v1.7.0/go.mod"
	"go.uber.org/ratelimit v0.3.1"
	"go.uber.org/ratelimit v0.3.1/go.mod"
	"golang.org/x/net v0.34.0"
	"golang.org/x/net v0.34.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.29.0"
	"golang.org/x/sys v0.29.0/go.mod"
	"golang.org/x/text v0.21.0"
	"golang.org/x/text v0.21.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

DESCRIPTION="Fast website link checker in Go"
HOMEPAGE="https://github.com/raviqqe/muffet"
SRC_URI="https://github.com/raviqqe/muffet/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	go build . || die
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
