# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=RJBS
DIST_VERSION=2.202
inherit perl-module

DESCRIPTION="Simply Sending Email"

SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 x86"

RDEPEND="
	dev-perl/Email-Abstract
	>=dev-perl/Email-Address-1.800.0
	>=dev-perl/Email-Simple-1.920.0
	virtual/perl-File-Spec
	>=dev-perl/Module-Pluggable-2.970.0
	dev-perl/Return-Value
	>=virtual/perl-Scalar-List-Utils-1.20.0
	virtual/perl-libnet
"
BDEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-File-Path
		virtual/perl-File-Temp
		virtual/perl-IO
		dev-perl/MIME-tools
		dev-perl/MailTools
		>=virtual/perl-Test-Simple-0.880.0
	)
"

PERL_RM_FILES=(
	t/pod-coverage.t
	t/pod.t
	t/release-changes_has_content.t
	t/release-pod-syntax.t
)
