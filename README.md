# update-kolmafia

Perl script to check the GitHub API for the latest release of [KoLmafia](https://github.com/kolmafia/kolmafia), then downloads the JAR version of it if it does not already exist, and then creates a symlink named `KoLmafia-latest.jar` to it&mdash;which can then be used to launch the latest version of KoLmafia in lieu of needing to know the exact name of the latest version.

## Usage

The `update-kolmafia.pl` file will need to be placed in the in the base kolmafia directory in the same place as the `KoLmafia-XXXXX.jar` file(s). From there, if Perl is installed, it should be as simple as running this in a terminal or command line from the directory:

`perl update-kolmafia.pl`

To skip creating the symlink, the `--nosymlink` option can be used as such:

`perl update-kolmafia.pl --nosymlink`

## Perl is Required

The script requires Perl be installed. So if the above did not work, or if using Windows, check the following two sections:

### Unix-like OSes

Perl is generally pre-installed with MacOS, most Linux distributions, and other Unix-like OSes. If Perl is somehow not installed, it should be able to easily installed via the package manager, app store, or other way the flavor of OS uses to install software from their repository. As a last resort, the Perl site can direct you where to download binaries for it: https://www.perl.org/get.html

### Windows OSes

Firstly, there needs to be a Perl environment of some sort installed. I use [strawberry perl](https://strawberryperl.com), but [ActiveState](https://www.activestate.com/products/perl/)'s should probably work fine.

Two verisons of the script are available to Windows based on whether you want symlink creation to work or not:

#### update-kolmafia.pl

`update-kolmafia.pl` works on Windows for everything except symlink creation.

#### update-kolmafia-win32.pl

`update-kolmafia-win32.pl` is for symlink creation to work on Windows, however, it requires additional modules and to be run as administrator.

The additional modules required to make this work and can be installed with `cpan` on the command line:

```
cpan Win32::Symlinks
cpan Win32::RunAsAdmin
```

Unfortunately, on Windows, there will be a UAC popup any time the script is started without admin privileges if making the symlink.

