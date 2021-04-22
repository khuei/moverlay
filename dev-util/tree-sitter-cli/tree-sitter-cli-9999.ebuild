# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tree-sitter/tree-sitter"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/tree-sitter/tree-sitter/archive/v${PV}.tar.gz -> ${P}.tar.gz $(cargo_crate_uris ${CRATES})"
fi

DESCRIPTION="Tree-sitter command line interface"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"

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

src_compile() {
	cargo_src_compile --manifest-path cli/Cargo.toml
}

src_install() {
	dobin target/release/tree-sitter
}
