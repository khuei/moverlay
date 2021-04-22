# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

CRATES="
addr2line-0.14.1
adler-0.2.3
ansi_term-0.11.0
anyhow-1.0.38
async-attributes-1.1.2
async-channel-1.5.1
async-executor-1.4.0
async-global-executor-2.0.2
async-io-1.3.1
async-lock-2.3.0
async-mutex-1.4.0
async-std-1.9.0
async-task-4.0.3
atomic-waker-1.0.0
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.56
better-panic-0.2.0
bitflags-1.2.1
blocking-1.0.2
bumpalo-3.6.0
byteorder-1.4.2
bytes-0.4.12
cache-padded-1.1.1
cassowary-0.3.0
cc-1.0.66
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
chrono-tz-0.5.3
clap-2.33.3
clicolors-control-1.0.1
concurrent-queue-1.2.2
console-0.9.2
crossbeam-channel-0.4.4
crossbeam-utils-0.7.2
crossbeam-utils-0.8.1
crossterm-0.18.2
crossterm-0.19.0
crossterm_winapi-0.6.2
crossterm_winapi-0.7.0
ctor-0.1.19
curl-0.4.34
curl-sys-0.4.40+curl-7.75.0
dirs-next-2.0.0
dirs-sys-next-0.1.2
dtoa-0.4.7
either-1.6.1
encode_unicode-0.3.6
event-listener-2.5.1
fastrand-1.4.0
fnv-1.0.7
form_urlencoded-1.0.0
futures-0.3.12
futures-channel-0.3.12
futures-core-0.3.12
futures-executor-0.3.12
futures-io-0.3.12
futures-lite-1.11.3
futures-macro-0.3.12
futures-sink-0.3.12
futures-task-0.3.12
futures-util-0.3.12
getrandom-0.2.2
gimli-0.23.0
gloo-timers-0.2.1
heck-0.3.2
hermit-abi-0.1.18
http-0.1.21
idna-0.2.1
instant-0.1.9
iovec-0.1.4
isahc-0.8.2
itertools-0.9.0
itoa-0.4.7
js-sys-0.3.47
kv-log-macro-1.0.7
lazy_static-1.4.0
libc-0.2.86
libnghttp2-sys-0.1.6+1.43.0
libz-sys-1.1.2
linked-hash-map-0.5.4
lock_api-0.4.2
log-0.4.14
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.3.4
miniz_oxide-0.4.3
mio-0.7.7
miow-0.3.6
nb-connect-1.0.3
ntapi-0.3.6
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.23.0
once_cell-1.5.2
openssl-probe-0.1.2
openssl-src-111.13.0+1.1.1i
openssl-sys-0.9.60
parking-2.0.0
parking_lot-0.11.1
parking_lot_core-0.8.3
parse-zoneinfo-0.3.0
percent-encoding-2.1.0
pin-project-lite-0.2.4
pin-utils-0.1.0
pkg-config-0.3.19
polling-2.0.2
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro-nested-0.1.7
proc-macro2-1.0.24
quote-1.0.9
redox_syscall-0.2.5
redox_users-0.4.0
regex-1.4.3
regex-syntax-0.6.22
rustc-demangle-0.1.18
ryu-1.0.5
schannel-0.1.19
scopeguard-1.1.0
serde-1.0.123
serde_derive-1.0.123
serde_json-1.0.62
serde_urlencoded-0.6.1
serde_yaml-0.8.17
signal-hook-0.1.17
signal-hook-registry-1.3.0
slab-0.4.2
sluice-0.5.4
smallvec-1.6.1
socket2-0.3.19
strsim-0.8.0
structopt-0.3.21
structopt-derive-0.4.14
syn-1.0.60
termios-0.3.3
textwrap-0.11.0
tickrs-0.14.4
tickrs-api-0.14.4
time-0.1.43
tinyvec-1.1.1
tinyvec_macros-0.1.0
tui-0.14.0
unicode-bidi-0.3.4
unicode-normalization-0.1.17
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
url-2.2.0
value-bag-1.0.0-alpha.6
vcpkg-0.2.11
vec-arena-1.0.0
vec_map-0.8.2
version_check-0.9.2
waker-fn-1.1.0
wasi-0.10.2+wasi-snapshot-preview1
wasm-bindgen-0.2.70
wasm-bindgen-backend-0.2.70
wasm-bindgen-futures-0.4.20
wasm-bindgen-macro-0.2.70
wasm-bindgen-macro-support-0.2.70
wasm-bindgen-shared-0.2.70
web-sys-0.3.47
wepoll-sys-3.0.1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.5
"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tarkah/tickrs"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/tarkah/tickrs/archive/v${PV}.tar.gz -> ${P}.tar.gz $(cargo_crate_uris ${CRATES})"
fi

DESCRIPTION="Realtime ticker data in your terminal"
HOMEPAGE="https://github.com/tarkah/tickrs"

LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="mirror"

DEPEND="
	|| (
		>=dev-lang/rust-1.51.0[rls]
		>=dev-lang/rust-bin-1.51.0[rls]
	)
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install
}