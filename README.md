# update-kolmafia

Perl script to check the GitHub API for the latest release of [KoLmafia](https://github.com/kolmafia/kolmafia), then downloads the JAR version of it if it does not already exist, and then creates a symlink named `KoLmafia-latest.jar` to it&mdash;which can then be used to launch the latest version of KoLmafia in lieu of needing to know the exact name of the latest version.

## Usage

The `update-kolmafia.pl` file will need to be placed in the in the base kolmafia directory in the same place as the `KoLmafia-XXXXX.jar` file(s). From there, if Perl is installed, it should be as simple as running this in a terminal or command line from the directory:

`perl update-kolmafia.pl`

To skip creating the symlink, the `--nosymlink` option can be used as such:

`perl update-kolmafia.pl --nosymlink`

## Perl is Required

The script requires Perl be installed. Some modules are required as well, which can be installed via `cpan` in the terminal or on the command line if they are not already installed like so:

```
cpan LWP::Simple
cpan Getopt::Long
```

If the script still doesn't work after doing the above, or if there are errors trying the above, check the following two sections:

### Unix-like OSes

Perl is generally pre-installed with MacOS, most Linux distributions, and other Unix-like OSes. If Perl is somehow not installed, it should be able to easily installed via the package manager, app store, or other way the flavor of OS uses to install software from their repository. As a last resort, the Perl site can direct you where to download binaries for it: https://www.perl.org/get.html

### Windows OSes

Firstly, there needs to be a Perl environment of some sort installed. I use [strawberry perl](https://strawberryperl.com), but [ActiveState](https://www.activestate.com/products/perl/)'s should probably work fine.

If you don't care about making the symlink, then you don't need to do anything else and the script should run fine as in the [usage section](#usage). Because unfortunately, in order to make symlinks under Windows, the script will need to be run as an administrator and additional modules are required.

The additional modules that are required to make symlinks under Windows can be installed with `cpan` on the command line:

```
cpan Win32::Symlinks
cpan Win32::RunAsAdmin
```

There will be a UAC popup any time the script is started without admin privileges if making the symlink.

