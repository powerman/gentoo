# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

DISABLE_AUTOFORMATTING=true

inherit desktop python-single-r1 readme.gentoo-r1 virtualx

DESCRIPTION="Elog viewer for Gentoo"
HOMEPAGE="https://github.com/Synss/elogviewer"
SRC_URI="https://github.com/Synss/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc ~riscv x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pyqt5[gui,widgets,${PYTHON_USEDEP}]
		>=sys-apps/portage-2.1[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	test? (
		${RDEPEND}
		$(python_gen_cond_dep '
			dev-python/pyfakefs[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/pytest-qt[${PYTHON_USEDEP}]
		')
	)
"

DOC_CONTENTS="In order to use this software, you need to activate
Portage's elog features.  Required is
	PORTAGE_ELOG_SYSTEM=\"save\"
and at least one of
	PORTAGE_ELOG_CLASSES=\"warn error info log qa\"
More information on the elog system can be found in
/usr/share/portage/config/make.conf.example

To operate properly this software needs the directory
${PORT_LOGDIR:-/var/log/portage}/elog created, belonging to group portage.
To start the software as a user, add yourself to the portage group."

src_compile() {
	rm -f Makefile
}

src_test() {
	export PYTEST_QT_API=pyqt5
	virtx epytest
}

src_install() {
	python_newscript elogviewer.py elogviewer

	make_desktop_entry ${PN} ${PN} ${PN} System

	doman elogviewer.1
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog

	ewarn "The elogviewer's configuration file is now saved in:"
	ewarn "~/.config/elogviewer/ (was ~/.config/Mathias\ Laurin/)."
	ewarn "Please migrate any user specific settings to the new config file."
}
