[Skip to content](#start-of-content)   



## Navigation Menu

[Sign in](/login?return_to=https%3A%2F%2Fgithub.com%2FGenymobile%2Fscrcpy%2Fblob%2Fmaster%2Fdoc%2Fwindows.md) 

Appearance settings

# Search code, repositories, users, issues, pull requests...

[Search syntax tips](https://docs.github.com/search-github/github-code-search/understanding-github-code-search-syntax)

[Sign in](/login?return_to=https%3A%2F%2Fgithub.com%2FGenymobile%2Fscrcpy%2Fblob%2Fmaster%2Fdoc%2Fwindows.md)

 [Sign up](/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F%3Cuser-name%3E%2F%3Crepo-name%3E%2Fblob%2Fshow&source=header-repo&source_repo=Genymobile%2Fscrcpy) 

Appearance settings

You signed in with another tab or window. Reload to refresh your session. You signed out in another tab or window. Reload to refresh your session. You switched accounts on another tab or window. Reload to refresh your session. Dismiss alert

{{ message }}

### Uh oh!

There was an error while loading. Please reload this page.

[Genymobile](/Genymobile)   /  **[scrcpy](/Genymobile/scrcpy)**  Public

* ### Uh oh!

  There was an error while loading. Please reload this page.
* [Notifications](/login?return_to=%2FGenymobile%2Fscrcpy)  You must be signed in to change notification settings
* [Fork 13.4k](/login?return_to=%2FGenymobile%2Fscrcpy)
* [Star  146k](/login?return_to=%2FGenymobile%2Fscrcpy)

## Expand file tree

/

# windows.md

Copy path

More file actions

More file actions

## Latest commit

## History

[History](/Genymobile/scrcpy/commits/master/doc/windows.md)

History

96 lines (64 loc) · 2.54 KB

/

# windows.md

Copy path

## File metadata and controls

96 lines (64 loc) · 2.54 KB

[Raw](https://github.com/Genymobile/scrcpy/raw/refs/heads/master/doc/windows.md)

Copy raw file

Download raw file

Outline

Edit and raw actions

# On Windows

## Install

### From the official release

Download the [latest release](https://github.com/Genymobile/scrcpy/releases/latest):

* [`scrcpy-win64-v4.1.zip`](https://github.com/Genymobile/scrcpy/releases/download/v4.1/scrcpy-win64-v4.1.zip) (64-bit)  
   SHA-256: `5b12172b3264b2889f4583ee64752ce832e29bc8b1089dca81093459697165db`
* [`scrcpy-win32-v4.1.zip`](https://github.com/Genymobile/scrcpy/releases/download/v4.1/scrcpy-win32-v4.1.zip) (32-bit)  
   SHA-256: `fa57b36622a53b6aec74c5e5b5c08236165efa445c4f186d48f176ebf9c24eec`

and extract it.

### From a package manager

From [WinGet](https://github.com/microsoft/winget-cli) (ADB and other dependencies will be installed alongside scrcpy):

```
winget install --exact Genymobile.scrcpy
```

From [Chocolatey](https://chocolatey.org/):

```
# if you don't have it yet #
```

From [Scoop](https://scoop.sh):

```
# if you don't have it yet #
```

*See [build.md](/Genymobile/scrcpy/blob/master/doc/build.md) to build and install the app manually.*

*Make sure that your device meets the [prerequisites](/Genymobile/scrcpy/blob/master/README.md#prerequisites).*

Scrcpy is a command line application: it is mainly intended to be executed from a terminal with command line arguments.

To open a terminal at the expected location, double-click on `open_a_terminal_here.bat` in your scrcpy directory, then type your command. For example, without arguments:

or with arguments (here to disable audio and record to `file.mkv`):

```
scrcpy --no-audio --record=file.mkv
```

Documentation for command line arguments is available:

* `scrcpy --help`
* on [github](/Genymobile/scrcpy/blob/master/README.md)

If you plan to always use the same arguments, create a file `myscrcpy.bat` (enable [show file extensions](https://www.howtogeek.com/205086/beginner-how-to-make-windows-show-file-extensions/) to avoid confusion) containing your command, For example:

```
scrcpy --prefer-text --turn-screen-off --stay-awake
```

Add `--pause-on-exit=if-error` if you want the console to remain open when scrcpy fails:

```
scrcpy --prefer-text --turn-screen-off --stay-awake --pause-on-exit=if-error
```

Then just double-click on that file to run it.

To start scrcpy without opening a terminal, double-click `scrcpy-noconsole.vbs` (note that errors won't be shown). To pass arguments, edit (a copy of) `scrcpy-noconsole.vbs` and add the desired arguments.

You can’t perform that action at this time.

 
