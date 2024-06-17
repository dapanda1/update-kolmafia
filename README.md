# update-kolmafia

Perl script to check the GitHub API for the latest release of [KoLmafia](https://github.com/kolmafia/kolmafia), then downloads the JAR version of it if it does not already exist, and then creates a symlink named `KoLmafia-latest.jar` to it&mdash;which can then be used to launch the latest version of KoLmafia in lieu of needing to know the exact name of the latest version.

## Usage

The `update-kolmafia.pl` file will need to be placed in the in the base kolmafia directory in the same place as the `KoLmafia-XXXXX.jar` file(s). From there, if Perl is installed, it should be as simple as running this in a terminal or command line from the directory:

`perl update-kolmafia.pl`

To skip creating the symlink, the `--nosymlink` option can be used as such:

`perl update-kolmafia.pl --nosymlink`

## Perl is Required

The script requires Perl be installed. So if the above did not work, or if using Windows, check the following two sections:

### Unix-like Oses

Perl is generally pre-installed with MacOS, most Linux distributions, and other Unix-like OSes. If Perl is somehow not installed, you should be able to easily install it via the package manager, app store, or other way your flavor of OS uses to let you install software from their repository. As a last resort, the Perl site can direct you where to download binaries for it: https://www.perl.org/get.html

### Windows OS

Unfortunately, on Windows, in order to create symlinks, the script needs to be run as admin. If you do not want the script running as admin, you can still get the rest of the non-symlink benefits with the `--nosymlink` option as stated in the [usage section](#usage), then you can also skip the installing of additional modules with `cpan` when it comes up.

Firstly, there needs to be a Perl environment of some sort installed. I use [strawberry perl](https://strawberryperl.com), but [ActiveState](https://www.activestate.com/products/perl/)'s should probably work fine.

After a Perl environment is set up, 2 additional modules need to be installed via the windows command line using `cpan` in order for the script to create symlinks:

```
cpan Win32::Symlinks
cpan Win32::RunAsAdmin
```

After that is done, the Perl script can be run from the kolmafia directory, either by double-clicking on it or with `perl update-kolmafia.pl` on the command line. Unfortunately, there will be a UAC popup any time the script is started without admin privileges if making the symlink.

