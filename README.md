# update-kolmafia

Perl script to automatically download the latest [KoLmafia](https://github.com/kolmafia/kolmafia) release JAR into the current working directory and then create a symlink named `KoLmafia-latest.jar` to it. This is both safer and different from other updaters I have seen, as the ones I've seen all either move and/or delete files, which can cause issues if there are instances of kolmafia running during that process. Using a symlink to run kolmafia sidesteps basically all issues that moving and/or deleting a currently in-used file can have, as well as give a consistent name from which to run it from.

## Usage

The perl script requires perl be installed on the machine.

### &ast;nix

If perl is not installed on a &ast; machine, use the package manager to install `perl`. From there `perl update-kolmafia.pl` from the kolmafia directory will let it do its thing.

### Windows

Unfortunately, on Windows, in order to create symlinks, the script needs to run as admin. If this is something you don't want to do, you'll have to find another updater. Or you can modify this script to not bother with symlinks, and it will be able to download the latest kolmafia version to the directory just fine--of course without making the symlink.

There needs to be a perl environment of some sort installed. I use [strawberry perl](https://strawberryperl.com), but [ActiveState](https://www.activestate.com/products/perl/)'s should probably work fine.

After a perl environment is set up, 2 additional modules need to be installed via the windows command line using `cpan` in order for the script to create symlinks:

```
> cpan Win32::Symlinks
> cpan Win32::RunAsAdmin
```

After that is done, the perl script can be run from the kolmafia directory, either by double-clicking on it or with `perl update-kolmafia.pl` on the command line. Unfortunately, there will be a UAC popup any time it is run without admin privileges.

