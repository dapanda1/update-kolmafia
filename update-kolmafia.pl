#!/usr/bin/perl
# update-kolmafia.pl
# c2t

# downloads latest KoLmafia into the current working directory if it does not already exist and creates a symbolic link "KoLmafia-latest.jar" to it

# note: if using a win32 system, the symbolic link will not be created unless running this as an administrator

use strict;
use warnings;
use LWP::Simple;
use Getopt::Long qw(GetOptions);

# options
my $makesymlink;
GetOptions('symlink!' => \$makesymlink) or die "$!";

# need additional modules to make symlinks in Win32
if ($makesymlink) {
	use Win32::Symlinks;
	# force admin in win32
	use English qw' -no_match_vars ';
	if ($OSNAME eq 'MSWin32') {
		use Win32::RunAsAdmin;
		if (not Win32::RunAsAdmin::check) {
			Win32::RunAsAdmin::restart;
		}
	}
}

my ($page,$link,$file,$sym,$res);
$sym = 'KoLmafia-latest.jar';

# get api data
print "checking for latest KoLmafia...\n";
$page = get('https://api.github.com/repos/kolmafia/kolmafia/releases/latest') or die 'unable to get page';
$link = $page =~ m/"browser_download_url":\s*"([^"]+\.jar)"/ ? $1 : die 'unable to match download link';
$file = $link =~ m/(KoLmafia-\d+\.jar)/ ? $1 : die 'unable to match file name';

# check for file existing
if (-e "$file") {
	print "already have latest: $file\n";
}
# download
else {
	print "downloading $file...\n";
	$res = getstore($link,$file);
	if (is_error($res)) {
		die "getstore <$link> failed: $res";
	}
}

# make symlink
if ($makesymlink and readlink($sym) ne $file) {
	print "creating symlink: $sym...\n";
	unlink($sym);
	symlink($file,$sym) or die "$!";
}

print "$0 done...\n";
