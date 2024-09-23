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
my $makesymlink = 1;
GetOptions('symlink!' => \$makesymlink) or die "$!";

# Detect the operating system
my $os = $^O;

# need additional modules to make symlinks in Win32
if ($makesymlink and $os eq 'MSWin32') {
	# Attempt to load Win32::RunAsAdmin
	eval {
		require Win32::RunAsAdmin;
		Win32::RunAsAdmin->import('force');
	};
	# Attempt to load Win32::Symlinks
	eval {
		require Win32::Symlinks;
		Win32::Symlinks->import();
	};
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
if ($makesymlink) {
	my $existing_link = readlink($sym);  # readlink may return undef if the link does not exist
	if (!$existing_link || $existing_link ne $file) {
		print "creating symlink: $sym...\n";
		unlink($sym);
		symlink($file, $sym) or die "$!";
	}
}

# Keep only the five newest versions
opendir(my $dh, ".") or die "Could not open current directory: $!";
my @files;

# Filter only KoLmafia-*.jar files
while (my $entry = readdir($dh)) {
	if ($entry =~ /^KoLmafia-\d+\.jar$/ && -f $entry) {
		push @files, $entry;
	}
}
closedir($dh);

# Sort files by modification time (newest first)
@files = sort { (stat($b))[9] <=> (stat($a))[9] } @files;

# Remove older versions if more than 5
if (@files > 5) {
	print "Cleaning up older versions...\n";
	while (@files > 5) {
		my $old_file = pop @files;  # pop gets the oldest file
		print "Deleting old version: $old_file\n";
		unlink($old_file) or warn "Could not delete $old_file: $!";
	}
}

print "$0 done.\n";
