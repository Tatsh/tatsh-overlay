# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"codeberg.org/Codeberg/avatars v1.0.0"
	"codeberg.org/Codeberg/avatars v1.0.0/go.mod"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/BurntSushi/toml v1.2.1"
	"github.com/BurntSushi/toml v1.2.1/go.mod"
	"github.com/KyleBanks/depth v1.2.1"
	"github.com/KyleBanks/depth v1.2.1/go.mod"
	"github.com/chzyer/logex v1.2.0/go.mod"
	"github.com/chzyer/readline v1.5.0/go.mod"
	"github.com/chzyer/test v0.0.0-20210722231415-061457976a23/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/duke-git/lancet/v2 v2.1.13"
	"github.com/duke-git/lancet/v2 v2.1.13/go.mod"
	"github.com/dustin/go-humanize v1.0.0/go.mod"
	"github.com/dustin/go-humanize v1.0.1"
	"github.com/dustin/go-humanize v1.0.1/go.mod"
	"github.com/emersion/go-sasl v0.0.0-20200509203442-7bfe0ed36a21/go.mod"
	"github.com/emersion/go-sasl v0.0.0-20220912192320-0145f2c60ead"
	"github.com/emersion/go-sasl v0.0.0-20220912192320-0145f2c60ead/go.mod"
	"github.com/emersion/go-smtp v0.16.0"
	"github.com/emersion/go-smtp v0.16.0/go.mod"
	"github.com/emvi/logbuch v1.2.0"
	"github.com/emvi/logbuch v1.2.0/go.mod"
	"github.com/getsentry/sentry-go v0.17.0"
	"github.com/getsentry/sentry-go v0.17.0/go.mod"
	"github.com/glebarez/go-sqlite v1.20.0"
	"github.com/glebarez/go-sqlite v1.20.0/go.mod"
	"github.com/glebarez/sqlite v1.6.0"
	"github.com/glebarez/sqlite v1.6.0/go.mod"
	"github.com/go-chi/chi/v5 v5.0.8"
	"github.com/go-chi/chi/v5 v5.0.8/go.mod"
	"github.com/go-errors/errors v1.4.2"
	"github.com/go-openapi/jsonpointer v0.19.3/go.mod"
	"github.com/go-openapi/jsonpointer v0.19.5/go.mod"
	"github.com/go-openapi/jsonpointer v0.19.6"
	"github.com/go-openapi/jsonpointer v0.19.6/go.mod"
	"github.com/go-openapi/jsonreference v0.20.0/go.mod"
	"github.com/go-openapi/jsonreference v0.20.2"
	"github.com/go-openapi/jsonreference v0.20.2/go.mod"
	"github.com/go-openapi/spec v0.20.8"
	"github.com/go-openapi/spec v0.20.8/go.mod"
	"github.com/go-openapi/swag v0.19.5/go.mod"
	"github.com/go-openapi/swag v0.19.15/go.mod"
	"github.com/go-openapi/swag v0.22.3"
	"github.com/go-openapi/swag v0.22.3/go.mod"
	"github.com/go-sql-driver/mysql v1.7.0"
	"github.com/go-sql-driver/mysql v1.7.0/go.mod"
	"github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0"
	"github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0/go.mod"
	"github.com/google/go-cmp v0.5.3/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/pprof v0.0.0-20221118152302-e6195bd50e26/go.mod"
	"github.com/google/uuid v1.3.0"
	"github.com/google/uuid v1.3.0/go.mod"
	"github.com/gorilla/schema v1.2.0"
	"github.com/gorilla/schema v1.2.0/go.mod"
	"github.com/gorilla/securecookie v1.1.1"
	"github.com/gorilla/securecookie v1.1.1/go.mod"
	"github.com/gorilla/sessions v1.2.1"
	"github.com/gorilla/sessions v1.2.1/go.mod"
	"github.com/hashicorp/golang-lru v0.5.4"
	"github.com/hashicorp/golang-lru v0.5.4/go.mod"
	"github.com/ianlancetaylor/demangle v0.0.0-20220319035150-800ac71e25c2/go.mod"
	"github.com/jackc/pgpassfile v1.0.0"
	"github.com/jackc/pgpassfile v1.0.0/go.mod"
	"github.com/jackc/pgservicefile v0.0.0-20200714003250-2b9c44734f2b/go.mod"
	"github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a"
	"github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a/go.mod"
	"github.com/jackc/pgx/v5 v5.2.0"
	"github.com/jackc/pgx/v5 v5.2.0/go.mod"
	"github.com/jackc/puddle/v2 v2.1.2/go.mod"
	"github.com/jinzhu/configor v1.2.1"
	"github.com/jinzhu/configor v1.2.1/go.mod"
	"github.com/jinzhu/inflection v1.0.0"
	"github.com/jinzhu/inflection v1.0.0/go.mod"
	"github.com/jinzhu/now v1.1.4/go.mod"
	"github.com/jinzhu/now v1.1.5"
	"github.com/jinzhu/now v1.1.5/go.mod"
	"github.com/josharian/intern v1.0.0"
	"github.com/josharian/intern v1.0.0/go.mod"
	"github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51/go.mod"
	"github.com/kevinpollet/nego v0.0.0-20211010160919-a65cd48cee43"
	"github.com/kevinpollet/nego v0.0.0-20211010160919-a65cd48cee43/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pretty v0.2.1/go.mod"
	"github.com/kr/pretty v0.3.0"
	"github.com/kr/pretty v0.3.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/leandro-lugaresi/hub v1.1.1"
	"github.com/leandro-lugaresi/hub v1.1.1/go.mod"
	"github.com/lpar/gzipped/v2 v2.1.0"
	"github.com/lpar/gzipped/v2 v2.1.0/go.mod"
	"github.com/mailru/easyjson v0.0.0-20190614124828-94de47d64c63/go.mod"
	"github.com/mailru/easyjson v0.0.0-20190626092158-b2ccc519800e/go.mod"
	"github.com/mailru/easyjson v0.7.6/go.mod"
	"github.com/mailru/easyjson v0.7.7"
	"github.com/mailru/easyjson v0.7.7/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.17"
	"github.com/mattn/go-isatty v0.0.17/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.15/go.mod"
	"github.com/mattn/go-sqlite3 v2.0.3+incompatible"
	"github.com/mattn/go-sqlite3 v2.0.3+incompatible/go.mod"
	"github.com/mitchellh/hashstructure/v2 v2.0.2"
	"github.com/mitchellh/hashstructure/v2 v2.0.2/go.mod"
	"github.com/muety/artifex/v2 v2.0.1-0.20221201142708-74e7d3f6feaf"
	"github.com/muety/artifex/v2 v2.0.1-0.20221201142708-74e7d3f6feaf/go.mod"
	"github.com/narqo/go-badge v0.0.0-20221212191103-ba83bed45a1a"
	"github.com/narqo/go-badge v0.0.0-20221212191103-ba83bed45a1a/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/patrickmn/go-cache v2.1.0+incompatible"
	"github.com/patrickmn/go-cache v2.1.0+incompatible/go.mod"
	"github.com/pingcap/errors v0.11.4"
	"github.com/pkg/errors v0.9.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/remyoudompheng/bigfft v0.0.0-20200410134404-eec4a21b6bb0/go.mod"
	"github.com/remyoudompheng/bigfft v0.0.0-20230126093431-47fa9a501578"
	"github.com/remyoudompheng/bigfft v0.0.0-20230126093431-47fa9a501578/go.mod"
	"github.com/robfig/cron/v3 v3.0.1"
	"github.com/robfig/cron/v3 v3.0.1/go.mod"
	"github.com/rogpeppe/go-internal v1.6.1"
	"github.com/rogpeppe/go-internal v1.6.1/go.mod"
	"github.com/satori/go.uuid v1.2.0"
	"github.com/satori/go.uuid v1.2.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.1"
	"github.com/stretchr/testify v1.8.1/go.mod"
	"github.com/stripe/stripe-go/v74 v74.6.0"
	"github.com/stripe/stripe-go/v74 v74.6.0/go.mod"
	"github.com/swaggo/files v1.0.0"
	"github.com/swaggo/files v1.0.0/go.mod"
	"github.com/swaggo/http-swagger v1.3.3"
	"github.com/swaggo/http-swagger v1.3.3/go.mod"
	"github.com/swaggo/swag v1.8.10"
	"github.com/swaggo/swag v1.8.10/go.mod"
	"github.com/yuin/goldmark v1.2.1/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.uber.org/atomic v1.10.0"
	"go.uber.org/atomic v1.10.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.0.0-20220829220503-c86fa9a7ed90/go.mod"
	"golang.org/x/crypto v0.4.0/go.mod"
	"golang.org/x/crypto v0.5.0"
	"golang.org/x/crypto v0.5.0/go.mod"
	"golang.org/x/exp v0.0.0-20230125214544-b3c2aaf6208d"
	"golang.org/x/exp v0.0.0-20230125214544-b3c2aaf6208d/go.mod"
	"golang.org/x/image v0.3.0"
	"golang.org/x/image v0.3.0/go.mod"
	"golang.org/x/mod v0.3.0/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.7.0"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20200324143707-d3edc9973b7e/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.2.0/go.mod"
	"golang.org/x/net v0.3.0/go.mod"
	"golang.org/x/net v0.5.0"
	"golang.org/x/net v0.5.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.0.0-20220923202941-7f9b1623fab7/go.mod"
	"golang.org/x/sync v0.1.0"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220310020820-b874c991c1a5/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.2.0/go.mod"
	"golang.org/x/sys v0.3.0/go.mod"
	"golang.org/x/sys v0.4.0"
	"golang.org/x/sys v0.4.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.2.0/go.mod"
	"golang.org/x/term v0.3.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/text v0.4.0/go.mod"
	"golang.org/x/text v0.5.0/go.mod"
	"golang.org/x/text v0.6.0"
	"golang.org/x/text v0.6.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20201124115921-2c860bdd6e78/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.5.0"
	"golang.org/x/tools v0.5.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/errgo.v2 v2.1.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200615113413-eeeca48fe776/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"gorm.io/driver/mysql v1.4.5"
	"gorm.io/driver/mysql v1.4.5/go.mod"
	"gorm.io/driver/postgres v1.4.6"
	"gorm.io/driver/postgres v1.4.6/go.mod"
	"gorm.io/driver/sqlite v1.4.4"
	"gorm.io/driver/sqlite v1.4.4/go.mod"
	"gorm.io/gorm v1.23.8/go.mod"
	"gorm.io/gorm v1.24.0/go.mod"
	"gorm.io/gorm v1.24.2/go.mod"
	"gorm.io/gorm v1.24.3"
	"gorm.io/gorm v1.24.3/go.mod"
	"lukechampine.com/uint128 v1.1.1/go.mod"
	"lukechampine.com/uint128 v1.2.0/go.mod"
	"modernc.org/cc/v3 v3.37.0/go.mod"
	"modernc.org/cc/v3 v3.38.1/go.mod"
	"modernc.org/cc/v3 v3.40.0/go.mod"
	"modernc.org/ccgo/v3 v3.0.0-20220904174949-82d86e1b6d56/go.mod"
	"modernc.org/ccgo/v3 v3.0.0-20220910160915-348f15de615a/go.mod"
	"modernc.org/ccgo/v3 v3.16.13-0.20221017192402-261537637ce8/go.mod"
	"modernc.org/ccgo/v3 v3.16.13/go.mod"
	"modernc.org/ccorpus v1.11.6/go.mod"
	"modernc.org/httpfs v1.0.6/go.mod"
	"modernc.org/libc v1.17.4/go.mod"
	"modernc.org/libc v1.18.0/go.mod"
	"modernc.org/libc v1.19.0/go.mod"
	"modernc.org/libc v1.20.3/go.mod"
	"modernc.org/libc v1.21.4/go.mod"
	"modernc.org/libc v1.21.5/go.mod"
	"modernc.org/libc v1.22.2"
	"modernc.org/libc v1.22.2/go.mod"
	"modernc.org/mathutil v1.5.0"
	"modernc.org/mathutil v1.5.0/go.mod"
	"modernc.org/memory v1.3.0/go.mod"
	"modernc.org/memory v1.4.0/go.mod"
	"modernc.org/memory v1.5.0"
	"modernc.org/memory v1.5.0/go.mod"
	"modernc.org/opt v0.1.1/go.mod"
	"modernc.org/opt v0.1.3/go.mod"
	"modernc.org/sqlite v1.20.0/go.mod"
	"modernc.org/sqlite v1.20.3"
	"modernc.org/sqlite v1.20.3/go.mod"
	"modernc.org/strutil v1.1.3/go.mod"
	"modernc.org/tcl v1.15.0/go.mod"
	"modernc.org/token v1.0.1/go.mod"
	"modernc.org/z v1.7.0/go.mod"
)

go-module_set_globals

DESCRIPTION="A minimalist, self-hosted WakaTime-compatible backend for coding statistics"
HOMEPAGE="https://wakapi.dev/ https://github.com/muety/wakapi"
SRC_URI="https://github.com/muety/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND=">=dev-lang/go-1.18 app-arch/unzip"

src_compile() {
	go build -o "${PN}"
}

src_install() {
	dobin "${PN}"
	insinto /etc/"${PN}"
	newins config.default.yml config.yml
}

src_test() {
	env CGO_ENABLED=0 go test "$(go list ./... | grep -v 'github.com/muety/wakapi/scripts')" \
		-run ./...
}