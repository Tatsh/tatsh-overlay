# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit python-r1

DESCRIPTION="Node.js native addon build tool"
HOMEPAGE="https://github.com/nodejs/node-gyp"
SRC_URI="https://registry.yarnpkg.com/abbrev/-/abbrev-1.1.1.tgz -> node-abbrev-1.1.1.tgz
	https://registry.yarnpkg.com/acorn/-/acorn-7.4.1.tgz -> node-acorn-7.4.1.tgz
	https://registry.yarnpkg.com/acorn-jsx/-/acorn-jsx-5.3.1.tgz -> node-acorn-jsx-5.3.1.tgz
	https://registry.yarnpkg.com/agent-base/-/agent-base-6.0.2.tgz -> node-agent-base-6.0.2.tgz
	https://registry.yarnpkg.com/agentkeepalive/-/agentkeepalive-4.2.1.tgz -> node-agentkeepalive-4.2.1.tgz
	https://registry.yarnpkg.com/aggregate-error/-/aggregate-error-3.1.0.tgz -> node-aggregate-error-3.1.0.tgz
	https://registry.yarnpkg.com/ajv/-/ajv-6.12.6.tgz -> node-ajv-6.12.6.tgz
	https://registry.yarnpkg.com/ajv/-/ajv-8.6.0.tgz -> node-ajv-8.6.0.tgz
	https://registry.yarnpkg.com/ansi-colors/-/ansi-colors-4.1.1.tgz -> node-ansi-colors-4.1.1.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-5.0.0.tgz -> node-ansi-regex-5.0.0.tgz
	https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-5.0.1.tgz -> node-ansi-regex-5.0.1.tgz
	https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-3.2.1.tgz -> node-ansi-styles-3.2.1.tgz
	https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-4.3.0.tgz -> node-ansi-styles-4.3.0.tgz
	https://registry.yarnpkg.com/aproba/-/aproba-2.0.0.tgz -> node-aproba-2.0.0.tgz
	https://registry.yarnpkg.com/are-we-there-yet/-/are-we-there-yet-3.0.0.tgz -> node-are-we-there-yet-3.0.0.tgz
	https://registry.yarnpkg.com/argparse/-/argparse-1.0.10.tgz -> node-argparse-1.0.10.tgz
	https://registry.yarnpkg.com/astral-regex/-/astral-regex-2.0.0.tgz -> node-astral-regex-2.0.0.tgz
	https://registry.yarnpkg.com/@babel/code-frame/-/code-frame-7.12.11.tgz -> node-@babel-code-frame-7.12.11.tgz
	https://registry.yarnpkg.com/@babel/helper-validator-identifier/-/helper-validator-identifier-7.14.5.tgz -> node-@babel-helper-validator-identifier-7.14.5.tgz
	https://registry.yarnpkg.com/@babel/highlight/-/highlight-7.14.5.tgz -> node-@babel-highlight-7.14.5.tgz
	https://registry.yarnpkg.com/balanced-match/-/balanced-match-1.0.2.tgz -> node-balanced-match-1.0.2.tgz
	https://registry.yarnpkg.com/brace-expansion/-/brace-expansion-1.1.11.tgz -> node-brace-expansion-1.1.11.tgz
	https://registry.yarnpkg.com/cacache/-/cacache-16.0.4.tgz -> node-cacache-16.0.4.tgz
	https://registry.yarnpkg.com/callsites/-/callsites-3.1.0.tgz -> node-callsites-3.1.0.tgz
	https://registry.yarnpkg.com/chalk/-/chalk-2.4.2.tgz -> node-chalk-2.4.2.tgz
	https://registry.yarnpkg.com/chalk/-/chalk-4.1.1.tgz -> node-chalk-4.1.1.tgz
	https://registry.yarnpkg.com/chownr/-/chownr-2.0.0.tgz -> node-chownr-2.0.0.tgz
	https://registry.yarnpkg.com/clean-stack/-/clean-stack-2.2.0.tgz -> node-clean-stack-2.2.0.tgz
	https://registry.yarnpkg.com/color-convert/-/color-convert-1.9.3.tgz -> node-color-convert-1.9.3.tgz
	https://registry.yarnpkg.com/color-convert/-/color-convert-2.0.1.tgz -> node-color-convert-2.0.1.tgz
	https://registry.yarnpkg.com/color-name/-/color-name-1.1.3.tgz -> node-color-name-1.1.3.tgz
	https://registry.yarnpkg.com/color-name/-/color-name-1.1.4.tgz -> node-color-name-1.1.4.tgz
	https://registry.yarnpkg.com/color-support/-/color-support-1.1.3.tgz -> node-color-support-1.1.3.tgz
	https://registry.yarnpkg.com/concat-map/-/concat-map-0.0.1.tgz -> node-concat-map-0.0.1.tgz
	https://registry.yarnpkg.com/console-control-strings/-/console-control-strings-1.1.0.tgz -> node-console-control-strings-1.1.0.tgz
	https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-7.0.3.tgz -> node-cross-spawn-7.0.3.tgz
	https://registry.yarnpkg.com/debug/-/debug-4.3.1.tgz -> node-debug-4.3.1.tgz
	https://registry.yarnpkg.com/debug/-/debug-4.3.4.tgz -> node-debug-4.3.4.tgz
	https://registry.yarnpkg.com/deep-is/-/deep-is-0.1.3.tgz -> node-deep-is-0.1.3.tgz
	https://registry.yarnpkg.com/delegates/-/delegates-1.0.0.tgz -> node-delegates-1.0.0.tgz
	https://registry.yarnpkg.com/depd/-/depd-1.1.2.tgz -> node-depd-1.1.2.tgz
	https://registry.yarnpkg.com/doctrine/-/doctrine-3.0.0.tgz -> node-doctrine-3.0.0.tgz
	https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-8.0.0.tgz -> node-emoji-regex-8.0.0.tgz
	https://registry.yarnpkg.com/encoding/-/encoding-0.1.13.tgz -> node-encoding-0.1.13.tgz
	https://registry.yarnpkg.com/enquirer/-/enquirer-2.3.6.tgz -> node-enquirer-2.3.6.tgz
	https://registry.yarnpkg.com/env-paths/-/env-paths-2.2.1.tgz -> node-env-paths-2.2.1.tgz
	https://registry.yarnpkg.com/err-code/-/err-code-2.0.3.tgz -> node-err-code-2.0.3.tgz
	https://registry.yarnpkg.com/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz -> node-escape-string-regexp-1.0.5.tgz
	https://registry.yarnpkg.com/escape-string-regexp/-/escape-string-regexp-4.0.0.tgz -> node-escape-string-regexp-4.0.0.tgz
	https://registry.yarnpkg.com/eslint/-/eslint-7.28.0.tgz -> node-eslint-7.28.0.tgz
	https://registry.yarnpkg.com/@eslint/eslintrc/-/eslintrc-0.4.2.tgz -> node-@eslint-eslintrc-0.4.2.tgz
	https://registry.yarnpkg.com/eslint-scope/-/eslint-scope-5.1.1.tgz -> node-eslint-scope-5.1.1.tgz
	https://registry.yarnpkg.com/eslint-utils/-/eslint-utils-2.1.0.tgz -> node-eslint-utils-2.1.0.tgz
	https://registry.yarnpkg.com/eslint-visitor-keys/-/eslint-visitor-keys-1.3.0.tgz -> node-eslint-visitor-keys-1.3.0.tgz
	https://registry.yarnpkg.com/eslint-visitor-keys/-/eslint-visitor-keys-2.1.0.tgz -> node-eslint-visitor-keys-2.1.0.tgz
	https://registry.yarnpkg.com/espree/-/espree-7.3.1.tgz -> node-espree-7.3.1.tgz
	https://registry.yarnpkg.com/esprima/-/esprima-4.0.1.tgz -> node-esprima-4.0.1.tgz
	https://registry.yarnpkg.com/esquery/-/esquery-1.4.0.tgz -> node-esquery-1.4.0.tgz
	https://registry.yarnpkg.com/esrecurse/-/esrecurse-4.3.0.tgz -> node-esrecurse-4.3.0.tgz
	https://registry.yarnpkg.com/estraverse/-/estraverse-4.3.0.tgz -> node-estraverse-4.3.0.tgz
	https://registry.yarnpkg.com/estraverse/-/estraverse-5.2.0.tgz -> node-estraverse-5.2.0.tgz
	https://registry.yarnpkg.com/esutils/-/esutils-2.0.3.tgz -> node-esutils-2.0.3.tgz
	https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-3.1.1.tgz -> node-fast-deep-equal-3.1.1.tgz
	https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz -> node-fast-deep-equal-3.1.3.tgz
	https://registry.yarnpkg.com/fast-json-stable-stringify/-/fast-json-stable-stringify-2.1.0.tgz -> node-fast-json-stable-stringify-2.1.0.tgz
	https://registry.yarnpkg.com/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz -> node-fast-levenshtein-2.0.6.tgz
	https://registry.yarnpkg.com/file-entry-cache/-/file-entry-cache-6.0.1.tgz -> node-file-entry-cache-6.0.1.tgz
	https://registry.yarnpkg.com/flat-cache/-/flat-cache-3.0.4.tgz -> node-flat-cache-3.0.4.tgz
	https://registry.yarnpkg.com/flatted/-/flatted-3.1.1.tgz -> node-flatted-3.1.1.tgz
	https://registry.yarnpkg.com/fs-minipass/-/fs-minipass-2.1.0.tgz -> node-fs-minipass-2.1.0.tgz
	https://registry.yarnpkg.com/fs.realpath/-/fs.realpath-1.0.0.tgz -> node-fs.realpath-1.0.0.tgz
	https://registry.yarnpkg.com/functional-red-black-tree/-/functional-red-black-tree-1.0.1.tgz -> node-functional-red-black-tree-1.0.1.tgz
	https://registry.yarnpkg.com/@gar/promisify/-/promisify-1.1.3.tgz -> node-@gar-promisify-1.1.3.tgz
	https://registry.yarnpkg.com/gauge/-/gauge-4.0.4.tgz -> node-gauge-4.0.4.tgz
	https://registry.yarnpkg.com/globals/-/globals-13.9.0.tgz -> node-globals-13.9.0.tgz
	https://registry.yarnpkg.com/glob/-/glob-7.1.6.tgz -> node-glob-7.1.6.tgz
	https://registry.yarnpkg.com/glob/-/glob-7.2.0.tgz -> node-glob-7.2.0.tgz
	https://registry.yarnpkg.com/glob-parent/-/glob-parent-5.1.2.tgz -> node-glob-parent-5.1.2.tgz
	https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.2.10.tgz -> node-graceful-fs-4.2.10.tgz
	https://registry.yarnpkg.com/has-flag/-/has-flag-3.0.0.tgz -> node-has-flag-3.0.0.tgz
	https://registry.yarnpkg.com/has-flag/-/has-flag-4.0.0.tgz -> node-has-flag-4.0.0.tgz
	https://registry.yarnpkg.com/has-unicode/-/has-unicode-2.0.1.tgz -> node-has-unicode-2.0.1.tgz
	https://registry.yarnpkg.com/http-cache-semantics/-/http-cache-semantics-4.1.0.tgz -> node-http-cache-semantics-4.1.0.tgz
	https://registry.yarnpkg.com/http-proxy-agent/-/http-proxy-agent-5.0.0.tgz -> node-http-proxy-agent-5.0.0.tgz
	https://registry.yarnpkg.com/https-proxy-agent/-/https-proxy-agent-5.0.0.tgz -> node-https-proxy-agent-5.0.0.tgz
	https://registry.yarnpkg.com/humanize-ms/-/humanize-ms-1.2.1.tgz -> node-humanize-ms-1.2.1.tgz
	https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.6.3.tgz -> node-iconv-lite-0.6.3.tgz
	https://registry.yarnpkg.com/ignore/-/ignore-4.0.6.tgz -> node-ignore-4.0.6.tgz
	https://registry.yarnpkg.com/import-fresh/-/import-fresh-3.3.0.tgz -> node-import-fresh-3.3.0.tgz
	https://registry.yarnpkg.com/imurmurhash/-/imurmurhash-0.1.4.tgz -> node-imurmurhash-0.1.4.tgz
	https://registry.yarnpkg.com/indent-string/-/indent-string-4.0.0.tgz -> node-indent-string-4.0.0.tgz
	https://registry.yarnpkg.com/infer-owner/-/infer-owner-1.0.4.tgz -> node-infer-owner-1.0.4.tgz
	https://registry.yarnpkg.com/inflight/-/inflight-1.0.6.tgz -> node-inflight-1.0.6.tgz
	https://registry.yarnpkg.com/inherits/-/inherits-2.0.4.tgz -> node-inherits-2.0.4.tgz
	https://registry.yarnpkg.com/ip/-/ip-1.1.5.tgz -> node-ip-1.1.5.tgz
	https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz -> node-isexe-2.0.0.tgz
	https://registry.yarnpkg.com/is-extglob/-/is-extglob-2.1.1.tgz -> node-is-extglob-2.1.1.tgz
	https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz -> node-is-fullwidth-code-point-3.0.0.tgz
	https://registry.yarnpkg.com/is-glob/-/is-glob-4.0.1.tgz -> node-is-glob-4.0.1.tgz
	https://registry.yarnpkg.com/is-lambda/-/is-lambda-1.0.1.tgz -> node-is-lambda-1.0.1.tgz
	https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz -> node-json-schema-traverse-0.4.1.tgz
	https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-1.0.0.tgz -> node-json-schema-traverse-1.0.0.tgz
	https://registry.yarnpkg.com/json-stable-stringify-without-jsonify/-/json-stable-stringify-without-jsonify-1.0.1.tgz -> node-json-stable-stringify-without-jsonify-1.0.1.tgz
	https://registry.yarnpkg.com/js-tokens/-/js-tokens-4.0.0.tgz -> node-js-tokens-4.0.0.tgz
	https://registry.yarnpkg.com/js-yaml/-/js-yaml-3.14.1.tgz -> node-js-yaml-3.14.1.tgz
	https://registry.yarnpkg.com/levn/-/levn-0.4.1.tgz -> node-levn-0.4.1.tgz
	https://registry.yarnpkg.com/lodash.clonedeep/-/lodash.clonedeep-4.5.0.tgz -> node-lodash.clonedeep-4.5.0.tgz
	https://registry.yarnpkg.com/lodash.merge/-/lodash.merge-4.6.2.tgz -> node-lodash.merge-4.6.2.tgz
	https://registry.yarnpkg.com/lodash.truncate/-/lodash.truncate-4.4.2.tgz -> node-lodash.truncate-4.4.2.tgz
	https://registry.yarnpkg.com/lru-cache/-/lru-cache-6.0.0.tgz -> node-lru-cache-6.0.0.tgz
	https://registry.yarnpkg.com/lru-cache/-/lru-cache-7.8.1.tgz -> node-lru-cache-7.8.1.tgz
	https://registry.yarnpkg.com/make-fetch-happen/-/make-fetch-happen-10.1.2.tgz -> node-make-fetch-happen-10.1.2.tgz
	https://registry.yarnpkg.com/minimatch/-/minimatch-3.1.2.tgz -> node-minimatch-3.1.2.tgz
	https://registry.yarnpkg.com/minipass-collect/-/minipass-collect-1.0.2.tgz -> node-minipass-collect-1.0.2.tgz
	https://registry.yarnpkg.com/minipass-fetch/-/minipass-fetch-2.1.0.tgz -> node-minipass-fetch-2.1.0.tgz
	https://registry.yarnpkg.com/minipass-flush/-/minipass-flush-1.0.5.tgz -> node-minipass-flush-1.0.5.tgz
	https://registry.yarnpkg.com/minipass/-/minipass-3.1.3.tgz -> node-minipass-3.1.3.tgz
	https://registry.yarnpkg.com/minipass/-/minipass-3.1.6.tgz -> node-minipass-3.1.6.tgz
	https://registry.yarnpkg.com/minipass-pipeline/-/minipass-pipeline-1.2.4.tgz -> node-minipass-pipeline-1.2.4.tgz
	https://registry.yarnpkg.com/minipass-sized/-/minipass-sized-1.0.3.tgz -> node-minipass-sized-1.0.3.tgz
	https://registry.yarnpkg.com/minizlib/-/minizlib-2.1.2.tgz -> node-minizlib-2.1.2.tgz
	https://registry.yarnpkg.com/mkdirp/-/mkdirp-1.0.4.tgz -> node-mkdirp-1.0.4.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz -> node-ms-2.1.2.tgz
	https://registry.yarnpkg.com/ms/-/ms-2.1.3.tgz -> node-ms-2.1.3.tgz
	https://registry.yarnpkg.com/natural-compare/-/natural-compare-1.4.0.tgz -> node-natural-compare-1.4.0.tgz
	https://registry.yarnpkg.com/negotiator/-/negotiator-0.6.3.tgz -> node-negotiator-0.6.3.tgz
	https://registry.yarnpkg.com/node-gyp/-/${P}.tgz -> node-${P}.tgz
	https://registry.yarnpkg.com/nopt/-/nopt-5.0.0.tgz -> node-nopt-5.0.0.tgz
	https://registry.yarnpkg.com/@npmcli/fs/-/fs-2.1.0.tgz -> node-@npmcli-fs-2.1.0.tgz
	https://registry.yarnpkg.com/@npmcli/move-file/-/move-file-2.0.0.tgz -> node-@npmcli-move-file-2.0.0.tgz
	https://registry.yarnpkg.com/npmlog/-/npmlog-6.0.1.tgz -> node-npmlog-6.0.1.tgz
	https://registry.yarnpkg.com/once/-/once-1.4.0.tgz -> node-once-1.4.0.tgz
	https://registry.yarnpkg.com/optionator/-/optionator-0.9.1.tgz -> node-optionator-0.9.1.tgz
	https://registry.yarnpkg.com/parent-module/-/parent-module-1.0.1.tgz -> node-parent-module-1.0.1.tgz
	https://registry.yarnpkg.com/path-is-absolute/-/path-is-absolute-1.0.1.tgz -> node-path-is-absolute-1.0.1.tgz
	https://registry.yarnpkg.com/path-key/-/path-key-3.1.1.tgz -> node-path-key-3.1.1.tgz
	https://registry.yarnpkg.com/p-map/-/p-map-4.0.0.tgz -> node-p-map-4.0.0.tgz
	https://registry.yarnpkg.com/prelude-ls/-/prelude-ls-1.2.1.tgz -> node-prelude-ls-1.2.1.tgz
	https://registry.yarnpkg.com/progress/-/progress-2.0.3.tgz -> node-progress-2.0.3.tgz
	https://registry.yarnpkg.com/promise-inflight/-/promise-inflight-1.0.1.tgz -> node-promise-inflight-1.0.1.tgz
	https://registry.yarnpkg.com/promise-retry/-/promise-retry-2.0.1.tgz -> node-promise-retry-2.0.1.tgz
	https://registry.yarnpkg.com/punycode/-/punycode-2.1.1.tgz -> node-punycode-2.1.1.tgz
	https://registry.yarnpkg.com/readable-stream/-/readable-stream-3.6.0.tgz -> node-readable-stream-3.6.0.tgz
	https://registry.yarnpkg.com/regexpp/-/regexpp-3.1.0.tgz -> node-regexpp-3.1.0.tgz
	https://registry.yarnpkg.com/require-from-string/-/require-from-string-2.0.2.tgz -> node-require-from-string-2.0.2.tgz
	https://registry.yarnpkg.com/resolve-from/-/resolve-from-4.0.0.tgz -> node-resolve-from-4.0.0.tgz
	https://registry.yarnpkg.com/retry/-/retry-0.12.0.tgz -> node-retry-0.12.0.tgz
	https://registry.yarnpkg.com/rimraf/-/rimraf-3.0.2.tgz -> node-rimraf-3.0.2.tgz
	https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.2.1.tgz -> node-safe-buffer-5.2.1.tgz
	https://registry.yarnpkg.com/safer-buffer/-/safer-buffer-2.1.2.tgz -> node-safer-buffer-2.1.2.tgz
	https://registry.yarnpkg.com/semver/-/semver-7.3.5.tgz -> node-semver-7.3.5.tgz
	https://registry.yarnpkg.com/semver/-/semver-7.3.6.tgz -> node-semver-7.3.6.tgz
	https://registry.yarnpkg.com/set-blocking/-/set-blocking-2.0.0.tgz -> node-set-blocking-2.0.0.tgz
	https://registry.yarnpkg.com/shebang-command/-/shebang-command-2.0.0.tgz -> node-shebang-command-2.0.0.tgz
	https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-3.0.0.tgz -> node-shebang-regex-3.0.0.tgz
	https://registry.yarnpkg.com/signal-exit/-/signal-exit-3.0.7.tgz -> node-signal-exit-3.0.7.tgz
	https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-4.0.0.tgz -> node-slice-ansi-4.0.0.tgz
	https://registry.yarnpkg.com/smart-buffer/-/smart-buffer-4.2.0.tgz -> node-smart-buffer-4.2.0.tgz
	https://registry.yarnpkg.com/socks-proxy-agent/-/socks-proxy-agent-6.1.1.tgz -> node-socks-proxy-agent-6.1.1.tgz
	https://registry.yarnpkg.com/socks/-/socks-2.6.2.tgz -> node-socks-2.6.2.tgz
	https://registry.yarnpkg.com/sprintf-js/-/sprintf-js-1.0.3.tgz -> node-sprintf-js-1.0.3.tgz
	https://registry.yarnpkg.com/ssri/-/ssri-9.0.0.tgz -> node-ssri-9.0.0.tgz
	https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.3.0.tgz -> node-string_decoder-1.3.0.tgz
	https://registry.yarnpkg.com/string-width/-/string-width-4.2.2.tgz -> node-string-width-4.2.2.tgz
	https://registry.yarnpkg.com/string-width/-/string-width-4.2.3.tgz -> node-string-width-4.2.3.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-6.0.0.tgz -> node-strip-ansi-6.0.0.tgz
	https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-6.0.1.tgz -> node-strip-ansi-6.0.1.tgz
	https://registry.yarnpkg.com/strip-json-comments/-/strip-json-comments-3.1.1.tgz -> node-strip-json-comments-3.1.1.tgz
	https://registry.yarnpkg.com/supports-color/-/supports-color-5.5.0.tgz -> node-supports-color-5.5.0.tgz
	https://registry.yarnpkg.com/supports-color/-/supports-color-7.2.0.tgz -> node-supports-color-7.2.0.tgz
	https://registry.yarnpkg.com/table/-/table-6.7.1.tgz -> node-table-6.7.1.tgz
	https://registry.yarnpkg.com/tar/-/tar-6.1.11.tgz -> node-tar-6.1.11.tgz
	https://registry.yarnpkg.com/text-table/-/text-table-0.2.0.tgz -> node-text-table-0.2.0.tgz
	https://registry.yarnpkg.com/@tootallnate/once/-/once-2.0.0.tgz -> node-@tootallnate-once-2.0.0.tgz
	https://registry.yarnpkg.com/type-check/-/type-check-0.4.0.tgz -> node-type-check-0.4.0.tgz
	https://registry.yarnpkg.com/type-fest/-/type-fest-0.20.2.tgz -> node-type-fest-0.20.2.tgz
	https://registry.yarnpkg.com/unique-filename/-/unique-filename-1.1.1.tgz -> node-unique-filename-1.1.1.tgz
	https://registry.yarnpkg.com/unique-slug/-/unique-slug-2.0.2.tgz -> node-unique-slug-2.0.2.tgz
	https://registry.yarnpkg.com/uri-js/-/uri-js-4.2.2.tgz -> node-uri-js-4.2.2.tgz
	https://registry.yarnpkg.com/util-deprecate/-/util-deprecate-1.0.2.tgz -> node-util-deprecate-1.0.2.tgz
	https://registry.yarnpkg.com/v8-compile-cache/-/v8-compile-cache-2.3.0.tgz -> node-v8-compile-cache-2.3.0.tgz
	https://registry.yarnpkg.com/which/-/which-2.0.2.tgz -> node-which-2.0.2.tgz
	https://registry.yarnpkg.com/wide-align/-/wide-align-1.1.5.tgz -> node-wide-align-1.1.5.tgz
	https://registry.yarnpkg.com/word-wrap/-/word-wrap-1.2.3.tgz -> node-word-wrap-1.2.3.tgz
	https://registry.yarnpkg.com/wrappy/-/wrappy-1.0.2.tgz -> node-wrappy-1.0.2.tgz
	https://registry.yarnpkg.com/yallist/-/yallist-4.0.0.tgz -> node-yallist-4.0.0.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="sys-apps/yarn"
RDEPEND="net-libs/nodejs:= ${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	local archive
	for archive in ${A}; do
			case "${archive}" in
					*.tgz)
							;;
					*)
							unpack ${archive}
							;;
			esac
	done
}

src_prepare() {
	mkdir lib packages || die
	local file bn
	for file in "${DISTDIR}"/node-*.tgz; do
		bn=$(basename "$file")
		ln -s "${file}" "packages/${bn:5}" || die
	done
	default
}

src_configure() {
	yarn config set prefix "${HOME}/.node" || die
	yarn config set yarn-offline-mirror "$(realpath "${WORKDIR}/packages")" || die
}

src_compile() {
	cd lib || die
	cp "${FILESDIR}/${PN}-package.json" package.json || die
	cp "${FILESDIR}/${PN}-yarn.lock" yarn.lock || die
	yarn install --production --offline --verbose --no-progress \
		--non-interactive --build-from-source || die
	rm package.json
	find . -type d -empty -delete || die
	find . -type f '(' -name '*.ts*' -o -name '*.map' -o -iname '*.md' ')' -delete || die
	find . -type f -iname 'license*' -exec bzip2 {} \; || die
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}/node_modules
	doins -r lib/node_modules/*
	fperms 0755 /usr/$(get_libdir)/${PN}/node_modules/node-gyp/bin/${PN}.js
	dosym ../$(get_libdir)/${PN}/node_modules/node-gyp/bin/${PN}.js /usr/bin/${PN}
	einstalldocs
}
