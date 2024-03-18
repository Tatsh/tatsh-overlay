# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module yarn

EGO_SUM=(
	"cloud.google.com/go v0.26.0/go.mod"
	"cloud.google.com/go v0.34.0/go.mod"
	"cloud.google.com/go v0.38.0/go.mod"
	"cloud.google.com/go v0.44.1/go.mod"
	"cloud.google.com/go v0.44.2/go.mod"
	"cloud.google.com/go v0.44.3/go.mod"
	"cloud.google.com/go v0.45.1/go.mod"
	"cloud.google.com/go v0.46.3/go.mod"
	"cloud.google.com/go v0.50.0/go.mod"
	"cloud.google.com/go v0.52.0/go.mod"
	"cloud.google.com/go v0.53.0/go.mod"
	"cloud.google.com/go v0.54.0/go.mod"
	"cloud.google.com/go v0.56.0/go.mod"
	"cloud.google.com/go v0.57.0/go.mod"
	"cloud.google.com/go v0.62.0/go.mod"
	"cloud.google.com/go v0.65.0/go.mod"
	"cloud.google.com/go v0.72.0/go.mod"
	"cloud.google.com/go v0.74.0/go.mod"
	"cloud.google.com/go v0.75.0/go.mod"
	"cloud.google.com/go v0.78.0/go.mod"
	"cloud.google.com/go v0.79.0/go.mod"
	"cloud.google.com/go v0.81.0/go.mod"
	"cloud.google.com/go v0.83.0/go.mod"
	"cloud.google.com/go v0.84.0/go.mod"
	"cloud.google.com/go v0.87.0/go.mod"
	"cloud.google.com/go v0.90.0/go.mod"
	"cloud.google.com/go v0.93.3/go.mod"
	"cloud.google.com/go v0.94.1/go.mod"
	"cloud.google.com/go v0.97.0/go.mod"
	"cloud.google.com/go v0.98.0/go.mod"
	"cloud.google.com/go v0.99.0/go.mod"
	"cloud.google.com/go/bigquery v1.0.1/go.mod"
	"cloud.google.com/go/bigquery v1.3.0/go.mod"
	"cloud.google.com/go/bigquery v1.4.0/go.mod"
	"cloud.google.com/go/bigquery v1.5.0/go.mod"
	"cloud.google.com/go/bigquery v1.7.0/go.mod"
	"cloud.google.com/go/bigquery v1.8.0/go.mod"
	"cloud.google.com/go/datastore v1.0.0/go.mod"
	"cloud.google.com/go/datastore v1.1.0/go.mod"
	"cloud.google.com/go/firestore v1.6.1/go.mod"
	"cloud.google.com/go/pubsub v1.0.1/go.mod"
	"cloud.google.com/go/pubsub v1.1.0/go.mod"
	"cloud.google.com/go/pubsub v1.2.0/go.mod"
	"cloud.google.com/go/pubsub v1.3.1/go.mod"
	"cloud.google.com/go/storage v1.0.0/go.mod"
	"cloud.google.com/go/storage v1.5.0/go.mod"
	"cloud.google.com/go/storage v1.6.0/go.mod"
	"cloud.google.com/go/storage v1.8.0/go.mod"
	"cloud.google.com/go/storage v1.10.0/go.mod"
	"cloud.google.com/go/storage v1.14.0/go.mod"
	"dmitri.shuralyov.com/gpu/mtl v0.0.0-20190408044501-666a987793e9/go.mod"
	"github.com/99designs/gqlgen v0.17.2"
	"github.com/99designs/gqlgen v0.17.2/go.mod"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/BurntSushi/xgb v0.0.0-20160522181843-27f122750802/go.mod"
	"github.com/DATA-DOG/go-sqlmock v1.5.0"
	"github.com/DATA-DOG/go-sqlmock v1.5.0/go.mod"
	"github.com/DataDog/datadog-go v3.2.0+incompatible/go.mod"
	"github.com/OneOfOne/xxhash v1.2.2/go.mod"
	"github.com/RoaringBitmap/roaring v0.4.7/go.mod"
	"github.com/WithoutPants/sortorder v0.0.0-20230616003020-921c9ef69552"
	"github.com/WithoutPants/sortorder v0.0.0-20230616003020-921c9ef69552/go.mod"
	"github.com/Yamashou/gqlgenc v0.0.6"
	"github.com/Yamashou/gqlgenc v0.0.6/go.mod"
	"github.com/agnivade/levenshtein v1.0.1/go.mod"
	"github.com/agnivade/levenshtein v1.1.0/go.mod"
	"github.com/agnivade/levenshtein v1.1.1"
	"github.com/agnivade/levenshtein v1.1.1/go.mod"
	"github.com/alecthomas/template v0.0.0-20160405071501-a0175ee3bccc/go.mod"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod"
	"github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf/go.mod"
	"github.com/alecthomas/units v0.0.0-20190717042225-c3de453c63f4/go.mod"
	"github.com/anacrolix/dms v1.2.2"
	"github.com/anacrolix/dms v1.2.2/go.mod"
	"github.com/anacrolix/envpprof v0.0.0-20180404065416-323002cec2fa/go.mod"
	"github.com/anacrolix/envpprof v1.0.0/go.mod"
	"github.com/anacrolix/ffprobe v1.0.0/go.mod"
	"github.com/anacrolix/missinggo v1.1.0/go.mod"
	"github.com/anacrolix/tagflag v0.0.0-20180109131632-2146c8d41bf0/go.mod"
	"github.com/andreyvit/diff v0.0.0-20170406064948-c7f18ee00883"
	"github.com/andreyvit/diff v0.0.0-20170406064948-c7f18ee00883/go.mod"
	"github.com/andybalholm/brotli v1.0.5"
	"github.com/antchfx/htmlquery v1.3.0"
	"github.com/antchfx/htmlquery v1.3.0/go.mod"
	"github.com/antchfx/xpath v1.2.3"
	"github.com/antchfx/xpath v1.2.3/go.mod"
	"github.com/antihax/optional v1.0.0/go.mod"
	"github.com/arbovm/levenshtein v0.0.0-20160628152529-48b4e1c0c4d0"
	"github.com/arbovm/levenshtein v0.0.0-20160628152529-48b4e1c0c4d0/go.mod"
	"github.com/armon/circbuf v0.0.0-20150827004946-bbbad097214e/go.mod"
	"github.com/armon/go-metrics v0.0.0-20180917152333-f0300d1749da/go.mod"
	"github.com/armon/go-metrics v0.3.10/go.mod"
	"github.com/armon/go-radix v0.0.0-20180808171621-7fddfc383310/go.mod"
	"github.com/armon/go-radix v1.0.0/go.mod"
	"github.com/asticode/go-astikit v0.20.0"
	"github.com/asticode/go-astikit v0.20.0/go.mod"
	"github.com/asticode/go-astisub v0.25.1"
	"github.com/asticode/go-astisub v0.25.1/go.mod"
	"github.com/asticode/go-astisub v0.26.0"
	"github.com/asticode/go-astisub v0.26.0/go.mod"
	"github.com/asticode/go-astisub v0.26.2"
	"github.com/asticode/go-astisub v0.26.2/go.mod"
	"github.com/asticode/go-astits v1.8.0"
	"github.com/asticode/go-astits v1.8.0/go.mod"
	"github.com/beorn7/perks v0.0.0-20180321164747-3a771d992973/go.mod"
	"github.com/beorn7/perks v1.0.0/go.mod"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/bgentry/speakeasy v0.1.0/go.mod"
	"github.com/bool64/dev v0.2.28"
	"github.com/bradfitz/iter v0.0.0-20140124041915-454541ec3da2/go.mod"
	"github.com/bradfitz/iter v0.0.0-20190303215204-33e6a9893b0c/go.mod"
	"github.com/census-instrumentation/opencensus-proto v0.2.1/go.mod"
	"github.com/census-instrumentation/opencensus-proto v0.3.0/go.mod"
	"github.com/cespare/xxhash v1.1.0/go.mod"
	"github.com/cespare/xxhash/v2 v2.1.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.1.2/go.mod"
	"github.com/chromedp/cdproto v0.0.0-20230802225258-3cf4e6d46a89/go.mod"
	"github.com/chromedp/cdproto v0.0.0-20231007061347-18b01cd81617"
	"github.com/chromedp/cdproto v0.0.0-20231007061347-18b01cd81617/go.mod"
	"github.com/chromedp/chromedp v0.9.2"
	"github.com/chromedp/chromedp v0.9.2/go.mod"
	"github.com/chromedp/sysutil v1.0.0"
	"github.com/chromedp/sysutil v1.0.0/go.mod"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/circonus-labs/circonus-gometrics v2.3.1+incompatible/go.mod"
	"github.com/circonus-labs/circonusllhist v0.1.3/go.mod"
	"github.com/client9/misspell v0.3.4/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20191209042840-269d4d468f6f/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20200629203442-efcf912fb354/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20201120205902-5459f2c99403/go.mod"
	"github.com/cncf/udpa/go v0.0.0-20210930031921-04548b0d99d4/go.mod"
	"github.com/cncf/xds/go v0.0.0-20210312221358-fbca930ec8ed/go.mod"
	"github.com/cncf/xds/go v0.0.0-20210805033703-aa0b78936158/go.mod"
	"github.com/cncf/xds/go v0.0.0-20210922020428-25de7278fc84/go.mod"
	"github.com/cncf/xds/go v0.0.0-20211001041855-01bcc9b48dfe/go.mod"
	"github.com/cncf/xds/go v0.0.0-20211011173535-cb28da3451f1/go.mod"
	"github.com/cncf/xds/go v0.0.0-20211130200136-a8f946100490/go.mod"
	"github.com/coreos/go-semver v0.3.0/go.mod"
	"github.com/coreos/go-systemd/v22 v22.3.2/go.mod"
	"github.com/coreos/go-systemd/v22 v22.5.0/go.mod"
	"github.com/corona10/goimagehash v1.1.0"
	"github.com/corona10/goimagehash v1.1.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/denisenkom/go-mssqldb v0.10.0/go.mod"
	"github.com/dgryski/trifles v0.0.0-20200323201526-dd97f9abfb48"
	"github.com/dgryski/trifles v0.0.0-20200323201526-dd97f9abfb48/go.mod"
	"github.com/disintegration/imaging v1.6.2"
	"github.com/disintegration/imaging v1.6.2/go.mod"
	"github.com/docopt/docopt-go v0.0.0-20180111231733-ee0de3bc6815/go.mod"
	"github.com/doug-martin/goqu/v9 v9.18.0"
	"github.com/doug-martin/goqu/v9 v9.18.0/go.mod"
	"github.com/dustin/go-humanize v0.0.0-20180421182945-02af3965c54e/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.0/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.1-0.20191026205805-5f8ba28d4473/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.4/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.7/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.9-0.20201210154907-fd9021fe5dad/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.9-0.20210217033140-668b12f5399d/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.9-0.20210512163311-63b5d3c536b0/go.mod"
	"github.com/envoyproxy/go-control-plane v0.9.10-0.20210907150352-cf90f659a021/go.mod"
	"github.com/envoyproxy/go-control-plane v0.10.1/go.mod"
	"github.com/envoyproxy/protoc-gen-validate v0.1.0/go.mod"
	"github.com/envoyproxy/protoc-gen-validate v0.6.2/go.mod"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/fatih/color v1.9.0/go.mod"
	"github.com/fatih/color v1.13.0/go.mod"
	"github.com/frankban/quicktest v1.14.4"
	"github.com/fsnotify/fsnotify v1.5.1/go.mod"
	"github.com/fsnotify/fsnotify v1.6.0"
	"github.com/fsnotify/fsnotify v1.6.0/go.mod"
	"github.com/ghodss/yaml v1.0.0/go.mod"
	"github.com/glycerine/go-unsnap-stream v0.0.0-20180323001048-9f0cb55181dd/go.mod"
	"github.com/glycerine/goconvey v0.0.0-20180728074245-46e3a41ad493/go.mod"
	"github.com/go-chi/chi/v5 v5.0.7/go.mod"
	"github.com/go-chi/chi/v5 v5.0.10"
	"github.com/go-chi/chi/v5 v5.0.10/go.mod"
	"github.com/go-chi/cors v1.2.1"
	"github.com/go-chi/cors v1.2.1/go.mod"
	"github.com/go-chi/httplog v0.3.1"
	"github.com/go-chi/httplog v0.3.1/go.mod"
	"github.com/go-gl/glfw v0.0.0-20190409004039-e6da0acd62b1/go.mod"
	"github.com/go-gl/glfw/v3.3/glfw v0.0.0-20191125211704-12ad95a8df72/go.mod"
	"github.com/go-gl/glfw/v3.3/glfw v0.0.0-20200222043503-6f7a984d4dc4/go.mod"
	"github.com/go-kit/kit v0.8.0/go.mod"
	"github.com/go-kit/kit v0.9.0/go.mod"
	"github.com/go-logfmt/logfmt v0.3.0/go.mod"
	"github.com/go-logfmt/logfmt v0.4.0/go.mod"
	"github.com/go-sql-driver/mysql v1.6.0"
	"github.com/go-sql-driver/mysql v1.6.0/go.mod"
	"github.com/go-stack/stack v1.8.0/go.mod"
	"github.com/go-toast/toast v0.0.0-20190211030409-01e6764cf0a4"
	"github.com/go-toast/toast v0.0.0-20190211030409-01e6764cf0a4/go.mod"
	"github.com/gobwas/httphead v0.1.0"
	"github.com/gobwas/httphead v0.1.0/go.mod"
	"github.com/gobwas/pool v0.2.1"
	"github.com/gobwas/pool v0.2.1/go.mod"
	"github.com/gobwas/ws v1.2.1/go.mod"
	"github.com/gobwas/ws v1.3.0"
	"github.com/gobwas/ws v1.3.0/go.mod"
	"github.com/godbus/dbus/v5 v5.0.4/go.mod"
	"github.com/gofrs/uuid/v5 v5.0.0"
	"github.com/gofrs/uuid/v5 v5.0.0/go.mod"
	"github.com/gogo/protobuf v1.1.1/go.mod"
	"github.com/gogo/protobuf v1.3.2/go.mod"
	"github.com/golang-jwt/jwt/v4 v4.5.0"
	"github.com/golang-jwt/jwt/v4 v4.5.0/go.mod"
	"github.com/golang-migrate/migrate/v4 v4.16.2"
	"github.com/golang-migrate/migrate/v4 v4.16.2/go.mod"
	"github.com/golang-sql/civil v0.0.0-20190719163853-cb61b32ac6fe/go.mod"
	"github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b/go.mod"
	"github.com/golang/groupcache v0.0.0-20190702054246-869f871628b6/go.mod"
	"github.com/golang/groupcache v0.0.0-20191227052852-215e87163ea7/go.mod"
	"github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e/go.mod"
	"github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da"
	"github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da/go.mod"
	"github.com/golang/mock v1.1.1/go.mod"
	"github.com/golang/mock v1.2.0/go.mod"
	"github.com/golang/mock v1.3.1/go.mod"
	"github.com/golang/mock v1.4.0/go.mod"
	"github.com/golang/mock v1.4.1/go.mod"
	"github.com/golang/mock v1.4.3/go.mod"
	"github.com/golang/mock v1.4.4/go.mod"
	"github.com/golang/mock v1.5.0/go.mod"
	"github.com/golang/mock v1.6.0/go.mod"
	"github.com/golang/protobuf v1.2.0/go.mod"
	"github.com/golang/protobuf v1.3.1/go.mod"
	"github.com/golang/protobuf v1.3.2/go.mod"
	"github.com/golang/protobuf v1.3.3/go.mod"
	"github.com/golang/protobuf v1.3.4/go.mod"
	"github.com/golang/protobuf v1.3.5/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.1/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.1.0.20200221234624-67d41d38c208/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.2/go.mod"
	"github.com/golang/protobuf v1.4.0-rc.4.0.20200313231945-b860323f09d0/go.mod"
	"github.com/golang/protobuf v1.4.0/go.mod"
	"github.com/golang/protobuf v1.4.1/go.mod"
	"github.com/golang/protobuf v1.4.2/go.mod"
	"github.com/golang/protobuf v1.4.3/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.1/go.mod"
	"github.com/golang/protobuf v1.5.2/go.mod"
	"github.com/golang/snappy v0.0.0-20180518054509-2e65f85255db/go.mod"
	"github.com/golang/snappy v0.0.3/go.mod"
	"github.com/google/btree v0.0.0-20180124185431-e89373fe6b4a/go.mod"
	"github.com/google/btree v0.0.0-20180813153112-4030bb1f1f0c/go.mod"
	"github.com/google/btree v1.0.0/go.mod"
	"github.com/google/go-cmp v0.2.0/go.mod"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/google/go-cmp v0.4.0/go.mod"
	"github.com/google/go-cmp v0.4.1/go.mod"
	"github.com/google/go-cmp v0.5.0/go.mod"
	"github.com/google/go-cmp v0.5.1/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/google/go-cmp v0.5.3/go.mod"
	"github.com/google/go-cmp v0.5.4/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.5.6/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/google/martian v2.1.0+incompatible/go.mod"
	"github.com/google/martian/v3 v3.0.0/go.mod"
	"github.com/google/martian/v3 v3.1.0/go.mod"
	"github.com/google/martian/v3 v3.2.1/go.mod"
	"github.com/google/pprof v0.0.0-20181206194817-3ea8567a2e57/go.mod"
	"github.com/google/pprof v0.0.0-20190515194954-54271f7e092f/go.mod"
	"github.com/google/pprof v0.0.0-20191218002539-d4f498aebedc/go.mod"
	"github.com/google/pprof v0.0.0-20200212024743-f11f1df84d12/go.mod"
	"github.com/google/pprof v0.0.0-20200229191704-1ebb73c60ed3/go.mod"
	"github.com/google/pprof v0.0.0-20200430221834-fc25d7d30c6d/go.mod"
	"github.com/google/pprof v0.0.0-20200708004538-1a94d8640e99/go.mod"
	"github.com/google/pprof v0.0.0-20201023163331-3e6fc7fc9c4c/go.mod"
	"github.com/google/pprof v0.0.0-20201203190320-1bf35d6f28c2/go.mod"
	"github.com/google/pprof v0.0.0-20201218002935-b9804c9f04c2/go.mod"
	"github.com/google/pprof v0.0.0-20210122040257-d980be63207e/go.mod"
	"github.com/google/pprof v0.0.0-20210226084205-cbba55b83ad5/go.mod"
	"github.com/google/pprof v0.0.0-20210601050228-01bbb1931b22/go.mod"
	"github.com/google/pprof v0.0.0-20210609004039-a478d1d731e9/go.mod"
	"github.com/google/pprof v0.0.0-20210720184732-4bb14d4b1be1/go.mod"
	"github.com/google/renameio v0.1.0/go.mod"
	"github.com/google/uuid v1.1.2/go.mod"
	"github.com/googleapis/gax-go/v2 v2.0.4/go.mod"
	"github.com/googleapis/gax-go/v2 v2.0.5/go.mod"
	"github.com/googleapis/gax-go/v2 v2.1.0/go.mod"
	"github.com/googleapis/gax-go/v2 v2.1.1/go.mod"
	"github.com/googleapis/google-cloud-go-testing v0.0.0-20200911160855-bcd43fbb19e8/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181103185306-d547d1d9531e/go.mod"
	"github.com/gorilla/securecookie v1.1.1"
	"github.com/gorilla/securecookie v1.1.1/go.mod"
	"github.com/gorilla/sessions v1.2.1"
	"github.com/gorilla/sessions v1.2.1/go.mod"
	"github.com/gorilla/websocket v1.4.2/go.mod"
	"github.com/gorilla/websocket v1.5.0"
	"github.com/gorilla/websocket v1.5.0/go.mod"
	"github.com/grpc-ecosystem/grpc-gateway v1.16.0/go.mod"
	"github.com/hashicorp/consul/api v1.11.0/go.mod"
	"github.com/hashicorp/consul/api v1.12.0/go.mod"
	"github.com/hashicorp/consul/sdk v0.8.0/go.mod"
	"github.com/hashicorp/errwrap v1.0.0/go.mod"
	"github.com/hashicorp/errwrap v1.1.0"
	"github.com/hashicorp/errwrap v1.1.0/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.0/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.1/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.2/go.mod"
	"github.com/hashicorp/go-hclog v0.12.0/go.mod"
	"github.com/hashicorp/go-hclog v1.0.0/go.mod"
	"github.com/hashicorp/go-immutable-radix v1.0.0/go.mod"
	"github.com/hashicorp/go-immutable-radix v1.3.1/go.mod"
	"github.com/hashicorp/go-msgpack v0.5.3/go.mod"
	"github.com/hashicorp/go-multierror v1.0.0/go.mod"
	"github.com/hashicorp/go-multierror v1.1.0/go.mod"
	"github.com/hashicorp/go-multierror v1.1.1"
	"github.com/hashicorp/go-multierror v1.1.1/go.mod"
	"github.com/hashicorp/go-retryablehttp v0.5.3/go.mod"
	"github.com/hashicorp/go-rootcerts v1.0.2/go.mod"
	"github.com/hashicorp/go-sockaddr v1.0.0/go.mod"
	"github.com/hashicorp/go-syslog v1.0.0/go.mod"
	"github.com/hashicorp/go-uuid v1.0.0/go.mod"
	"github.com/hashicorp/go-uuid v1.0.1/go.mod"
	"github.com/hashicorp/golang-lru v0.5.0/go.mod"
	"github.com/hashicorp/golang-lru v0.5.1/go.mod"
	"github.com/hashicorp/golang-lru v0.5.4"
	"github.com/hashicorp/golang-lru v0.5.4/go.mod"
	"github.com/hashicorp/golang-lru/v2 v2.0.6"
	"github.com/hashicorp/golang-lru/v2 v2.0.6/go.mod"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/hashicorp/hcl v1.0.0/go.mod"
	"github.com/hashicorp/logutils v1.0.0/go.mod"
	"github.com/hashicorp/mdns v1.0.1/go.mod"
	"github.com/hashicorp/mdns v1.0.4/go.mod"
	"github.com/hashicorp/memberlist v0.2.2/go.mod"
	"github.com/hashicorp/memberlist v0.3.0/go.mod"
	"github.com/hashicorp/serf v0.9.5/go.mod"
	"github.com/hashicorp/serf v0.9.6/go.mod"
	"github.com/huandu/xstrings v1.0.0/go.mod"
	"github.com/iancoleman/strcase v0.2.0/go.mod"
	"github.com/ianlancetaylor/demangle v0.0.0-20181102032728-5e5cf60278f6/go.mod"
	"github.com/ianlancetaylor/demangle v0.0.0-20200824232613-28f6c0f3b639/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jinzhu/copier v0.4.0"
	"github.com/jinzhu/copier v0.4.0/go.mod"
	"github.com/jmoiron/sqlx v1.3.5"
	"github.com/jmoiron/sqlx v1.3.5/go.mod"
	"github.com/josharian/intern v1.0.0"
	"github.com/josharian/intern v1.0.0/go.mod"
	"github.com/json-iterator/go v1.1.6/go.mod"
	"github.com/json-iterator/go v1.1.9/go.mod"
	"github.com/json-iterator/go v1.1.11/go.mod"
	"github.com/json-iterator/go v1.1.12"
	"github.com/json-iterator/go v1.1.12/go.mod"
	"github.com/jstemmer/go-junit-report v0.0.0-20190106144839-af01ea7f8024/go.mod"
	"github.com/jstemmer/go-junit-report v0.9.1/go.mod"
	"github.com/jtolds/gls v4.2.1+incompatible/go.mod"
	"github.com/julienschmidt/httprouter v1.2.0/go.mod"
	"github.com/kermieisinthehouse/gosx-notifier v0.1.2"
	"github.com/kermieisinthehouse/gosx-notifier v0.1.2/go.mod"
	"github.com/kermieisinthehouse/systray v1.2.4"
	"github.com/kermieisinthehouse/systray v1.2.4/go.mod"
	"github.com/kevinmbeaulieu/eq-go v1.0.0/go.mod"
	"github.com/kisielk/errcheck v1.5.0/go.mod"
	"github.com/kisielk/gotool v1.0.0/go.mod"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1/go.mod"
	"github.com/kr/fs v0.1.0/go.mod"
	"github.com/kr/logfmt v0.0.0-20140226030751-b84e30acd515/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pretty v0.2.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/ledongthuc/pdf v0.0.0-20220302134840-0c2507a12d80"
	"github.com/ledongthuc/pdf v0.0.0-20220302134840-0c2507a12d80/go.mod"
	"github.com/lib/pq v1.2.0/go.mod"
	"github.com/lib/pq v1.10.1/go.mod"
	"github.com/lib/pq v1.10.2"
	"github.com/logrusorgru/aurora/v3 v3.0.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/lyft/protoc-gen-star v0.5.3/go.mod"
	"github.com/magiconair/properties v1.8.5/go.mod"
	"github.com/magiconair/properties v1.8.7"
	"github.com/magiconair/properties v1.8.7/go.mod"
	"github.com/mailru/easyjson v0.7.7"
	"github.com/mailru/easyjson v0.7.7/go.mod"
	"github.com/matryer/moq v0.2.3"
	"github.com/matryer/moq v0.2.3/go.mod"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-colorable v0.1.6/go.mod"
	"github.com/mattn/go-colorable v0.1.9/go.mod"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.3/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.10/go.mod"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.19"
	"github.com/mattn/go-isatty v0.0.19/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.6/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.7/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.17"
	"github.com/mattn/go-sqlite3 v1.14.17/go.mod"
	"github.com/matttproud/golang_protobuf_extensions v1.0.1/go.mod"
	"github.com/miekg/dns v1.0.14/go.mod"
	"github.com/miekg/dns v1.1.26/go.mod"
	"github.com/miekg/dns v1.1.41/go.mod"
	"github.com/mitchellh/cli v1.1.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/mitchellh/go-testing-interface v1.0.0/go.mod"
	"github.com/mitchellh/mapstructure v0.0.0-20160808181253-ca63d7c062ee/go.mod"
	"github.com/mitchellh/mapstructure v1.1.2/go.mod"
	"github.com/mitchellh/mapstructure v1.2.3/go.mod"
	"github.com/mitchellh/mapstructure v1.4.3/go.mod"
	"github.com/mitchellh/mapstructure v1.5.0"
	"github.com/mitchellh/mapstructure v1.5.0/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod"
	"github.com/modern-go/reflect2 v1.0.1/go.mod"
	"github.com/modern-go/reflect2 v1.0.2"
	"github.com/modern-go/reflect2 v1.0.2/go.mod"
	"github.com/mschoch/smat v0.0.0-20160514031455-90eadee771ae/go.mod"
	"github.com/mwitkow/go-conntrack v0.0.0-20161129095857-cc309e4a2223/go.mod"
	"github.com/natefinch/pie v0.0.0-20170715172608-9a0d72014007"
	"github.com/natefinch/pie v0.0.0-20170715172608-9a0d72014007/go.mod"
	"github.com/nfnt/resize v0.0.0-20180221191011-83c6a9932646"
	"github.com/nfnt/resize v0.0.0-20180221191011-83c6a9932646/go.mod"
	"github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d"
	"github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d/go.mod"
	"github.com/orisano/pixelmatch v0.0.0-20220722002657-fb0b55479cde"
	"github.com/orisano/pixelmatch v0.0.0-20220722002657-fb0b55479cde/go.mod"
	"github.com/pascaldekloe/goe v0.0.0-20180627143212-57f6aae5913c/go.mod"
	"github.com/pascaldekloe/goe v0.1.0/go.mod"
	"github.com/pelletier/go-toml v1.9.4/go.mod"
	"github.com/pelletier/go-toml/v2 v2.1.0"
	"github.com/pelletier/go-toml/v2 v2.1.0/go.mod"
	"github.com/philhofer/fwd v1.0.0/go.mod"
	"github.com/pkg/browser v0.0.0-20210911075715-681adbf594b8"
	"github.com/pkg/browser v0.0.0-20210911075715-681adbf594b8/go.mod"
	"github.com/pkg/errors v0.8.0/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pkg/profile v1.4.0/go.mod"
	"github.com/pkg/sftp v1.10.1/go.mod"
	"github.com/pkg/sftp v1.13.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/posener/complete v1.1.1/go.mod"
	"github.com/posener/complete v1.2.3/go.mod"
	"github.com/prometheus/client_golang v0.9.1/go.mod"
	"github.com/prometheus/client_golang v1.0.0/go.mod"
	"github.com/prometheus/client_golang v1.4.0/go.mod"
	"github.com/prometheus/client_model v0.0.0-20180712105110-5c3871d89910/go.mod"
	"github.com/prometheus/client_model v0.0.0-20190129233127-fd36f4220a90/go.mod"
	"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4/go.mod"
	"github.com/prometheus/client_model v0.2.0/go.mod"
	"github.com/prometheus/common v0.4.1/go.mod"
	"github.com/prometheus/common v0.9.1/go.mod"
	"github.com/prometheus/procfs v0.0.0-20181005140218-185b4288413d/go.mod"
	"github.com/prometheus/procfs v0.0.2/go.mod"
	"github.com/prometheus/procfs v0.0.8/go.mod"
	"github.com/remeh/sizedwaitgroup v1.0.0"
	"github.com/remeh/sizedwaitgroup v1.0.0/go.mod"
	"github.com/robertkrimen/otto v0.0.0-20200922221731-ef014fd054ac"
	"github.com/robertkrimen/otto v0.0.0-20200922221731-ef014fd054ac/go.mod"
	"github.com/rogpeppe/fastuuid v1.2.0/go.mod"
	"github.com/rogpeppe/go-internal v1.3.0/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0"
	"github.com/rs/xid v1.3.0/go.mod"
	"github.com/rs/xid v1.4.0/go.mod"
	"github.com/rs/xid v1.5.0/go.mod"
	"github.com/rs/zerolog v1.26.1/go.mod"
	"github.com/rs/zerolog v1.29.1/go.mod"
	"github.com/rs/zerolog v1.30.0"
	"github.com/rs/zerolog v1.30.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/ryanuber/columnize v0.0.0-20160712163229-9b3edd62028f/go.mod"
	"github.com/ryszard/goskiplist v0.0.0-20150312221310-2dfbae5fcf46/go.mod"
	"github.com/sagikazarmark/crypt v0.3.0/go.mod"
	"github.com/sagikazarmark/crypt v0.4.0/go.mod"
	"github.com/sean-/seed v0.0.0-20170313163322-e2103e2c3529/go.mod"
	"github.com/sergi/go-diff v1.1.0"
	"github.com/sergi/go-diff v1.1.0/go.mod"
	"github.com/shurcooL/graphql v0.0.0-20181231061246-d48a9a75455f"
	"github.com/shurcooL/graphql v0.0.0-20181231061246-d48a9a75455f/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.2.0/go.mod"
	"github.com/sirupsen/logrus v1.4.2/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v0.0.0-20181108003508-044398e4856c/go.mod"
	"github.com/spaolacci/murmur3 v0.0.0-20180118202830-f09979ecbc72/go.mod"
	"github.com/spf13/afero v1.3.3/go.mod"
	"github.com/spf13/afero v1.6.0/go.mod"
	"github.com/spf13/afero v1.8.0/go.mod"
	"github.com/spf13/afero v1.9.5"
	"github.com/spf13/afero v1.9.5/go.mod"
	"github.com/spf13/cast v1.4.1/go.mod"
	"github.com/spf13/cast v1.5.1"
	"github.com/spf13/cast v1.5.1/go.mod"
	"github.com/spf13/cobra v1.3.0/go.mod"
	"github.com/spf13/cobra v1.7.0"
	"github.com/spf13/cobra v1.7.0/go.mod"
	"github.com/spf13/jwalterweatherman v1.1.0"
	"github.com/spf13/jwalterweatherman v1.1.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/spf13/viper v1.10.0/go.mod"
	"github.com/spf13/viper v1.10.1/go.mod"
	"github.com/spf13/viper v1.16.0"
	"github.com/spf13/viper v1.16.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.1.1/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/testify v1.2.1/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.4"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/subosito/gotenv v1.2.0/go.mod"
	"github.com/subosito/gotenv v1.6.0"
	"github.com/subosito/gotenv v1.6.0/go.mod"
	"github.com/tidwall/gjson v1.16.0"
	"github.com/tidwall/gjson v1.16.0/go.mod"
	"github.com/tidwall/match v1.1.1"
	"github.com/tidwall/match v1.1.1/go.mod"
	"github.com/tidwall/pretty v1.2.0/go.mod"
	"github.com/tidwall/pretty v1.2.1"
	"github.com/tidwall/pretty v1.2.1/go.mod"
	"github.com/tinylib/msgp v1.0.2/go.mod"
	"github.com/tv42/httpunix v0.0.0-20150427012821-b75d8614f926/go.mod"
	"github.com/urfave/cli/v2 v2.3.0/go.mod"
	"github.com/urfave/cli/v2 v2.8.1"
	"github.com/urfave/cli/v2 v2.8.1/go.mod"
	"github.com/vearutop/statigz v1.4.0"
	"github.com/vearutop/statigz v1.4.0/go.mod"
	"github.com/vektah/dataloaden v0.3.0"
	"github.com/vektah/dataloaden v0.3.0/go.mod"
	"github.com/vektah/gqlparser/v2 v2.4.0/go.mod"
	"github.com/vektah/gqlparser/v2 v2.4.1/go.mod"
	"github.com/vektah/gqlparser/v2 v2.4.2"
	"github.com/vektah/gqlparser/v2 v2.4.2/go.mod"
	"github.com/vektra/mockery/v2 v2.10.0"
	"github.com/vektra/mockery/v2 v2.10.0/go.mod"
	"github.com/willf/bitset v1.1.9/go.mod"
	"github.com/xWTF/chardet v0.0.0-20230208095535-c780f2ac244e"
	"github.com/xWTF/chardet v0.0.0-20230208095535-c780f2ac244e/go.mod"
	"github.com/xrash/smetrics v0.0.0-20201216005158-039620a65673"
	"github.com/xrash/smetrics v0.0.0-20201216005158-039620a65673/go.mod"
	"github.com/yuin/goldmark v1.1.25/go.mod"
	"github.com/yuin/goldmark v1.1.27/go.mod"
	"github.com/yuin/goldmark v1.1.32/go.mod"
	"github.com/yuin/goldmark v1.2.1/go.mod"
	"github.com/yuin/goldmark v1.3.5/go.mod"
	"github.com/yuin/goldmark v1.4.0/go.mod"
	"github.com/yuin/goldmark v1.4.1/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"github.com/zencoder/go-dash/v3 v3.0.2"
	"github.com/zencoder/go-dash/v3 v3.0.2/go.mod"
	"go.etcd.io/etcd/api/v3 v3.5.1/go.mod"
	"go.etcd.io/etcd/client/pkg/v3 v3.5.1/go.mod"
	"go.etcd.io/etcd/client/v2 v2.305.1/go.mod"
	"go.opencensus.io v0.21.0/go.mod"
	"go.opencensus.io v0.22.0/go.mod"
	"go.opencensus.io v0.22.2/go.mod"
	"go.opencensus.io v0.22.3/go.mod"
	"go.opencensus.io v0.22.4/go.mod"
	"go.opencensus.io v0.22.5/go.mod"
	"go.opencensus.io v0.23.0/go.mod"
	"go.opentelemetry.io/proto/otlp v0.7.0/go.mod"
	"go.uber.org/atomic v1.7.0/go.mod"
	"go.uber.org/atomic v1.11.0"
	"go.uber.org/atomic v1.11.0/go.mod"
	"go.uber.org/multierr v1.6.0/go.mod"
	"go.uber.org/zap v1.17.0/go.mod"
	"golang.org/x/crypto v0.0.0-20180904163835-0709b304e793/go.mod"
	"golang.org/x/crypto v0.0.0-20181029021203-45a5f77698d3/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190325154230-a5d413f7728c/go.mod"
	"golang.org/x/crypto v0.0.0-20190510104115-cbcb75029529/go.mod"
	"golang.org/x/crypto v0.0.0-20190605123033-f99c8df09eb5/go.mod"
	"golang.org/x/crypto v0.0.0-20190820162420-60c769a6c586/go.mod"
	"golang.org/x/crypto v0.0.0-20190923035154-9ee001bba392/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20210421170649-83a5a9bb288b/go.mod"
	"golang.org/x/crypto v0.0.0-20210817164053-32db794688a5/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.0.0-20211108221036-ceb1ce70b4fa/go.mod"
	"golang.org/x/crypto v0.0.0-20211215165025-cf75a172585e/go.mod"
	"golang.org/x/crypto v0.0.0-20220112180741-5e0467b6c7ce/go.mod"
	"golang.org/x/crypto v0.0.0-20220722155217-630584e8d5aa/go.mod"
	"golang.org/x/crypto v0.17.0"
	"golang.org/x/crypto v0.17.0/go.mod"
	"golang.org/x/exp v0.0.0-20190121172915-509febef88a4/go.mod"
	"golang.org/x/exp v0.0.0-20190306152737-a1d7652674e8/go.mod"
	"golang.org/x/exp v0.0.0-20190510132918-efd6b22b2522/go.mod"
	"golang.org/x/exp v0.0.0-20190829153037-c13cbed26979/go.mod"
	"golang.org/x/exp v0.0.0-20191030013958-a1ab85dbe136/go.mod"
	"golang.org/x/exp v0.0.0-20191129062945-2f5052295587/go.mod"
	"golang.org/x/exp v0.0.0-20191227195350-da58074b4299/go.mod"
	"golang.org/x/exp v0.0.0-20200119233911-0405dc783f0a/go.mod"
	"golang.org/x/exp v0.0.0-20200207192155-f17229e696bd/go.mod"
	"golang.org/x/exp v0.0.0-20200224162631-6cc2880d07d6/go.mod"
	"golang.org/x/image v0.0.0-20190227222117-0694c2d4d067/go.mod"
	"golang.org/x/image v0.0.0-20190802002840-cff245a6509b/go.mod"
	"golang.org/x/image v0.0.0-20191009234506-e7c1f5e7dbb8/go.mod"
	"golang.org/x/image v0.12.0"
	"golang.org/x/image v0.12.0/go.mod"
	"golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3/go.mod"
	"golang.org/x/lint v0.0.0-20190227174305-5b3e6a55c961/go.mod"
	"golang.org/x/lint v0.0.0-20190301231843-5614ed5bae6f/go.mod"
	"golang.org/x/lint v0.0.0-20190313153728-d0100b6bd8b3/go.mod"
	"golang.org/x/lint v0.0.0-20190409202823-959b441ac422/go.mod"
	"golang.org/x/lint v0.0.0-20190909230951-414d861bb4ac/go.mod"
	"golang.org/x/lint v0.0.0-20190930215403-16217165b5de/go.mod"
	"golang.org/x/lint v0.0.0-20191125180803-fdd1cda4f05f/go.mod"
	"golang.org/x/lint v0.0.0-20200130185559-910be7a94367/go.mod"
	"golang.org/x/lint v0.0.0-20200302205851-738671d3881b/go.mod"
	"golang.org/x/lint v0.0.0-20201208152925-83fdc39ff7b5/go.mod"
	"golang.org/x/lint v0.0.0-20210508222113-6edffad5e616/go.mod"
	"golang.org/x/mobile v0.0.0-20190312151609-d3739f865fa6/go.mod"
	"golang.org/x/mobile v0.0.0-20190719004257-d2bd2a29d028/go.mod"
	"golang.org/x/mod v0.0.0-20190513183733-4bf6d317e70e/go.mod"
	"golang.org/x/mod v0.1.0/go.mod"
	"golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod"
	"golang.org/x/mod v0.1.1-0.20191107180719-034126e5016b/go.mod"
	"golang.org/x/mod v0.2.0/go.mod"
	"golang.org/x/mod v0.3.0/go.mod"
	"golang.org/x/mod v0.4.0/go.mod"
	"golang.org/x/mod v0.4.1/go.mod"
	"golang.org/x/mod v0.4.2/go.mod"
	"golang.org/x/mod v0.5.0/go.mod"
	"golang.org/x/mod v0.5.1/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220106191415-9b9b3d81d5e3/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.8.0/go.mod"
	"golang.org/x/mod v0.12.0"
	"golang.org/x/mod v0.12.0/go.mod"
	"golang.org/x/net v0.0.0-20180724234803-3673e40ba225/go.mod"
	"golang.org/x/net v0.0.0-20180826012351-8a410e7b638d/go.mod"
	"golang.org/x/net v0.0.0-20181023162649-9b4f9f5ad519/go.mod"
	"golang.org/x/net v0.0.0-20181114220301-adae6a3d119a/go.mod"
	"golang.org/x/net v0.0.0-20190108225652-1e06a53dbb7e/go.mod"
	"golang.org/x/net v0.0.0-20190213061140-3a22650c66bd/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190415214537-1da14a5a36f2/go.mod"
	"golang.org/x/net v0.0.0-20190501004415-9ce7a6920f09/go.mod"
	"golang.org/x/net v0.0.0-20190503192946-f4e77d36d62c/go.mod"
	"golang.org/x/net v0.0.0-20190603091049-60506f45cf65/go.mod"
	"golang.org/x/net v0.0.0-20190613194153-d28f0bde5980/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190628185345-da137c7871d7/go.mod"
	"golang.org/x/net v0.0.0-20190724013045-ca1201d0de80/go.mod"
	"golang.org/x/net v0.0.0-20190923162816-aa69164e4478/go.mod"
	"golang.org/x/net v0.0.0-20191209160850-c0dbc17a3553/go.mod"
	"golang.org/x/net v0.0.0-20200114155413-6afb5195e5aa/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20200222125558-5a598a2470a0/go.mod"
	"golang.org/x/net v0.0.0-20200226121028-0de0cce0169b/go.mod"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a/go.mod"
	"golang.org/x/net v0.0.0-20200324143707-d3edc9973b7e/go.mod"
	"golang.org/x/net v0.0.0-20200501053045-e0ff5e5a1de5/go.mod"
	"golang.org/x/net v0.0.0-20200506145744-7e3656a0809f/go.mod"
	"golang.org/x/net v0.0.0-20200513185701-a91f0712d120/go.mod"
	"golang.org/x/net v0.0.0-20200520182314-0ba52f642ac2/go.mod"
	"golang.org/x/net v0.0.0-20200625001655-4c5254603344/go.mod"
	"golang.org/x/net v0.0.0-20200707034311-ab3426394381/go.mod"
	"golang.org/x/net v0.0.0-20200822124328-c89045814202/go.mod"
	"golang.org/x/net v0.0.0-20200904194848-62affa334b73/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/net v0.0.0-20201031054903-ff519b6c9102/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20201209123823-ac852fbbde11/go.mod"
	"golang.org/x/net v0.0.0-20201224014010-6772e930b67b/go.mod"
	"golang.org/x/net v0.0.0-20210119194325-5f4716e94777/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20210316092652-d523dce5a7f4/go.mod"
	"golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4/go.mod"
	"golang.org/x/net v0.0.0-20210410081132-afb366fc7cd1/go.mod"
	"golang.org/x/net v0.0.0-20210503060351-7fd8e65b6420/go.mod"
	"golang.org/x/net v0.0.0-20210805182204-aaa1db679c0d/go.mod"
	"golang.org/x/net v0.0.0-20210813160813-60bc85c4be6d/go.mod"
	"golang.org/x/net v0.0.0-20211015210444-4f30a5c0130f/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.5.0/go.mod"
	"golang.org/x/net v0.6.0/go.mod"
	"golang.org/x/net v0.17.0"
	"golang.org/x/net v0.17.0/go.mod"
	"golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be/go.mod"
	"golang.org/x/oauth2 v0.0.0-20190226205417-e64efc72b421/go.mod"
	"golang.org/x/oauth2 v0.0.0-20190604053449-0f29369cfe45/go.mod"
	"golang.org/x/oauth2 v0.0.0-20191202225959-858c2ad4c8b6/go.mod"
	"golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d/go.mod"
	"golang.org/x/oauth2 v0.0.0-20200902213428-5d25da1a8d43/go.mod"
	"golang.org/x/oauth2 v0.0.0-20201109201403-9fd604954f58/go.mod"
	"golang.org/x/oauth2 v0.0.0-20201208152858-08078c50e5b5/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210218202405-ba52d332ba99/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210220000619-9bb904979d93/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210313182246-cd4f82c27b84/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210514164344-f6687ab2804c/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210628180205-a41e5a781914/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210805134026-6f1e6394065a/go.mod"
	"golang.org/x/oauth2 v0.0.0-20210819190943-2bc19b11175f/go.mod"
	"golang.org/x/oauth2 v0.0.0-20211005180243-6b3c2da341f1/go.mod"
	"golang.org/x/oauth2 v0.0.0-20211104180415-d3ed0bb246c8/go.mod"
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod"
	"golang.org/x/sync v0.0.0-20181108010431-42b317875d0f/go.mod"
	"golang.org/x/sync v0.0.0-20181221193216-37e7f081c4d4/go.mod"
	"golang.org/x/sync v0.0.0-20190227155943-e225da77a7e6/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sync v0.0.0-20200317015054-43a5402ce75a/go.mod"
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
	"golang.org/x/sync v0.0.0-20201207232520-09787c993a3a/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sync v0.3.0"
	"golang.org/x/sys v0.0.0-20180823144017-11551d06cbcc/go.mod"
	"golang.org/x/sys v0.0.0-20180830151530-49385e6e1522/go.mod"
	"golang.org/x/sys v0.0.0-20180905080454-ebe1bf3edb33/go.mod"
	"golang.org/x/sys v0.0.0-20181026203630-95b1ffbd15a5/go.mod"
	"golang.org/x/sys v0.0.0-20181116152217-5ac8a444bdc5/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190312061237-fead79001313/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190415145633-3fd5a3612ccd/go.mod"
	"golang.org/x/sys v0.0.0-20190422165155-953cdadca894/go.mod"
	"golang.org/x/sys v0.0.0-20190502145724-3ef323f4f1fd/go.mod"
	"golang.org/x/sys v0.0.0-20190507160741-ecd444e8653b/go.mod"
	"golang.org/x/sys v0.0.0-20190606165138-5da285871e9c/go.mod"
	"golang.org/x/sys v0.0.0-20190624142023-c5567b49c5d0/go.mod"
	"golang.org/x/sys v0.0.0-20190726091711-fc99dfbffb4e/go.mod"
	"golang.org/x/sys v0.0.0-20190922100055-0a153f010e69/go.mod"
	"golang.org/x/sys v0.0.0-20190924154521-2837fb4f24fe/go.mod"
	"golang.org/x/sys v0.0.0-20191001151750-bb3f8db39f24/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191204072324-ce4227a45e2e/go.mod"
	"golang.org/x/sys v0.0.0-20191228213918-04cbcbbfeed8/go.mod"
	"golang.org/x/sys v0.0.0-20200113162924-86b910548bc1/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200122134326-e047566fdf82/go.mod"
	"golang.org/x/sys v0.0.0-20200124204421-9fbb57f87de9/go.mod"
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5/go.mod"
	"golang.org/x/sys v0.0.0-20200212091648-12a6c2dcc1e4/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527/go.mod"
	"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
	"golang.org/x/sys v0.0.0-20200331124033-c3d80250170d/go.mod"
	"golang.org/x/sys v0.0.0-20200501052902-10377860bb8e/go.mod"
	"golang.org/x/sys v0.0.0-20200511232937-7e40ca221e25/go.mod"
	"golang.org/x/sys v0.0.0-20200515095857-1151b9dac4a9/go.mod"
	"golang.org/x/sys v0.0.0-20200523222454-059865788121/go.mod"
	"golang.org/x/sys v0.0.0-20200803210538-64077c9b5642/go.mod"
	"golang.org/x/sys v0.0.0-20200905004654-be1d3432aa8f/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20201201145000-ef89a241ccb3/go.mod"
	"golang.org/x/sys v0.0.0-20210104204734-6f8348627aad/go.mod"
	"golang.org/x/sys v0.0.0-20210119212857-b64e53b001e4/go.mod"
	"golang.org/x/sys v0.0.0-20210220050731-9a76102bfb43/go.mod"
	"golang.org/x/sys v0.0.0-20210225134936-a50acf3fe073/go.mod"
	"golang.org/x/sys v0.0.0-20210303074136-134d130e1a04/go.mod"
	"golang.org/x/sys v0.0.0-20210305230114-8fe3ee5dd75b/go.mod"
	"golang.org/x/sys v0.0.0-20210315160823-c6e025ad8005/go.mod"
	"golang.org/x/sys v0.0.0-20210320140829-1e4c9ba3b0c4/go.mod"
	"golang.org/x/sys v0.0.0-20210330210617-4fbd30eecc44/go.mod"
	"golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210423185535-09eb48e85fd7/go.mod"
	"golang.org/x/sys v0.0.0-20210510120138-977fb7262007/go.mod"
	"golang.org/x/sys v0.0.0-20210514084401-e8d321eab015/go.mod"
	"golang.org/x/sys v0.0.0-20210603125802-9665404d3644/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20210616045830-e2b7044e8c71/go.mod"
	"golang.org/x/sys v0.0.0-20210616094352-59db8d763f22/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210806184541-e5e7981a1069/go.mod"
	"golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod"
	"golang.org/x/sys v0.0.0-20210816183151-1e6c022a8912/go.mod"
	"golang.org/x/sys v0.0.0-20210823070655-63515b42dcdf/go.mod"
	"golang.org/x/sys v0.0.0-20210908233432-aa78b53d3365/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20211007075335-d3039528d8ac/go.mod"
	"golang.org/x/sys v0.0.0-20211019181941-9d821ace8654/go.mod"
	"golang.org/x/sys v0.0.0-20211124211545-fe61309f8881/go.mod"
	"golang.org/x/sys v0.0.0-20211205182925-97ca703d548d/go.mod"
	"golang.org/x/sys v0.0.0-20211210111614-af8b64212486/go.mod"
	"golang.org/x/sys v0.0.0-20220114195835-da31bd327af9/go.mod"
	"golang.org/x/sys v0.0.0-20220319134239-a9b59b0215f8/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.0.0-20220908164124-27713097b956/go.mod"
	"golang.org/x/sys v0.4.0/go.mod"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.10.0/go.mod"
	"golang.org/x/sys v0.15.0"
	"golang.org/x/sys v0.15.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.4.0/go.mod"
	"golang.org/x/term v0.5.0/go.mod"
	"golang.org/x/term v0.15.0"
	"golang.org/x/term v0.15.0/go.mod"
	"golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.1-0.20180807135948-17ff2d5776d2/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.4/go.mod"
	"golang.org/x/text v0.3.5/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.6.0/go.mod"
	"golang.org/x/text v0.7.0/go.mod"
	"golang.org/x/text v0.13.0/go.mod"
	"golang.org/x/text v0.14.0"
	"golang.org/x/text v0.14.0/go.mod"
	"golang.org/x/time v0.0.0-20181108054448-85acf8d2951c/go.mod"
	"golang.org/x/time v0.0.0-20190308202827-9d24e82272b4/go.mod"
	"golang.org/x/time v0.0.0-20191024005414-555d28b269f0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190114222345-bf090417da8b/go.mod"
	"golang.org/x/tools v0.0.0-20190226205152-f727befe758c/go.mod"
	"golang.org/x/tools v0.0.0-20190311212946-11955173bddd/go.mod"
	"golang.org/x/tools v0.0.0-20190312151545-0bb0c0a6e846/go.mod"
	"golang.org/x/tools v0.0.0-20190312170243-e65039ee4138/go.mod"
	"golang.org/x/tools v0.0.0-20190425150028-36563e24a262/go.mod"
	"golang.org/x/tools v0.0.0-20190506145303-2d16b83fe98c/go.mod"
	"golang.org/x/tools v0.0.0-20190515012406-7d7faa4812bd/go.mod"
	"golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135/go.mod"
	"golang.org/x/tools v0.0.0-20190606124116-d0a3d012864b/go.mod"
	"golang.org/x/tools v0.0.0-20190621195816-6e04913cbbac/go.mod"
	"golang.org/x/tools v0.0.0-20190628153133-6cdbf07be9d0/go.mod"
	"golang.org/x/tools v0.0.0-20190816200558-6889da9d5479/go.mod"
	"golang.org/x/tools v0.0.0-20190907020128-2ca718005c18/go.mod"
	"golang.org/x/tools v0.0.0-20190911174233-4f2ddba30aff/go.mod"
	"golang.org/x/tools v0.0.0-20191012152004-8de300cfc20a/go.mod"
	"golang.org/x/tools v0.0.0-20191113191852-77e3bb0ad9e7/go.mod"
	"golang.org/x/tools v0.0.0-20191115202509-3a792d9c32b2/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20191125144606-a911d9008d1f/go.mod"
	"golang.org/x/tools v0.0.0-20191130070609-6e064ea0cf2d/go.mod"
	"golang.org/x/tools v0.0.0-20191216173652-a0e659d51361/go.mod"
	"golang.org/x/tools v0.0.0-20191227053925-7b8e75db28f4/go.mod"
	"golang.org/x/tools v0.0.0-20200117161641-43d50277825c/go.mod"
	"golang.org/x/tools v0.0.0-20200122220014-bf1340f18c4a/go.mod"
	"golang.org/x/tools v0.0.0-20200130002326-2f3ba24bd6e7/go.mod"
	"golang.org/x/tools v0.0.0-20200204074204-1cc6d1ef6c74/go.mod"
	"golang.org/x/tools v0.0.0-20200207183749-b753a1ba74fa/go.mod"
	"golang.org/x/tools v0.0.0-20200212150539-ea181f53ac56/go.mod"
	"golang.org/x/tools v0.0.0-20200224181240-023911ca70b2/go.mod"
	"golang.org/x/tools v0.0.0-20200227222343-706bc42d1f0d/go.mod"
	"golang.org/x/tools v0.0.0-20200304193943-95d2e580d8eb/go.mod"
	"golang.org/x/tools v0.0.0-20200312045724-11d5b4c81c7d/go.mod"
	"golang.org/x/tools v0.0.0-20200331025713-a30bf2db82d4/go.mod"
	"golang.org/x/tools v0.0.0-20200501065659-ab2804fb9c9d/go.mod"
	"golang.org/x/tools v0.0.0-20200512131952-2bc93b1c0c88/go.mod"
	"golang.org/x/tools v0.0.0-20200515010526-7d3b6ebf133d/go.mod"
	"golang.org/x/tools v0.0.0-20200618134242-20370b0cb4b2/go.mod"
	"golang.org/x/tools v0.0.0-20200619180055-7c47624df98f/go.mod"
	"golang.org/x/tools v0.0.0-20200729194436-6467de6f59a7/go.mod"
	"golang.org/x/tools v0.0.0-20200804011535-6c149bb5ef0d/go.mod"
	"golang.org/x/tools v0.0.0-20200815165600-90abf76919f3/go.mod"
	"golang.org/x/tools v0.0.0-20200825202427-b303f430e36d/go.mod"
	"golang.org/x/tools v0.0.0-20200904185747-39188db58858/go.mod"
	"golang.org/x/tools v0.0.0-20201110124207-079ba7bd75cd/go.mod"
	"golang.org/x/tools v0.0.0-20201201161351-ac6f37ff4c2a/go.mod"
	"golang.org/x/tools v0.0.0-20201208233053-a543418bbed2/go.mod"
	"golang.org/x/tools v0.0.0-20210105154028-b0ab187a4818/go.mod"
	"golang.org/x/tools v0.0.0-20210106214847-113979e3529a/go.mod"
	"golang.org/x/tools v0.0.0-20210108195828-e2f9c7f1fc8e/go.mod"
	"golang.org/x/tools v0.1.0/go.mod"
	"golang.org/x/tools v0.1.1/go.mod"
	"golang.org/x/tools v0.1.2/go.mod"
	"golang.org/x/tools v0.1.3/go.mod"
	"golang.org/x/tools v0.1.4/go.mod"
	"golang.org/x/tools v0.1.5/go.mod"
	"golang.org/x/tools v0.1.7/go.mod"
	"golang.org/x/tools v0.1.8/go.mod"
	"golang.org/x/tools v0.1.9/go.mod"
	"golang.org/x/tools v0.1.10/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.6.0/go.mod"
	"golang.org/x/tools v0.13.0"
	"golang.org/x/tools v0.13.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"google.golang.org/api v0.4.0/go.mod"
	"google.golang.org/api v0.7.0/go.mod"
	"google.golang.org/api v0.8.0/go.mod"
	"google.golang.org/api v0.9.0/go.mod"
	"google.golang.org/api v0.13.0/go.mod"
	"google.golang.org/api v0.14.0/go.mod"
	"google.golang.org/api v0.15.0/go.mod"
	"google.golang.org/api v0.17.0/go.mod"
	"google.golang.org/api v0.18.0/go.mod"
	"google.golang.org/api v0.19.0/go.mod"
	"google.golang.org/api v0.20.0/go.mod"
	"google.golang.org/api v0.22.0/go.mod"
	"google.golang.org/api v0.24.0/go.mod"
	"google.golang.org/api v0.28.0/go.mod"
	"google.golang.org/api v0.29.0/go.mod"
	"google.golang.org/api v0.30.0/go.mod"
	"google.golang.org/api v0.35.0/go.mod"
	"google.golang.org/api v0.36.0/go.mod"
	"google.golang.org/api v0.40.0/go.mod"
	"google.golang.org/api v0.41.0/go.mod"
	"google.golang.org/api v0.43.0/go.mod"
	"google.golang.org/api v0.47.0/go.mod"
	"google.golang.org/api v0.48.0/go.mod"
	"google.golang.org/api v0.50.0/go.mod"
	"google.golang.org/api v0.51.0/go.mod"
	"google.golang.org/api v0.54.0/go.mod"
	"google.golang.org/api v0.55.0/go.mod"
	"google.golang.org/api v0.56.0/go.mod"
	"google.golang.org/api v0.57.0/go.mod"
	"google.golang.org/api v0.59.0/go.mod"
	"google.golang.org/api v0.61.0/go.mod"
	"google.golang.org/api v0.62.0/go.mod"
	"google.golang.org/api v0.63.0/go.mod"
	"google.golang.org/appengine v1.1.0/go.mod"
	"google.golang.org/appengine v1.4.0/go.mod"
	"google.golang.org/appengine v1.5.0/go.mod"
	"google.golang.org/appengine v1.6.1/go.mod"
	"google.golang.org/appengine v1.6.5/go.mod"
	"google.golang.org/appengine v1.6.6/go.mod"
	"google.golang.org/appengine v1.6.7/go.mod"
	"google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8/go.mod"
	"google.golang.org/genproto v0.0.0-20190307195333-5fe7a883aa19/go.mod"
	"google.golang.org/genproto v0.0.0-20190418145605-e7d98fc518a7/go.mod"
	"google.golang.org/genproto v0.0.0-20190425155659-357c62f0e4bb/go.mod"
	"google.golang.org/genproto v0.0.0-20190502173448-54afdca5d873/go.mod"
	"google.golang.org/genproto v0.0.0-20190801165951-fa694d86fc64/go.mod"
	"google.golang.org/genproto v0.0.0-20190819201941-24fa4b261c55/go.mod"
	"google.golang.org/genproto v0.0.0-20190911173649-1774047e7e51/go.mod"
	"google.golang.org/genproto v0.0.0-20191108220845-16a3f7862a1a/go.mod"
	"google.golang.org/genproto v0.0.0-20191115194625-c23dd37a84c9/go.mod"
	"google.golang.org/genproto v0.0.0-20191216164720-4f79533eabd1/go.mod"
	"google.golang.org/genproto v0.0.0-20191230161307-f3c370f40bfb/go.mod"
	"google.golang.org/genproto v0.0.0-20200115191322-ca5a22157cba/go.mod"
	"google.golang.org/genproto v0.0.0-20200122232147-0452cf42e150/go.mod"
	"google.golang.org/genproto v0.0.0-20200204135345-fa8e72b47b90/go.mod"
	"google.golang.org/genproto v0.0.0-20200212174721-66ed5ce911ce/go.mod"
	"google.golang.org/genproto v0.0.0-20200224152610-e50cd9704f63/go.mod"
	"google.golang.org/genproto v0.0.0-20200228133532-8c2c7df3a383/go.mod"
	"google.golang.org/genproto v0.0.0-20200305110556-506484158171/go.mod"
	"google.golang.org/genproto v0.0.0-20200312145019-da6875a35672/go.mod"
	"google.golang.org/genproto v0.0.0-20200331122359-1ee6d9798940/go.mod"
	"google.golang.org/genproto v0.0.0-20200430143042-b979b6f78d84/go.mod"
	"google.golang.org/genproto v0.0.0-20200511104702-f5ebc3bea380/go.mod"
	"google.golang.org/genproto v0.0.0-20200513103714-09dca8ec2884/go.mod"
	"google.golang.org/genproto v0.0.0-20200515170657-fc4c6c6a6587/go.mod"
	"google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013/go.mod"
	"google.golang.org/genproto v0.0.0-20200618031413-b414f8b61790/go.mod"
	"google.golang.org/genproto v0.0.0-20200729003335-053ba62fc06f/go.mod"
	"google.golang.org/genproto v0.0.0-20200804131852-c06518451d9c/go.mod"
	"google.golang.org/genproto v0.0.0-20200825200019-8632dd797987/go.mod"
	"google.golang.org/genproto v0.0.0-20200904004341-0bd0a958aa1d/go.mod"
	"google.golang.org/genproto v0.0.0-20201109203340-2640f1f9cdfb/go.mod"
	"google.golang.org/genproto v0.0.0-20201201144952-b05cb90ed32e/go.mod"
	"google.golang.org/genproto v0.0.0-20201210142538-e3217bee35cc/go.mod"
	"google.golang.org/genproto v0.0.0-20201214200347-8c77b98c765d/go.mod"
	"google.golang.org/genproto v0.0.0-20210108203827-ffc7fda8c3d7/go.mod"
	"google.golang.org/genproto v0.0.0-20210222152913-aa3ee6e6a81c/go.mod"
	"google.golang.org/genproto v0.0.0-20210226172003-ab064af71705/go.mod"
	"google.golang.org/genproto v0.0.0-20210303154014-9728d6b83eeb/go.mod"
	"google.golang.org/genproto v0.0.0-20210310155132-4ce2db91004e/go.mod"
	"google.golang.org/genproto v0.0.0-20210319143718-93e7006c17a6/go.mod"
	"google.golang.org/genproto v0.0.0-20210402141018-6c239bbf2bb1/go.mod"
	"google.golang.org/genproto v0.0.0-20210513213006-bf773b8c8384/go.mod"
	"google.golang.org/genproto v0.0.0-20210602131652-f16073e35f0c/go.mod"
	"google.golang.org/genproto v0.0.0-20210604141403-392c879c8b08/go.mod"
	"google.golang.org/genproto v0.0.0-20210608205507-b6d2f5bf0d7d/go.mod"
	"google.golang.org/genproto v0.0.0-20210624195500-8bfb893ecb84/go.mod"
	"google.golang.org/genproto v0.0.0-20210713002101-d411969a0d9a/go.mod"
	"google.golang.org/genproto v0.0.0-20210716133855-ce7ef5c701ea/go.mod"
	"google.golang.org/genproto v0.0.0-20210728212813-7823e685a01f/go.mod"
	"google.golang.org/genproto v0.0.0-20210805201207-89edb61ffb67/go.mod"
	"google.golang.org/genproto v0.0.0-20210813162853-db860fec028c/go.mod"
	"google.golang.org/genproto v0.0.0-20210821163610-241b8fcbd6c8/go.mod"
	"google.golang.org/genproto v0.0.0-20210828152312-66f60bf46e71/go.mod"
	"google.golang.org/genproto v0.0.0-20210831024726-fe130286e0e2/go.mod"
	"google.golang.org/genproto v0.0.0-20210903162649-d08c68adba83/go.mod"
	"google.golang.org/genproto v0.0.0-20210909211513-a8c4777a87af/go.mod"
	"google.golang.org/genproto v0.0.0-20210924002016-3dee208752a0/go.mod"
	"google.golang.org/genproto v0.0.0-20211008145708-270636b82663/go.mod"
	"google.golang.org/genproto v0.0.0-20211028162531-8db9c33dc351/go.mod"
	"google.golang.org/genproto v0.0.0-20211118181313-81c1377c94b1/go.mod"
	"google.golang.org/genproto v0.0.0-20211129164237-f09f9a12af12/go.mod"
	"google.golang.org/genproto v0.0.0-20211203200212-54befc351ae9/go.mod"
	"google.golang.org/genproto v0.0.0-20211206160659-862468c7d6e0/go.mod"
	"google.golang.org/genproto v0.0.0-20211208223120-3a66f561d7aa/go.mod"
	"google.golang.org/grpc v1.19.0/go.mod"
	"google.golang.org/grpc v1.20.1/go.mod"
	"google.golang.org/grpc v1.21.1/go.mod"
	"google.golang.org/grpc v1.23.0/go.mod"
	"google.golang.org/grpc v1.25.1/go.mod"
	"google.golang.org/grpc v1.26.0/go.mod"
	"google.golang.org/grpc v1.27.0/go.mod"
	"google.golang.org/grpc v1.27.1/go.mod"
	"google.golang.org/grpc v1.28.0/go.mod"
	"google.golang.org/grpc v1.29.1/go.mod"
	"google.golang.org/grpc v1.30.0/go.mod"
	"google.golang.org/grpc v1.31.0/go.mod"
	"google.golang.org/grpc v1.31.1/go.mod"
	"google.golang.org/grpc v1.33.1/go.mod"
	"google.golang.org/grpc v1.33.2/go.mod"
	"google.golang.org/grpc v1.34.0/go.mod"
	"google.golang.org/grpc v1.35.0/go.mod"
	"google.golang.org/grpc v1.36.0/go.mod"
	"google.golang.org/grpc v1.36.1/go.mod"
	"google.golang.org/grpc v1.37.0/go.mod"
	"google.golang.org/grpc v1.37.1/go.mod"
	"google.golang.org/grpc v1.38.0/go.mod"
	"google.golang.org/grpc v1.39.0/go.mod"
	"google.golang.org/grpc v1.39.1/go.mod"
	"google.golang.org/grpc v1.40.0/go.mod"
	"google.golang.org/grpc v1.40.1/go.mod"
	"google.golang.org/grpc v1.42.0/go.mod"
	"google.golang.org/grpc v1.43.0/go.mod"
	"google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.1.0/go.mod"
	"google.golang.org/protobuf v0.0.0-20200109180630-ec00e32a8dfd/go.mod"
	"google.golang.org/protobuf v0.0.0-20200221191635-4d8936d0db64/go.mod"
	"google.golang.org/protobuf v0.0.0-20200228230310-ab0ca4ff8a60/go.mod"
	"google.golang.org/protobuf v1.20.1-0.20200309200217-e05f789c0967/go.mod"
	"google.golang.org/protobuf v1.21.0/go.mod"
	"google.golang.org/protobuf v1.22.0/go.mod"
	"google.golang.org/protobuf v1.23.0/go.mod"
	"google.golang.org/protobuf v1.23.1-0.20200526195155-81db48ad09cc/go.mod"
	"google.golang.org/protobuf v1.24.0/go.mod"
	"google.golang.org/protobuf v1.25.0/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.27.1/go.mod"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/errgo.v2 v2.1.0/go.mod"
	"gopkg.in/guregu/null.v4 v4.0.0"
	"gopkg.in/guregu/null.v4 v4.0.0/go.mod"
	"gopkg.in/ini.v1 v1.66.2/go.mod"
	"gopkg.in/ini.v1 v1.66.3/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/sourcemap.v1 v1.0.5"
	"gopkg.in/sourcemap.v1 v1.0.5/go.mod"
	"gopkg.in/yaml.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.3/go.mod"
	"gopkg.in/yaml.v2 v2.2.4/go.mod"
	"gopkg.in/yaml.v2 v2.2.5/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"honnef.co/go/tools v0.0.0-20190102054323-c2f93a96b099/go.mod"
	"honnef.co/go/tools v0.0.0-20190106161140-3f1c8253044a/go.mod"
	"honnef.co/go/tools v0.0.0-20190418001031-e561f6794a2a/go.mod"
	"honnef.co/go/tools v0.0.0-20190523083050-ea95bdfd59fc/go.mod"
	"honnef.co/go/tools v0.0.1-2019.2.3/go.mod"
	"honnef.co/go/tools v0.0.1-2020.1.3/go.mod"
	"honnef.co/go/tools v0.0.1-2020.1.4/go.mod"
	"rsc.io/binaryregexp v0.2.0/go.mod"
	"rsc.io/quote/v3 v3.1.0/go.mod"
	"rsc.io/sampler v1.3.0/go.mod"
)
go-module_set_globals
YARN_PKGS=(
	@ampproject/remapping-2.2.1
	@ant-design/react-slick-1.0.0
	@apollo/client-3.8.10
	@ardatan/relay-compiler-12.0.0
	@ardatan/sync-fetch-0.0.1
	@babel/code-frame-7.23.5
	@babel/compat-data-7.23.5
	@babel/core-7.23.9
	@babel/generator-7.23.6
	@babel/helper-annotate-as-pure-7.18.6
	@babel/helper-builder-binary-assignment-operator-visitor-7.18.9
	@babel/helper-compilation-targets-7.23.6
	@babel/helper-create-class-features-plugin-7.21.0
	@babel/helper-create-regexp-features-plugin-7.21.0
	@babel/helper-define-polyfill-provider-0.3.3
	@babel/helper-environment-visitor-7.22.20
	@babel/helper-explode-assignable-expression-7.18.6
	@babel/helper-function-name-7.23.0
	@babel/helper-hoist-variables-7.22.5
	@babel/helper-member-expression-to-functions-7.21.0
	@babel/helper-module-imports-7.22.15
	@babel/helper-module-transforms-7.23.3
	@babel/helper-optimise-call-expression-7.18.6
	@babel/helper-plugin-utils-7.20.2
	@babel/helper-remap-async-to-generator-7.18.9
	@babel/helper-replace-supers-7.20.7
	@babel/helper-simple-access-7.22.5
	@babel/helper-skip-transparent-expression-wrappers-7.20.0
	@babel/helper-split-export-declaration-7.22.6
	@babel/helper-string-parser-7.23.4
	@babel/helper-validator-identifier-7.22.20
	@babel/helper-validator-option-7.23.5
	@babel/helper-wrap-function-7.20.5
	@babel/helpers-7.23.9
	@babel/highlight-7.23.4
	@babel/parser-7.23.9
	@babel/plugin-bugfix-safari-id-destructuring-collision-in-function-expression-7.18.6
	@babel/plugin-bugfix-v8-spread-parameters-in-optional-chaining-7.20.7
	@babel/plugin-proposal-async-generator-functions-7.20.7
	@babel/plugin-proposal-class-properties-7.18.6
	@babel/plugin-proposal-class-static-block-7.21.0
	@babel/plugin-proposal-dynamic-import-7.18.6
	@babel/plugin-proposal-export-namespace-from-7.18.9
	@babel/plugin-proposal-json-strings-7.18.6
	@babel/plugin-proposal-logical-assignment-operators-7.20.7
	@babel/plugin-proposal-nullish-coalescing-operator-7.18.6
	@babel/plugin-proposal-numeric-separator-7.18.6
	@babel/plugin-proposal-object-rest-spread-7.20.7
	@babel/plugin-proposal-optional-catch-binding-7.18.6
	@babel/plugin-proposal-optional-chaining-7.21.0
	@babel/plugin-proposal-private-methods-7.18.6
	@babel/plugin-proposal-private-property-in-object-7.21.0
	@babel/plugin-proposal-unicode-property-regex-7.18.6
	@babel/plugin-syntax-async-generators-7.8.4
	@babel/plugin-syntax-class-properties-7.12.13
	@babel/plugin-syntax-class-static-block-7.14.5
	@babel/plugin-syntax-dynamic-import-7.8.3
	@babel/plugin-syntax-export-namespace-from-7.8.3
	@babel/plugin-syntax-flow-7.18.6
	@babel/plugin-syntax-import-assertions-7.20.0
	@babel/plugin-syntax-json-strings-7.8.3
	@babel/plugin-syntax-jsx-7.18.6
	@babel/plugin-syntax-logical-assignment-operators-7.10.4
	@babel/plugin-syntax-nullish-coalescing-operator-7.8.3
	@babel/plugin-syntax-numeric-separator-7.10.4
	@babel/plugin-syntax-object-rest-spread-7.8.3
	@babel/plugin-syntax-optional-catch-binding-7.8.3
	@babel/plugin-syntax-optional-chaining-7.8.3
	@babel/plugin-syntax-private-property-in-object-7.14.5
	@babel/plugin-syntax-top-level-await-7.14.5
	@babel/plugin-transform-arrow-functions-7.20.7
	@babel/plugin-transform-async-to-generator-7.20.7
	@babel/plugin-transform-block-scoped-functions-7.18.6
	@babel/plugin-transform-block-scoping-7.21.0
	@babel/plugin-transform-classes-7.21.0
	@babel/plugin-transform-computed-properties-7.20.7
	@babel/plugin-transform-destructuring-7.20.7
	@babel/plugin-transform-dotall-regex-7.18.6
	@babel/plugin-transform-duplicate-keys-7.18.9
	@babel/plugin-transform-exponentiation-operator-7.18.6
	@babel/plugin-transform-flow-strip-types-7.19.0
	@babel/plugin-transform-for-of-7.21.0
	@babel/plugin-transform-function-name-7.18.9
	@babel/plugin-transform-literals-7.18.9
	@babel/plugin-transform-member-expression-literals-7.18.6
	@babel/plugin-transform-modules-amd-7.20.11
	@babel/plugin-transform-modules-commonjs-7.20.11
	@babel/plugin-transform-modules-systemjs-7.20.11
	@babel/plugin-transform-modules-umd-7.18.6
	@babel/plugin-transform-named-capturing-groups-regex-7.20.5
	@babel/plugin-transform-new-target-7.18.6
	@babel/plugin-transform-object-super-7.18.6
	@babel/plugin-transform-parameters-7.20.7
	@babel/plugin-transform-property-literals-7.18.6
	@babel/plugin-transform-react-display-name-7.18.6
	@babel/plugin-transform-react-jsx-7.20.13
	@babel/plugin-transform-react-jsx-self-7.18.6
	@babel/plugin-transform-react-jsx-source-7.19.6
	@babel/plugin-transform-regenerator-7.20.5
	@babel/plugin-transform-reserved-words-7.18.6
	@babel/plugin-transform-shorthand-properties-7.18.6
	@babel/plugin-transform-spread-7.20.7
	@babel/plugin-transform-sticky-regex-7.18.6
	@babel/plugin-transform-template-literals-7.18.9
	@babel/plugin-transform-typeof-symbol-7.18.9
	@babel/plugin-transform-unicode-escapes-7.18.10
	@babel/plugin-transform-unicode-regex-7.18.6
	@babel/preset-env-7.20.2
	@babel/preset-modules-0.1.5
	@babel/regjsgen-0.8.0
	@babel/runtime-7.21.0
	@babel/template-7.23.9
	@babel/traverse-7.23.9
	@babel/types-7.23.9
	@cspotcode/source-map-support-0.8.1
	@csstools/css-parser-algorithms-2.3.0
	@csstools/css-tokenizer-2.1.1
	@csstools/media-query-list-parser-2.1.2
	@csstools/selector-specificity-3.0.0
	@emotion/babel-plugin-11.10.5
	@emotion/cache-11.10.5
	@emotion/hash-0.9.0
	@emotion/memoize-0.8.0
	@emotion/react-11.10.5
	@emotion/serialize-1.1.1
	@emotion/sheet-1.2.1
	@emotion/unitless-0.8.0
	@emotion/use-insertion-effect-with-fallbacks-1.0.0
	@emotion/utils-1.2.0
	@emotion/weak-memoize-0.3.0
	@esbuild/android-arm-0.18.20
	@esbuild/android-arm64-0.18.20
	@esbuild/android-x64-0.18.20
	@esbuild/darwin-arm64-0.18.20
	@esbuild/darwin-x64-0.18.20
	@esbuild/freebsd-arm64-0.18.20
	@esbuild/freebsd-x64-0.18.20
	@esbuild/linux-arm-0.18.20
	@esbuild/linux-arm64-0.18.20
	@esbuild/linux-ia32-0.18.20
	@esbuild/linux-loong64-0.18.20
	@esbuild/linux-mips64el-0.18.20
	@esbuild/linux-ppc64-0.18.20
	@esbuild/linux-riscv64-0.18.20
	@esbuild/linux-s390x-0.18.20
	@esbuild/linux-x64-0.18.20
	@esbuild/netbsd-x64-0.18.20
	@esbuild/openbsd-x64-0.18.20
	@esbuild/sunos-x64-0.18.20
	@esbuild/win32-arm64-0.18.20
	@esbuild/win32-ia32-0.18.20
	@esbuild/win32-x64-0.18.20
	@eslint/eslintrc-1.4.1
	@floating-ui/core-1.2.1
	@floating-ui/dom-1.2.1
	@formatjs/ecma402-abstract-1.14.3
	@formatjs/ecma402-abstract-1.4.0
	@formatjs/ecma402-abstract-1.5.0
	@formatjs/fast-memoize-1.2.8
	@formatjs/icu-messageformat-parser-2.2.0
	@formatjs/icu-skeleton-parser-1.3.18
	@formatjs/intl-2.6.5
	@formatjs/intl-displaynames-6.2.4
	@formatjs/intl-getcanonicallocales-2.0.5
	@formatjs/intl-listformat-7.1.7
	@formatjs/intl-locale-3.0.11
	@formatjs/intl-localematcher-0.2.32
	@formatjs/intl-numberformat-5.7.6
	@formatjs/intl-numberformat-8.3.3
	@formatjs/intl-pluralrules-5.1.8
	@formatjs/ts-transformer-2.13.0
	@fortawesome/fontawesome-common-types-6.3.0
	@fortawesome/fontawesome-svg-core-6.3.0
	@fortawesome/free-brands-svg-icons-6.3.0
	@fortawesome/free-regular-svg-icons-6.3.0
	@fortawesome/free-solid-svg-icons-6.3.0
	@fortawesome/react-fontawesome-0.2.0
	@graphql-codegen/cli-5.0.0
	@graphql-codegen/core-4.0.0
	@graphql-codegen/plugin-helpers-2.7.2
	@graphql-codegen/plugin-helpers-3.1.2
	@graphql-codegen/plugin-helpers-5.0.1
	@graphql-codegen/schema-ast-4.0.0
	@graphql-codegen/time-5.0.0
	@graphql-codegen/typescript-4.0.1
	@graphql-codegen/typescript-operations-4.0.1
	@graphql-codegen/typescript-react-apollo-4.1.0
	@graphql-codegen/visitor-plugin-common-2.13.1
	@graphql-codegen/visitor-plugin-common-4.0.1
	@graphql-tools/apollo-engine-loader-8.0.0
	@graphql-tools/batch-execute-9.0.2
	@graphql-tools/code-file-loader-8.1.0
	@graphql-tools/delegate-10.0.3
	@graphql-tools/executor-1.2.0
	@graphql-tools/executor-graphql-ws-1.1.0
	@graphql-tools/executor-http-1.0.7
	@graphql-tools/executor-legacy-ws-1.0.5
	@graphql-tools/git-loader-8.0.4
	@graphql-tools/github-loader-8.0.0
	@graphql-tools/graphql-file-loader-8.0.0
	@graphql-tools/graphql-tag-pluck-8.2.0
	@graphql-tools/import-7.0.0
	@graphql-tools/json-file-loader-8.0.0
	@graphql-tools/load-8.0.1
	@graphql-tools/merge-9.0.1
	@graphql-tools/optimize-1.3.1
	@graphql-tools/optimize-2.0.0
	@graphql-tools/prisma-loader-8.0.2
	@graphql-tools/relay-operation-optimizer-6.5.17
	@graphql-tools/relay-operation-optimizer-7.0.0
	@graphql-tools/schema-10.0.2
	@graphql-tools/url-loader-8.0.1
	@graphql-tools/utils-10.0.13
	@graphql-tools/utils-8.13.1
	@graphql-tools/utils-9.2.1
	@graphql-tools/wrap-10.0.1
	@graphql-typed-document-node/core-3.2.0
	@humanwhocodes/config-array-0.11.8
	@humanwhocodes/module-importer-1.0.1
	@humanwhocodes/object-schema-1.2.1
	@jridgewell/gen-mapping-0.3.2
	@jridgewell/resolve-uri-3.1.0
	@jridgewell/set-array-1.1.2
	@jridgewell/source-map-0.3.2
	@jridgewell/sourcemap-codec-1.4.14
	@jridgewell/trace-mapping-0.3.17
	@jridgewell/trace-mapping-0.3.9
	@juggle/resize-observer-3.4.0
	@kamilkisiela/fast-url-parser-1.1.4
	@mapbox/hast-util-table-cell-style-0.2.0
	@nodelib/fs.scandir-2.1.5
	@nodelib/fs.stat-2.0.5
	@nodelib/fs.walk-1.2.8
	@peculiar/asn1-schema-2.3.3
	@peculiar/json-schema-1.1.12
	@peculiar/webcrypto-1.4.1
	@popperjs/core-2.11.6
	@react-hook/latest-1.0.3
	@react-hook/passive-layout-effect-1.2.1
	@react-hook/resize-observer-1.2.6
	@repeaterjs/repeater-3.0.4
	@restart/context-2.1.4
	@restart/hooks-0.4.9
	@silvermine/videojs-airplay-1.2.0
	@silvermine/videojs-chromecast-1.4.1
	@tsconfig/node10-1.0.9
	@tsconfig/node12-1.0.11
	@tsconfig/node14-1.0.3
	@tsconfig/node16-1.0.3
	@tweenjs/tween.js-18.6.4
	@types/apollo-upload-client-18.0.0
	@types/babel__core-7.20.0
	@types/babel__generator-7.6.4
	@types/babel__template-7.4.1
	@types/babel__traverse-7.18.3
	@types/cookie-0.3.3
	@types/extract-files-13.0.1
	@types/fs-extra-9.0.13
	@types/history-4.7.11
	@types/hoist-non-react-statics-3.3.1
	@types/invariant-2.2.35
	@types/js-yaml-4.0.5
	@types/json-schema-7.0.11
	@types/json-stable-stringify-1.0.34
	@types/json5-0.0.29
	@types/lodash-4.14.191
	@types/lodash-es-4.17.6
	@types/mdast-3.0.10
	@types/minimist-1.2.2
	@types/mousetrap-1.6.11
	@types/node-18.13.0
	@types/normalize-package-data-2.4.1
	@types/parse-json-4.0.0
	@types/prop-types-15.7.5
	@types/react-17.0.53
	@types/react-datepicker-4.10.0
	@types/react-dom-17.0.19
	@types/react-helmet-6.1.6
	@types/react-router-5.1.20
	@types/react-router-bootstrap-0.24.5
	@types/react-router-dom-5.3.3
	@types/react-router-hash-link-2.4.5
	@types/react-transition-group-4.4.5
	@types/scheduler-0.16.2
	@types/schema-utils-2.4.0
	@types/semver-7.3.13
	@types/stats.js-0.17.0
	@types/three-0.154.0
	@types/ua-parser-js-0.7.36
	@types/unist-2.0.6
	@types/video.js-7.3.51
	@types/videojs-mobile-ui-0.8.0
	@types/videojs-seek-buttons-2.1.0
	@types/warning-3.0.0
	@types/webxr-0.5.2
	@types/ws-8.5.4
	@typescript-eslint/eslint-plugin-5.52.0
	@typescript-eslint/parser-5.52.0
	@typescript-eslint/scope-manager-5.52.0
	@typescript-eslint/type-utils-5.52.0
	@typescript-eslint/types-5.52.0
	@typescript-eslint/typescript-estree-5.52.0
	@typescript-eslint/utils-5.52.0
	@typescript-eslint/visitor-keys-5.52.0
	@videojs/http-streaming-2.16.2
	@videojs/vhs-utils-3.0.5
	@videojs/xhr-2.6.0
	@vitejs/plugin-legacy-4.0.1
	@vitejs/plugin-react-3.1.0
	@whatwg-node/events-0.0.2
	@whatwg-node/events-0.1.1
	@whatwg-node/fetch-0.8.1
	@whatwg-node/fetch-0.9.16
	@whatwg-node/node-fetch-0.3.0
	@whatwg-node/node-fetch-0.5.5
	@wry/caches-1.0.1
	@wry/context-0.7.0
	@wry/equality-0.5.7
	@wry/trie-0.4.3
	@wry/trie-0.5.0
	@xmldom/xmldom-0.8.6
	acorn-8.8.2
	acorn-jsx-5.3.2
	acorn-walk-8.2.0
	aes-decrypter-3.1.3
	agent-base-7.1.0
	aggregate-error-3.1.0
	ajv-6.12.6
	ajv-8.12.0
	ajv-formats-2.1.1
	ajv-keywords-3.5.2
	ajv-keywords-5.1.0
	ansi-escapes-4.3.2
	ansi-regex-5.0.1
	ansi-styles-3.2.1
	ansi-styles-4.3.0
	anymatch-3.1.3
	apollo-upload-client-18.0.1
	arg-4.1.3
	argparse-1.0.10
	argparse-2.0.1
	aria-query-5.1.3
	array-includes-3.1.6
	array-union-2.1.0
	array.prototype.flat-1.3.1
	array.prototype.flatmap-1.3.1
	array.prototype.tosorted-1.1.1
	arrify-1.0.1
	asap-2.0.6
	asn1js-3.0.5
	ast-types-flow-0.0.7
	astral-regex-2.0.0
	at-least-node-1.0.0
	auto-bind-4.0.0
	available-typed-arrays-1.0.5
	axe-core-4.6.3
	axobject-query-3.1.1
	b64-to-blob-1.2.19
	babel-plugin-macros-3.1.0
	babel-plugin-polyfill-corejs2-0.3.3
	babel-plugin-polyfill-corejs3-0.6.0
	babel-plugin-polyfill-regenerator-0.4.1
	babel-plugin-react-intl-7.9.4
	babel-plugin-syntax-trailing-function-commas-7.0.0-beta.0
	babel-preset-fbjs-3.4.0
	bail-1.0.5
	balanced-match-1.0.2
	balanced-match-2.0.0
	base64-blob-1.4.1
	base64-js-1.5.1
	bcp-47-1.0.8
	bcp-47-match-1.0.3
	bcp-47-normalize-1.1.1
	binary-extensions-2.2.0
	bl-4.1.0
	bootstrap-4.6.2
	brace-expansion-1.1.11
	braces-3.0.2
	browserslist-4.22.3
	bser-2.1.1
	buffer-5.7.1
	buffer-from-1.1.2
	busboy-1.6.0
	call-bind-1.0.2
	callsites-3.1.0
	camel-case-4.1.2
	camelcase-5.3.1
	camelcase-6.3.0
	camelcase-keys-6.2.2
	camelcase-keys-7.0.2
	caniuse-lite-1.0.30001580
	capital-case-1.0.4
	cardboard-vr-display-1.0.19
	ccount-1.1.0
	chalk-2.4.2
	chalk-4.1.2
	change-case-4.1.2
	change-case-all-1.0.14
	change-case-all-1.0.15
	character-entities-1.2.4
	character-entities-legacy-1.1.4
	character-reference-invalid-1.1.4
	chardet-0.7.0
	chokidar-3.5.3
	classnames-2.3.2
	clean-stack-2.2.0
	cli-cursor-3.1.0
	cli-spinners-2.7.0
	cli-truncate-2.1.0
	cli-width-3.0.0
	cliui-6.0.0
	cliui-8.0.1
	clone-1.0.4
	codem-isoboxer-0.3.6
	color-convert-1.9.3
	color-convert-2.0.1
	color-name-1.1.3
	color-name-1.1.4
	colord-2.9.3
	colorette-2.0.19
	comma-separated-tokens-1.0.8
	commander-2.20.3
	common-tags-1.8.2
	concat-map-0.0.1
	confusing-browser-globals-1.0.11
	constant-case-3.0.4
	convert-source-map-1.9.0
	convert-source-map-2.0.0
	cookie-0.4.2
	core-js-3.28.0
	core-js-compat-3.28.0
	cosmiconfig-7.1.0
	cosmiconfig-8.3.6
	create-require-1.1.1
	cross-fetch-3.1.5
	cross-inspect-1.0.0
	cross-spawn-7.0.3
	css-functions-list-3.1.0
	css-tree-2.3.1
	cssesc-3.0.0
	csstype-3.1.1
	damerau-levenshtein-1.0.8
	dashjs-4.6.0
	dataloader-2.2.2
	date-fns-2.29.3
	debounce-1.2.1
	debug-3.2.7
	debug-4.3.4
	decamelize-1.2.0
	decamelize-5.0.1
	decamelize-keys-1.1.1
	deep-equal-2.2.0
	deep-is-0.1.4
	deepmerge-2.2.1
	defaults-1.0.4
	define-properties-1.2.0
	dependency-graph-0.11.0
	dequal-2.0.3
	detect-indent-6.1.0
	diacritics-1.3.0
	diff-4.0.2
	dir-glob-3.0.1
	doctrine-2.1.0
	doctrine-3.0.0
	dom-helpers-5.2.1
	dom-walk-0.1.2
	dot-case-3.0.4
	dotenv-16.0.3
	dset-3.1.2
	electron-to-chromium-1.4.648
	emoji-regex-8.0.0
	emoji-regex-9.2.2
	error-ex-1.3.2
	es-abstract-1.21.1
	es-get-iterator-1.1.3
	es-set-tostringtag-2.0.1
	es-shim-unscopables-1.0.0
	es-to-primitive-1.2.1
	es6-promise-4.2.8
	esbuild-0.18.20
	escalade-3.1.1
	escape-string-regexp-1.0.5
	escape-string-regexp-4.0.0
	eslint-8.34.0
	eslint-config-airbnb-19.0.4
	eslint-config-airbnb-base-15.0.0
	eslint-config-airbnb-typescript-17.0.0
	eslint-config-prettier-8.6.0
	eslint-import-resolver-node-0.3.7
	eslint-module-utils-2.7.4
	eslint-plugin-import-2.27.5
	eslint-plugin-jsx-a11y-6.7.1
	eslint-plugin-react-7.32.2
	eslint-plugin-react-hooks-4.6.0
	eslint-scope-5.1.1
	eslint-scope-7.1.1
	eslint-utils-3.0.0
	eslint-visitor-keys-2.1.0
	eslint-visitor-keys-3.3.0
	espree-9.4.1
	esprima-4.0.1
	esquery-1.4.1
	esrecurse-4.3.0
	estraverse-4.3.0
	estraverse-5.3.0
	esutils-2.0.3
	extend-3.0.2
	external-editor-3.1.0
	extract-files-11.0.0
	extract-files-13.0.0
	extract-react-intl-messages-4.1.1
	fast-decode-uri-component-1.0.1
	fast-deep-equal-2.0.1
	fast-deep-equal-3.1.3
	fast-glob-3.3.0
	fast-json-stable-stringify-2.1.0
	fast-levenshtein-2.0.6
	fast-querystring-1.1.1
	fast-url-parser-1.1.3
	fastest-levenshtein-1.0.16
	fastq-1.15.0
	fb-watchman-2.0.2
	fbjs-3.0.4
	fbjs-css-vars-1.0.2
	fflate-0.6.10
	figures-3.2.0
	file-entry-cache-6.0.1
	fill-range-7.0.1
	find-root-1.1.0
	find-up-4.1.0
	find-up-5.0.0
	flag-icons-6.6.6
	flat-5.0.2
	flat-cache-3.0.4
	flatted-3.2.7
	flexbin-0.2.0
	for-each-0.3.3
	formik-2.4.5
	fs-extra-10.1.0
	fs-extra-9.1.0
	fs.realpath-1.0.0
	fsevents-2.3.3
	function-bind-1.1.2
	function.prototype.name-1.1.5
	functions-have-names-1.2.3
	gensync-1.0.0-beta.2
	get-caller-file-2.0.5
	get-intrinsic-1.2.0
	get-symbol-description-1.0.0
	gl-preserve-state-1.0.0
	glob-7.2.3
	glob-parent-5.1.2
	glob-parent-6.0.2
	global-4.4.0
	global-modules-2.0.0
	global-prefix-3.0.0
	globals-11.12.0
	globals-13.20.0
	globalthis-1.0.3
	globby-11.1.0
	globjoin-0.1.4
	globrex-0.1.2
	gopd-1.0.1
	graceful-fs-4.2.10
	grapheme-splitter-1.0.4
	graphql-16.8.1
	graphql-config-5.0.3
	graphql-request-6.1.0
	graphql-tag-2.12.6
	graphql-ws-5.14.3
	hard-rejection-2.1.0
	has-1.0.4
	has-bigints-1.0.2
	has-flag-3.0.0
	has-flag-4.0.0
	has-property-descriptors-1.0.0
	has-proto-1.0.1
	has-symbols-1.0.3
	has-tostringtag-1.0.0
	hast-to-hyperscript-9.0.1
	header-case-2.0.4
	history-4.10.1
	hoist-non-react-statics-3.3.2
	hosted-git-info-2.8.9
	hosted-git-info-4.1.0
	html-entities-1.4.0
	html-tags-3.3.1
	http-proxy-agent-7.0.0
	https-proxy-agent-7.0.2
	i18n-iso-countries-7.5.0
	iconv-lite-0.4.24
	ieee754-1.2.1
	ignore-5.2.4
	immediate-3.0.6
	immutable-3.7.6
	immutable-4.2.4
	import-fresh-3.3.0
	import-from-4.0.0
	import-lazy-4.0.0
	imsc-1.1.3
	imurmurhash-0.1.4
	indent-string-4.0.0
	indent-string-5.0.0
	individual-2.0.0
	inflight-1.0.6
	inherits-2.0.4
	ini-1.3.8
	inline-style-parser-0.1.1
	inquirer-8.2.5
	internal-slot-1.0.5
	intersection-observer-0.12.2
	intl-messageformat-10.3.0
	intl-messageformat-parser-5.5.1
	intl-messageformat-parser-6.1.2
	invariant-2.2.4
	is-absolute-1.0.0
	is-alphabetical-1.0.4
	is-alphanumerical-1.0.4
	is-arguments-1.1.1
	is-array-buffer-3.0.1
	is-arrayish-0.2.1
	is-bigint-1.0.4
	is-binary-path-2.1.0
	is-boolean-object-1.1.2
	is-buffer-2.0.5
	is-callable-1.2.7
	is-core-module-2.13.0
	is-date-object-1.0.5
	is-decimal-1.0.4
	is-extglob-2.1.1
	is-fullwidth-code-point-3.0.0
	is-function-1.0.2
	is-glob-4.0.3
	is-hexadecimal-1.0.4
	is-interactive-1.0.0
	is-lower-case-2.0.2
	is-map-2.0.2
	is-negative-zero-2.0.2
	is-number-7.0.0
	is-number-object-1.0.7
	is-path-inside-3.0.3
	is-plain-obj-1.1.0
	is-plain-obj-2.1.0
	is-plain-obj-4.1.0
	is-plain-object-5.0.0
	is-regex-1.1.4
	is-relative-1.0.0
	is-set-2.0.2
	is-shared-array-buffer-1.0.2
	is-string-1.0.7
	is-symbol-1.0.4
	is-typed-array-1.1.10
	is-typedarray-1.0.0
	is-unc-path-1.0.0
	is-unicode-supported-0.1.0
	is-upper-case-2.0.2
	is-weakmap-2.0.1
	is-weakref-1.0.2
	is-weakset-2.0.2
	is-windows-1.0.2
	isarray-0.0.1
	isarray-2.0.5
	isexe-2.0.0
	isomorphic-ws-5.0.0
	jiti-1.21.0
	jose-5.2.0
	js-sdsl-4.3.0
	js-tokens-4.0.0
	js-yaml-3.14.1
	js-yaml-4.1.0
	jsesc-0.5.0
	jsesc-2.5.2
	json-parse-even-better-errors-2.3.1
	json-schema-traverse-0.4.1
	json-schema-traverse-1.0.0
	json-stable-stringify-1.0.2
	json-stable-stringify-without-jsonify-1.0.1
	json-to-pretty-yaml-1.2.2
	json2mq-0.2.0
	json5-1.0.2
	json5-2.2.3
	jsonfile-6.1.0
	jsonify-0.0.1
	jsx-ast-utils-3.3.3
	keycode-2.2.1
	kind-of-6.0.3
	known-css-properties-0.27.0
	language-subtag-registry-0.3.22
	language-tags-1.0.5
	levn-0.4.1
	lie-3.1.1
	lil-gui-0.17.0
	lines-and-columns-1.2.4
	listr2-4.0.5
	load-json-file-6.2.0
	localforage-1.10.0
	locate-path-5.0.0
	locate-path-6.0.0
	lodash-4.17.21
	lodash-es-4.17.21
	lodash.debounce-4.0.8
	lodash.merge-4.6.2
	lodash.mergewith-4.6.2
	lodash.pick-4.4.0
	lodash.truncate-4.4.2
	log-symbols-4.1.0
	log-update-4.0.0
	longest-streak-2.0.4
	loose-envify-1.4.0
	lower-case-2.0.2
	lower-case-first-2.0.2
	lru-cache-5.1.1
	lru-cache-6.0.0
	m3u8-parser-4.8.0
	magic-string-0.27.0
	make-dir-3.1.0
	make-error-1.3.6
	map-cache-0.2.2
	map-obj-1.0.1
	map-obj-4.3.0
	markdown-table-2.0.0
	mathml-tag-names-2.1.3
	mdast-util-definitions-4.0.0
	mdast-util-find-and-replace-1.1.1
	mdast-util-from-markdown-0.8.5
	mdast-util-gfm-0.1.2
	mdast-util-gfm-autolink-literal-0.1.3
	mdast-util-gfm-strikethrough-0.2.3
	mdast-util-gfm-table-0.1.6
	mdast-util-gfm-task-list-item-0.1.6
	mdast-util-to-hast-10.2.0
	mdast-util-to-markdown-0.6.5
	mdast-util-to-string-2.0.0
	mdn-data-2.0.30
	mdurl-1.0.1
	memoize-one-6.0.0
	meow-10.1.5
	meow-6.1.1
	merge2-1.4.1
	meros-1.2.1
	meshoptimizer-0.18.1
	micromark-2.11.4
	micromark-extension-gfm-0.3.3
	micromark-extension-gfm-autolink-literal-0.5.7
	micromark-extension-gfm-strikethrough-0.6.5
	micromark-extension-gfm-table-0.4.3
	micromark-extension-gfm-tagfilter-0.3.0
	micromark-extension-gfm-task-list-item-0.3.3
	micromatch-4.0.5
	mimic-fn-2.1.0
	min-document-2.19.0
	min-indent-1.0.1
	minimatch-3.1.2
	minimatch-4.2.3
	minimist-1.2.8
	minimist-options-4.1.0
	mkdirp-1.0.4
	moment-2.29.4
	mousetrap-1.6.5
	mousetrap-pause-1.0.0
	mpd-parser-0.22.1
	ms-2.1.2
	ms-2.1.3
	mute-stream-0.0.8
	mux.js-6.0.1
	nanoid-3.3.6
	natural-compare-1.4.0
	natural-compare-lite-1.4.0
	no-case-3.0.4
	node-fetch-2.6.7
	node-fetch-2.6.9
	node-int64-0.4.0
	node-releases-2.0.14
	normalize-package-data-2.5.0
	normalize-package-data-3.0.3
	normalize-path-2.1.1
	normalize-path-3.0.0
	normalize-url-4.5.1
	nosleep.js-0.7.0
	nullthrows-1.1.1
	object-assign-4.1.1
	object-inspect-1.12.3
	object-is-1.1.5
	object-keys-1.1.1
	object.assign-4.1.4
	object.entries-1.1.6
	object.fromentries-2.0.6
	object.hasown-1.1.2
	object.values-1.1.6
	once-1.4.0
	onetime-5.1.2
	optimism-0.18.0
	optionator-0.9.1
	ora-5.4.1
	os-tmpdir-1.0.2
	p-limit-2.3.0
	p-limit-3.1.0
	p-locate-4.1.0
	p-locate-5.0.0
	p-map-4.0.0
	p-try-2.2.0
	param-case-3.0.4
	parent-module-1.0.1
	parse-entities-2.0.0
	parse-filepath-1.0.2
	parse-json-5.2.0
	pascal-case-3.1.2
	path-browserify-1.0.1
	path-case-3.0.4
	path-exists-4.0.0
	path-is-absolute-1.0.1
	path-key-3.1.1
	path-parse-1.0.7
	path-root-0.1.1
	path-root-regex-0.1.2
	path-to-regexp-1.8.0
	path-type-4.0.0
	picocolors-1.0.0
	picomatch-2.3.1
	pify-5.0.0
	pkcs7-1.0.4
	postcss-8.4.31
	postcss-resolve-nested-selector-0.1.1
	postcss-safe-parser-6.0.0
	postcss-scss-4.0.6
	postcss-selector-parser-6.0.13
	postcss-sorting-8.0.1
	postcss-value-parser-4.2.0
	prelude-ls-1.2.1
	prettier-2.8.4
	process-0.11.10
	promise-7.3.1
	prop-types-15.7.2
	prop-types-15.8.1
	prop-types-extra-1.1.1
	property-expr-2.0.5
	property-information-5.6.0
	punycode-1.4.1
	punycode-2.3.0
	pvtsutils-1.3.2
	pvutils-1.1.3
	queue-microtask-1.2.3
	quick-lru-4.0.1
	quick-lru-5.1.1
	react-17.0.2
	react-bootstrap-1.6.6
	react-datepicker-4.10.0
	react-dom-17.0.2
	react-fast-compare-2.0.4
	react-fast-compare-3.2.1
	react-helmet-6.1.0
	react-intl-6.2.8
	react-is-16.13.1
	react-lifecycles-compat-3.0.4
	react-onclickoutside-6.12.2
	react-overlays-5.2.1
	react-photo-gallery-8.0.0
	react-popper-2.3.0
	react-refresh-0.14.0
	react-remark-2.1.0
	react-router-5.3.4
	react-router-bootstrap-0.25.0
	react-router-dom-5.3.4
	react-router-hash-link-2.4.3
	react-select-5.7.0
	react-side-effect-2.1.2
	react-transition-group-4.4.5
	read-babelrc-up-1.1.0
	read-pkg-5.2.0
	read-pkg-6.0.0
	read-pkg-up-7.0.1
	read-pkg-up-8.0.0
	readable-stream-3.6.0
	readdirp-3.6.0
	redent-3.0.0
	redent-4.0.0
	regenerate-1.4.2
	regenerate-unicode-properties-10.1.0
	regenerator-runtime-0.13.11
	regenerator-transform-0.15.1
	regexp.prototype.flags-1.4.3
	regexpp-3.2.0
	regexpu-core-5.3.1
	regjsparser-0.9.1
	rehype-react-6.2.1
	relay-runtime-12.0.0
	remark-gfm-1.0.0
	remark-parse-9.0.0
	remark-rehype-8.1.0
	remedial-1.0.8
	remove-trailing-separator-1.1.0
	remove-trailing-spaces-1.0.8
	repeat-string-1.6.1
	require-directory-2.1.1
	require-from-string-2.0.2
	require-main-filename-2.0.0
	resize-observer-polyfill-1.5.1
	resolve-1.22.8
	resolve-2.0.0-next.4
	resolve-from-4.0.0
	resolve-from-5.0.0
	resolve-pathname-3.0.0
	response-iterator-0.2.6
	restore-cursor-3.1.0
	reusify-1.0.4
	rfdc-1.3.0
	rimraf-3.0.2
	rollup-3.29.4
	run-async-2.4.1
	run-parallel-1.2.0
	rust-result-1.0.0
	rxjs-7.8.0
	safe-buffer-5.2.1
	safe-json-parse-4.0.0
	safe-regex-test-1.0.0
	safer-buffer-2.1.2
	sass-1.58.1
	sax-1.2.1
	scheduler-0.20.2
	schema-utils-2.7.1
	schema-utils-4.0.0
	scuid-1.1.0
	semver-5.7.2
	semver-6.3.1
	semver-7.5.4
	sentence-case-3.0.4
	set-blocking-2.0.0
	setimmediate-1.0.5
	shebang-command-2.0.0
	shebang-regex-3.0.0
	shell-quote-1.8.0
	side-channel-1.0.4
	signal-exit-3.0.7
	signal-exit-4.0.2
	signedsource-1.0.0
	slash-3.0.0
	slice-ansi-3.0.0
	slice-ansi-4.0.0
	slick-carousel-1.8.1
	snake-case-3.0.4
	sort-keys-4.2.0
	source-map-0.5.7
	source-map-0.6.1
	source-map-js-1.0.2
	source-map-support-0.5.21
	space-separated-tokens-1.1.5
	spdx-correct-3.1.1
	spdx-exceptions-2.3.0
	spdx-expression-parse-3.0.1
	spdx-license-ids-3.0.12
	sponge-case-1.0.1
	sprintf-js-1.0.3
	stop-iteration-iterator-1.0.0
	streamsearch-1.1.0
	string-convert-0.2.1
	string-env-interpolation-1.0.1
	string-width-4.2.3
	string.prototype.matchall-4.0.8
	string.prototype.replaceall-1.0.7
	string.prototype.trimend-1.0.6
	string.prototype.trimstart-1.0.6
	string_decoder-1.3.0
	strip-ansi-6.0.1
	strip-bom-3.0.0
	strip-bom-4.0.0
	strip-indent-3.0.0
	strip-indent-4.0.0
	strip-json-comments-3.1.1
	style-search-0.1.0
	style-to-object-0.3.0
	stylelint-15.10.1
	stylelint-order-6.0.2
	stylis-4.1.3
	supports-color-5.5.0
	supports-color-7.2.0
	supports-hyperlinks-3.0.0
	supports-preserve-symlinks-flag-1.0.0
	svg-tags-1.0.0
	swap-case-2.0.2
	symbol-observable-4.0.0
	systemjs-6.13.0
	table-6.8.1
	terser-5.16.4
	text-table-0.2.0
	thehandy-1.0.3
	three-0.93.0
	throttle-debounce-5.0.0
	through-2.3.8
	tiny-case-1.0.3
	tiny-invariant-1.3.1
	tiny-warning-1.0.3
	title-case-3.0.3
	tmp-0.0.33
	to-fast-properties-2.0.0
	to-regex-range-5.0.1
	toposort-2.0.2
	tr46-0.0.3
	trim-newlines-3.0.1
	trim-newlines-4.1.1
	trough-1.0.5
	ts-invariant-0.10.3
	ts-log-2.2.5
	ts-node-10.9.1
	tsconfck-2.0.2
	tsconfig-paths-3.14.1
	tslib-1.14.1
	tslib-2.4.1
	tslib-2.5.0
	tslib-2.6.2
	tsutils-3.21.0
	type-check-0.4.0
	type-fest-0.13.1
	type-fest-0.20.2
	type-fest-0.21.3
	type-fest-0.6.0
	type-fest-0.8.1
	type-fest-1.4.0
	type-fest-2.19.0
	typed-array-length-1.0.4
	typedarray-to-buffer-3.1.5
	typescript-4.8.4
	ua-parser-js-0.7.33
	ua-parser-js-1.0.34
	unbox-primitive-1.0.2
	unc-path-regex-0.1.2
	uncontrollable-7.2.1
	unicode-canonical-property-names-ecmascript-2.0.0
	unicode-match-property-ecmascript-2.0.0
	unicode-match-property-value-ecmascript-2.1.0
	unicode-property-aliases-ecmascript-2.1.0
	unified-9.2.2
	unist-builder-2.0.3
	unist-util-generated-1.1.6
	unist-util-is-3.0.0
	unist-util-is-4.1.0
	unist-util-position-3.1.0
	unist-util-stringify-position-2.0.3
	unist-util-visit-1.4.1
	unist-util-visit-2.0.3
	unist-util-visit-parents-2.1.2
	unist-util-visit-parents-3.1.1
	universal-cookie-4.0.4
	universalify-2.0.0
	unixify-1.0.0
	update-browserslist-db-1.0.13
	upper-case-2.0.2
	upper-case-first-2.0.2
	uri-js-4.4.1
	url-toolkit-2.2.5
	urlpattern-polyfill-10.0.0
	urlpattern-polyfill-6.0.2
	use-isomorphic-layout-effect-1.1.2
	util-deprecate-1.0.2
	v8-compile-cache-lib-3.0.1
	validate-npm-package-license-3.0.4
	value-equal-1.0.1
	value-or-promise-1.0.12
	vfile-4.2.1
	vfile-message-2.0.4
	video.js-7.21.3
	videojs-abloop-1.2.0
	videojs-contrib-dash-5.1.1
	videojs-font-3.2.0
	videojs-mobile-ui-0.8.0
	videojs-seek-buttons-3.0.1
	videojs-vr-1.8.0
	videojs-vtt.js-0.15.4
	vite-4.5.2
	vite-plugin-compression-0.5.1
	vite-tsconfig-paths-4.0.5
	warning-4.0.3
	wcwidth-1.0.1
	web-namespaces-1.1.4
	web-streams-polyfill-3.2.1
	webcomponents.js-0.7.24
	webcrypto-core-1.7.6
	webidl-conversions-3.0.1
	webvr-polyfill-0.10.12
	webvr-polyfill-dpdb-1.0.18
	whatwg-url-5.0.0
	which-1.3.1
	which-2.0.2
	which-boxed-primitive-1.0.2
	which-collection-1.0.1
	which-module-2.0.0
	which-typed-array-1.1.9
	word-wrap-1.2.4
	wrap-ansi-6.2.0
	wrap-ansi-7.0.0
	wrappy-1.0.2
	write-file-atomic-3.0.3
	write-file-atomic-5.0.1
	write-json-file-4.3.0
	ws-8.16.0
	xtend-4.0.2
	y18n-4.0.3
	y18n-5.0.8
	yallist-3.1.1
	yallist-4.0.0
	yaml-1.10.2
	yaml-2.3.4
	yaml-ast-parser-0.0.43
	yargs-15.4.1
	yargs-17.6.2
	yargs-parser-18.1.3
	yargs-parser-20.2.9
	yargs-parser-21.1.1
	yn-3.1.1
	yocto-queue-0.1.0
	yup-1.3.2
	zen-observable-0.8.15
	zen-observable-ts-1.2.5
	zwitch-1.0.5
)
yarn_set_globals
DESCRIPTION="An organiser for your special videos, written in Go."
HOMEPAGE="https://github.com/stashapp/stash https://docs.stashapp.cc/"
SRC_URI="https://github.com/stashapp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
	${YARN_SRC_URI}"
UI_PV="2.5"

LICENSE="AGPL-3 MIT 0BSD Apache-2.0 Apache-2.0 WITH LLVM-exception BSD-2-Clause BSD-3-Clause CC-BY-3.0 CC-BY-4.0 CC0-1.0 GPL-3 ISC MIT-0 MPL-2.0 Public Domain Python-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg"

PATCHES=( "${FILESDIR}/${PN}-0001-makefile-remove-ui-steps.patch" )

_go-module_src_unpack_gosum_no_unpack() {
	# shellcheck disable=SC2120
	debug-print-function "${FUNCNAME[0]}"

	if [[ ! ${_GO_MODULE_SET_GLOBALS_CALLED} ]]; then
		die "go-module_set_globals must be called in global scope"
	fi
	local goproxy_dir="${GOPROXY/file:\/\//}"
	mkdir -p "${goproxy_dir}" || die
	# For each Golang module distfile, look up where it's supposed to go, and
	# symlink into place.
	local f
	local goproxy_mod_dir
	for f in ${A}; do
		goproxy_mod_path="${_GOMODULE_GOSUM_REVERSE_MAP["${f}"]}"
		if [[ -n "${goproxy_mod_path}" ]]; then
			debug-print-function "Populating go proxy for ${goproxy_mod_path}"
			# Build symlink hierarchy
			goproxy_mod_dir=$( dirname "${goproxy_dir}"/"${goproxy_mod_path}" )
			mkdir -p "${goproxy_mod_dir}" || die
			ln -sf "${DISTDIR}/${f}" "${goproxy_dir}/${goproxy_mod_path}" ||
				die "Failed to ln"
			local v=${goproxy_mod_path}
			v="${v%.mod}"
			v="${v%.zip}"
			v="${v//*\/}"
			_go-module_gosum_synthesize_files "${goproxy_mod_dir}" "${v}"
		fi
	done
	# Validate the gosum now
	_go-module_src_unpack_verify_gosum
}

src_unpack() {
	unpack "${P}.tar.gz"
	_go-module_src_unpack_gosum_no_unpack
}

src_compile() {
	# Complete override because we only care about the static files generated by building the React
    # app.
	cd "ui/v${UI_PV}" || die
	cp "${YARN_PACKAGE_JSON:-${FILESDIR}/${PN}-ui-package.json}" package.json || die
	cp "${YARN_LOCK:-${FILESDIR}/${PN}-ui-yarn.lock}" yarn.lock || die
	# Note no --production below
	edo env \
		"npm_config_jobs=$(makeopts_jobs)" \
		npm_config_verbose=true \
		npm_config_release=true \
		"npm_config_nodedir=${EPREFIX}/usr/include/node" \
		yarn install --offline --verbose --no-progress --non-interactive --build-from-source
	# Delete known pre-built binaries
	rm -fR \
		node_modules/@serialport/bindings-cpp/prebuilds/{darwin,android,win32,linux-arm}* \
		node_modules/@serialport/bindings-cpp/prebuilds/linux-x64/*musl.node || die
	edo yarn gql-gen
	VITE_APP_DATE="$(date '+%Y-%m-%d %H:%M:%S')"
	VITE_APP_NOLEGACY=true
	VITE_APP_SOURCEMAPS=true
	VITE_APP_STASH_VERSION="${PV}"
	export VITE_APP_DATE VITE_APP_NOLEGACY VITE_APP_STASH_VERSION
	edo yarn vite build
	cd "${S}" || die
	MAKEOPTS=-j1 LDFLAGS="" emake release
}

src_install() {
	dobin "${PN}" phasher
	einstalldocs
}
