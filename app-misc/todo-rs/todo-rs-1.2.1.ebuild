# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

CRATES="
addr2line-0.15.1
adler-1.0.2
aho-corasick-0.7.18
ansi_term-0.11.0
anyhow-1.0.40
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.59
better-panic-0.2.0
bitflags-1.2.1
cassowary-0.3.0
cc-1.0.67
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
clicolors-control-1.0.1
console-0.9.2
crossbeam-channel-0.5.1
crossbeam-utils-0.8.4
crossterm-0.19.0
crossterm_winapi-0.7.0
dirs-next-2.0.0
dirs-sys-next-0.1.2
dtoa-0.4.8
encode_unicode-0.3.6
getrandom-0.2.2
gimli-0.24.0
heck-0.3.2
hermit-abi-0.1.18
instant-0.1.9
lazy_static-1.4.0
libc-0.2.94
linked-hash-map-0.5.4
lock_api-0.4.4
log-0.4.14
memchr-2.4.0
miniz_oxide-0.4.4
mio-0.7.11
miow-0.3.7
ntapi-0.3.6
num-integer-0.1.44
num-traits-0.2.14
object-0.24.0
parking_lot-0.11.1
parking_lot_core-0.8.3
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.26
quote-1.0.9
redox_syscall-0.2.8
redox_users-0.4.0
regex-1.5.4
regex-syntax-0.6.25
rustc-demangle-0.1.19
scopeguard-1.1.0
serde-1.0.125
serde_derive-1.0.125
serde_yaml-0.8.17
signal-hook-0.1.17
signal-hook-registry-1.3.0
smallvec-1.6.1
strsim-0.8.0
structopt-0.3.21
structopt-derive-0.4.14
syn-1.0.72
termios-0.3.3
textwrap-0.11.0
time-0.1.44
tui-0.15.0
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.2
vec_map-0.8.2
version_check-0.9.3
wasi-0.10.0+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.5
"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Z5483/todo-rs"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/Z5483/todo-rs/archive/v${PV}.tar.gz -> ${P}.tar.gz $(cargo_crate_uris ${CRATES})"
fi

DESCRIPTION="Todo TUI written in Rust"
HOMEPAGE="https://github.com/Z5483/todo-rs"

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
