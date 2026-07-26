![Android Developers](https://www.gstatic.com/devrel-devsite/prod/v86d4242899d0b9c3c3542409bdd63e021381cf8309eb1da531e08bd4193a5020/android/images/lockup.png)
![Android Developers](https://www.gstatic.com/devrel-devsite/prod/v86d4242899d0b9c3c3542409bdd63e021381cf8309eb1da531e08bd4193a5020/android/images/lockup.png)

# Android Debug Bridge (adb) Stay organized with collections Save and categorize content based on your preferences.

Android Debug Bridge (`adb`) is a versatile command-line tool that lets you communicate with a
device. The `adb` command facilitates a variety of device actions, such as installing and
debugging apps. `adb` provides access to a Unix shell that you can use to run a variety
of commands on a device. It is a client-server program that includes three components:

`adb`
`adb`
`adb`
`adb`

`adb` is included in the Android SDK Platform Tools package. Download this
package with the [SDK Manager](/studio/intro/update#sdk-manager), which installs
it at `android_sdk/platform-tools/`. If you want the standalone Android SDK
Platform Tools package, [download it here](/studio/releases/platform-tools).

`adb`
`android_sdk/platform-tools/`

For information on connecting a device for use over `adb`, including how to use the Connection
Assistant to troubleshoot common problems, see
[Run apps on a hardware device](/studio/run/device).

`adb`

## How adb works

When you start an `adb` client, the client first checks whether there is an
`adb` server process already running. If there isn't, it starts the server process.
When the server starts, it binds to local TCP port 5037 and listens for commands sent from
`adb` clients.

`adb`
`adb`
`adb`

**Note:** All `adb` clients use port 5037 to communicate
with the `adb` server.

`adb`
`adb`

The server then sets up connections to all running devices.
It locates emulators by scanning odd-numbered ports in the range
5555 to 5585, which is the range used by the first 16 emulators. Where the server finds an `adb`
daemon (adbd), it sets up a connection to that port.

`adb`

Each emulator uses a pair of sequential ports — an even-numbered port for
console connections and an odd-numbered port for `adb` connections. For example:

`adb`

Emulator 1, console: 5554  
Emulator 1, `adb`: 5555  
Emulator 2, console: 5556  
Emulator 2, `adb`: 5557  
and so on.

`adb`
`adb`

As shown, the emulator connected to `adb` on port 5555 is the same as the emulator
whose console listens on port 5554.

`adb`

Once the server has set up connections to all devices, you can use `adb` commands to
access those devices. Because the server manages connections to devices and handles
commands from multiple `adb` clients, you can control any device from any client or
from a script.

`adb`
`adb`

## Enable adb debugging on your device

To use adb with a device connected over USB, you must enable
**USB debugging** in the device system settings, under **Developer options**. On Android 4.2 (API level 17) and higher, the **Developer options** screen
is hidden by default. To make it visible, [enable
Developer options.](/studio/debug/dev-options#enable)

You can now connect your device with USB. You can verify that your device is
connected by executing `adb devices` from the
`android_sdk/platform-tools/` directory. If connected,
you'll see the device name listed as a "device."

`adb devices`
`android_sdk/platform-tools/`

**Note:** When you connect a device running Android 4.2.2 (API
level 17) or higher, the system shows a dialog asking whether to accept an RSA key that allows
debugging through this computer. This security mechanism protects user devices because it ensures
that USB debugging and other adb commands cannot be executed unless you're able to unlock the
device and acknowledge the dialog.

For more information about connecting to a device over USB, read
[Run apps on a hardware device](/studio/run/device).

## Connect to a device over Wi-Fi

**Note:** The instructions below do not apply to Wear devices running
Android 11 (API level 30). See the guide to
[debugging a Wear OS app](/training/wearables/get-started/debugging#wifi-debugging) for
more information.

Android 11 (API level 30) and higher support deploying and debugging your app wirelessly from
your workstation using Android Debug Bridge (adb). For example, you can deploy your debuggable
app to multiple remote devices without ever needing to physically connect your device via
USB. This eliminates the need to deal with common USB connection issues, such as driver
installation.

Android 17, alongside [adb 37.0.0](/tools/releases/platform-tools) introduces
adb Wi-Fi 2.0 which solves many of the usability issues with the previous version. Notably, the
device will automatically connect to the workstation when the device connects to a wireless
debugging trusted network.

Before you begin using wireless debugging, do the following:

Ensure that your workstation and device are connected to the same wireless network.

Ensure that your device is running Android 11 (API level 30) or higher for phone or Android
13 (API level 33) or higher for TV and WearOS. For more information, see
[Check & update your
Android version](https://support.google.com/android/answer/7680439).

On your workstation, update to the latest version of the
[SDK Platform Tools](/tools/releases/platform-tools).

To use wireless debugging, you must pair your device to your workstation using a QR code or a
pairing code. Your workstation and device must be connected to the same wireless network. To
pair to your device, follow these steps:

**Note:** You only need to pair your device to your workstation
once. The device will remain paired with your workstation until you explicitly forget it or
revoke adb debugging authorizations on your device.
The device and the workstation will automatically connect when they are on the same network.

[Enable developer options](/studio/debug/dev-options#enable)
on your device.

On your device, tap **Wireless debugging**:

![Screenshot of a pixel phone showing the Wireless debugging prompt.](/static/studio/images/run/adb_wifi-wireless_debugging_prompt.png)

Allow wireless debugging on your network. Note that clicking the **always allow on this network**
checkbox makes the network a trusted wireless debugging network. Your device will always
allow wireless debugging on this network as soon as the device connects to the network.

![Screenshot of
            a Google Pixel phone showing the Wireless debugging systems setting.](/static/studio/images/run/adb_wifi-wireless_debugging_setting.png)

**Note:** Android Studio users can pair their device with a QR code, select **Pair device with QR code** and scan the
QR code obtained from the [Pair devices over Wi-Fi dialog](/studio/run/device#wireless) 
in Android Studio.

On your device, select **Pair using pairing code** and
take note of the IP address, port number, and pairing code displayed on the device.

On your workstation, open a terminal window and navigate to
`android_sdk/platform-tools`.

`android_sdk/platform-tools`

On your workstation's terminal, run `adb pair ipaddr:port`. Use the IP address
and port number from above.

`adb pair ipaddr:port`

When prompted, enter the pairing code, as shown below.

![Screenshot of
            pairing on the command line.](/static/studio/images/run/adb_wifi-cmd_line_pairing.png)

After your device is paired, [verify that your device is connected.](/tools/adb#devicestatus)
You can now use your device wirelessly similar to how you would with a USB connection.

To unpair your workstation, navigate to **Wireless debugging** on your device.
Tap your workstation name under **Paired devices** and select **Forget**.
Alternatively, you can click the **Revoke adb debugging authorizations** on your device
Settings page to unapair your workstation and all other previously paired workstations.

If you want to quickly turn on and off wireless debugging, you can utilize the
[Quick settings developer tiles](/studio/debug/dev-options#general) for
**Wireless debugging**, found in **Developer Options** > **Quick settings developer
tiles**.

![Screenshot of
            Quick settings developer tiles from a Google Pixel phone.](/static/studio/images/run/adb_wifi-quick_settings.png)

### Resolve wireless connection issues

If you are having issues connecting to your device wirelessly, try the following
troubleshooting steps to resolve the issue.

#### Check whether your workstation and device meet the prerequisites

Check that the workstation and device meet the prerequisites listed at the
[beginning of this section](/tools/adb#wireless-adb-android-11).

#### Check whether the adb setup on your workstation is correct

To verify that your ADB setup on your workstation is correct, open a terminal on your
workstation and enter `adb server-status`. Verify that the output shows the following:

`adb server-status`
`version: "37.0.0"`
`mdns_enabled: true`
`false`
`ADB_MDNS`
`1`
`adb kill-server`
`adb start-server`
`mdns_backend: LIBADBMDNS`
`ADB_MDNS_OPENSCREEN`
`0`
`adb kill-server`
`adb start-server`

#### Check whether your network supports mDNS

adb relies on mDNS to automatically discover and connect to paired devices.
To check whether your network supports mDNS, do the following:

On your device, enable wireless debugging as described in the
[Connect to a device over Wi-Fi](#wireless-adb-android-11) section.

On your workstation, open a terminal and enter `adb mdns track-services --proto-text`.

`adb mdns track-services --proto-text`

Verify that the output isn't empty and contains a tls service with the IP address and
port number of your device. If the output is empty, then your network does not support mDNS.
Example output:

#### Check whether your device supports ADB Wi-Fi 2.0

**Note:**
ADB Wi-Fi 2.0 is supported on Android 17 and higher.

To check whether your device supports ADB Wi-Fi 2.0, do the following:

On your device, enable wireless debugging as described in the
[Connect to a device over Wi-Fi](#wireless-adb-android-11) section.

On your workstation, open a terminal and enter `adb mdns track-services --proto-text`.

`adb mdns track-services --proto-text`

Verify that the output contains `mdns_service_version: "2.0"` or higher. If this is not the case, then your device is not running Android 17 or higher and doesn't support ADB Wi-Fi 2.0.
To update to Android 17 or higher, check whether your device has any pending system updates.
[Check & update your
Android version](https://support.google.com/android/answer/7680439).

`mdns_service_version: "2.0"`

#### Report a new issue

If you are still having issues connecting to your device wirelessly, you can report [a new issue](https://issuetracker.google.com/issues/new?component=192795&template=1310483).
Please ensure that you provide the following information in your report:

* **The logs from your device:** Reproduce the issue and attach the [device logs](/studio/debug/bug-report)
* **The logs from adb on your workstation:**
  1. **Set the environment variable** `ADB_TRACE=all`.
  2. **Restart the adb server** by running `adb kill-server` and then `adb start-server`.
  3. **Reproduce the issue.**
  4. **Locate the log files:** Run `adb server-status` and attach the log file referenced in the output `log_absolute_path`.

`ADB_TRACE=all`
`adb kill-server`
`adb start-server`
`adb server-status`
`log_absolute_path`

## Connect wirelessly with a device after an initial USB connection (only option available on Android 10 and lower)

**Note:** This workflow is applicable also to Android 11 (and
higher), the caveat being that it also involves an \*initial\* connection over physical USB.

**Note:** The following instructions do not apply to Wear devices
running Android 10 (API level 29) or lower. See the guide about
[debugging a Wear OS app](/training/wearables/get-started/debugging#wifi-debugging) for
more information.

`adb` usually communicates with the device over USB, but you can also use
`adb` over Wi-Fi. To connect a device running Android 10 (API level 29) or lower,
follow these initial steps over USB:

`adb`
`adb`
`adb`

**Note:** Beware that not all access points
are suitable. You might need to use an access point
whose firewall is configured properly to support `adb`.

`adb`

Your device is now connected to `adb`.

`adb`

If the `adb` connection to your device is lost:

`adb`
`adb connect`
`adb`

Then start over from the beginning.

## Query for devices

Before issuing `adb` commands, it is helpful to know what device instances are connected
to the `adb` server. Generate a list of attached devices using the
`devices` command:

`adb`
`adb`
`devices`

In response, `adb` prints this status information for each device:

`adb`
`adb`
`emulator-5554`
`offline`
`adb`
`device`
`adb`
`adb`
`no device`
`-l`
`devices`

The following example shows the `devices` command and its output. There are three
devices running. The first two lines in the list are emulators, and the third line is a hardware
device that is attached to the computer.

`devices`

### Emulator not listed

The `adb devices` command has a corner-case command sequence that causes running
emulators to not show up in the `adb devices` output even though
the emulators are visible on your desktop. This happens when *all* of the following
conditions are true:

`adb devices`
`adb devices`
`adb`
`emulator`
`-port`
`-ports`
`adb`

One way to avoid this situation is to let the emulator choose its own ports and to run no more
than 16 emulators at once. Another way is to always start the `adb` server before you
use the `emulator` command, as explained in the following examples.

`adb`
`emulator`

**Example 1:** In the following command sequence, the `adb devices` command starts
the `adb` server, but the list of devices does not appear.

`adb devices`
`adb`

Stop the `adb` server and enter the following commands in the order shown. For the AVD
name, provide a valid AVD name from your system. To get a list of AVD names, type
`emulator -list-avds`. The `emulator` command is in the
`android_sdk/tools` directory.

`adb`
`emulator -list-avds`
`emulator`
`android_sdk/tools`

**Example 2:** In the following command sequence, `adb devices` displays the
list of devices because the `adb` server was started first.

`adb devices`
`adb`

To see the emulator in the `adb devices` output, stop the `adb` server, and
then start it again after using the `emulator` command and before using the
`adb devices` command, as follows:

`adb devices`
`adb`
`emulator`
`adb devices`

For more information about emulator command-line options,
see [Command-Line
startup options](/studio/run/emulator-commandline#startup-options).

## Send commands to a specific device

If multiple devices are running, you must specify the target device
when you issue the `adb` command.
To specify the target, follow these steps:

1. Use the `devices` command to get the serial number of the target.
2. Once you have the serial number, use the
   `-s` option with the `adb` commands to specify the serial number.
   1. If you're going to issue a lot of `adb` commands, you can set the
      `$ANDROID_SERIAL` environment variable to contain the serial number
      instead.
   2. If you use both
      `-s` and `$ANDROID_SERIAL`, `-s` overrides
      `$ANDROID_SERIAL`.

`adb`
`devices`
`-s`
`adb`
`adb`
`$ANDROID_SERIAL`
`-s`
`$ANDROID_SERIAL`
`-s`
`$ANDROID_SERIAL`

In the following example, the list of attached devices is obtained, and then the serial
number of one of the devices is used to install the `helloWorld.apk` on that device:

`helloWorld.apk`

**Note:** If you issue a command without specifying a target device
when multiple devices are available, `adb` displays an error
"adb: more than one device/emulator".

`adb`

If you have multiple devices available but only one is an emulator,
use the `-e` option to send commands to the emulator. If there are multiple
devices but only one hardware device attached, use the `-d` option to send commands to
the hardware device.

`-e`
`-d`

## Install an app

You can use `adb` to install an APK on an emulator or connected device
with the `install` command:

`adb`
`install`

You must use the `-t` option with the `install`
command when you install a test APK. For more information,
see [`-t`](#-t-option).

`-t`
`install`
`-t`

To install multiple APKs use `install-multiple`. This is useful if you download all
the APKs for a specific device for your app from the Play Console and want to install them on an
emulator or physical device.

`install-multiple`

For more information about how to create an APK file that you can install on an emulator/device
instance, see [Build and run your app](/studio/run).

**Note:** If you are using Android Studio, you do not need to use
`adb` directly to install your app on the emulator or device. Instead, Android Studio
handles the packaging and installation of the app for you.

`adb`

## Set up port forwarding

Use the `forward` command to set up arbitrary port forwarding, which
forwards requests on a specific host port to a different port on a device.
The following example sets up forwarding of host port 6100 to device port 7100:

`forward`

The following example sets up forwarding of host port 6100 to local:logd:

This could be useful if you are trying to detemine what is being sent to a given port on the
device. All received data will be written to the system-logging daemon and displayed
in the device logs.

## Copy files to and from a device

Use the `pull` and `push` commands to copy files to
and from a device. Unlike the `install` command,
which only copies an APK file to a specific location, the `pull` and `push`
commands let you copy arbitrary directories and files to any location in a device.

`pull`
`push`
`install`
`pull`
`push`

To copy a file or directory and its sub-directories *from* the device,
do the following:

To copy a file or directory and its sub-directories *to* the device,
do the following:

Replace `local` and `remote` with the paths to
the target files/directory on your development machine (local) and on the
device (remote). For example:

`local`
`remote`

## Stop the adb server

In some cases, you might need to terminate the `adb` server process and then restart
it to resolve the problem. For example, this could be the case if `adb` does not respond to a command.

`adb`
`adb`

To stop the `adb` server, use the `adb kill-server` command.
You can then restart the server by issuing any other `adb` command.

`adb`
`adb kill-server`
`adb`

## Issue adb commands

Issue `adb` commands from a command line on your development machine or from a script using the
following:

`adb`

If there's only one emulator running or only one device connected, the `adb` command is
sent to that device by default. If multiple emulators are running and/or multiple devices are
attached, you need to use the `-d`, `-e`, or `-s`
option to specify the target device to which the command should be directed.

`adb`
`-d`
`-e`
`-s`

You can see a detailed list of all supported `adb` commands using the following
command:

`adb`

## Issue shell commands

You can use the `shell` command to issue device commands through `adb` or to start an
interactive shell. To issue a single command, use the `shell` command like this:

`shell`
`adb`
`shell`

To start an interactive shell on a device, use the `shell` command like this:

`shell`

To exit an interactive shell, press `Control+D` or type `exit`.

`Control+D`
`exit`

Android provides most of the usual Unix command-line tools. For a list of available tools, use
the following command:

Help is available for most of the commands via the `--help` argument.
Many of the shell commands are provided by
[toybox](http://landley.net/toybox/).
General help applicable to all toybox commands is available via `toybox --help`.

`--help`
`toybox --help`

With Android Platform Tools 23 and higher, `adb` handles arguments the same way that
the `ssh(1)` command does. This change has fixed a lot of problems with
[command injection](https://en.wikipedia.org/wiki/Code_injection#Shell_injection)
and makes it possible to safely execute commands that contain shell
[metacharacters](https://en.wikipedia.org/wiki/Metacharacter),
such as `adb install Let\'sGo.apk`. This change means that the interpretation
of any command that contains shell metacharacters has also changed.

`adb`
`ssh(1)`
`adb install Let\'sGo.apk`

For example, `adb shell setprop key 'two words'` is now an error,
because the quotes are swallowed by the local shell, and the device sees
`adb shell setprop key two words`. To make the command work, quote twice,
once for the local shell and once for the remote shell, as you do with
`ssh(1)`. For example, `adb shell setprop key "'two words'"` works because the local shell takes the outer level of quoting and the device
still sees the inner level of quoting: `setprop key 'two words'`. Escaping is
also an option, but quoting twice is usually easier.

`adb shell setprop key 'two words'`
`adb shell setprop key two words`
`ssh(1)`
`adb shell setprop key "'two words'"`
`setprop key 'two words'`

See also [Logcat command-line tool](/studio/command-line/logcat), which is useful
for monitoring the system log.

### Call activity manager

Within an `adb` shell, you can issue commands with the activity manager (`am`) tool to
perform various system actions, such as start an activity, force-stop a process,
broadcast an intent, modify the device screen properties, and more.

`adb`
`am`

While in a shell, the `am` syntax is:

`am`

You can also issue an activity manager command directly from `adb`
without entering a remote shell. For example:

`adb`

**Table 1.** Available activity manager commands

| Command | Description |
| --- | --- |
| `start [options] intent` | Start an `Activity` specified by `intent`. See the [Specification for intent arguments](#IntentSpec). Options are:  * `-D`: Enable debugging.* `-W`: Wait for launch to complete.* `--start-profiler file`: Start profiler and send results to       `file`.* `-P file`: Like `--start-profiler`,         but profiling stops when the app goes idle.* `-R count`: Repeat the activity launch `count`           times. Prior to each repeat,           the top activity will be finished.* `-S`: Force stop the target app before starting the activity.* `--opengl-trace`: Enable tracing of OpenGL functions.* `--user user_id | current`: Specify which user to run as; if not                 specified, then run as the current user. |
| `startservice [options] intent` | Start the `Service` specified by `intent`. See the [Specification for intent arguments](#IntentSpec). Options are:  * `--user user_id | current`: Specify which user to run as. If not   specified, then run as the current user. |
| `force-stop package` | Force-stop everything associated with `package`. |
| `kill [options] package` | Kill all processes associated with `package`. This command kills only processes that are safe to kill and that will not impact the user experience. Options are:  * `--user user_id | all | current`: Specify which user's processes to kill.   If not specified, then kill all users' processes. |
| `kill-all` | Kill all background processes. |
| `broadcast [options] intent` | Issue a broadcast intent. See the [Specification for intent arguments](#IntentSpec). Options are:  * `[--user user_id | all | current]`: Specify which user to send to. If not   specified, then send to all users. |
| `instrument [options] component` | Start monitoring with an `Instrumentation` instance. Typically the target `component` is the form `test_package/runner_class`. Options are:  * `-r`: Print raw results (otherwise decode   `report_key_streamresult`). Use with   `[-e perf true]` to generate raw output for performance measurements.* `-e name value`: Set argument `name`     to `value`.     For test runners a common form is `-e testrunner_flag value[,value...]`.* `-p file`: Write profiling data to `file`.* `-w`: Wait for instrumentation to finish before returning. Required for         test runners.* `--no-window-animation`: Turn off window animations while running.* `--user user_id | current`: Specify which user instrumentation runs in.             If not specified, run in the current user. |
| `profile start process file` | Start profiler on `process`, write results to `file`. |
| `profile stop process` | Stop profiler on `process`. |
| `dumpheap [options] process file` | Dump the heap of `process`, write to `file`. Options are:  * `--user [user_id | current]`: When supplying a process name,   specify the user of the process to dump. If not specified, the current user is used.* `-b [| png | jpg | webp]`: Dump bitmaps from graphics memory (API level 35 and above).     Optionally specify the format to dump in (PNG by default).* `-n`: Dump native heap instead of managed heap. |
| `dumpbitmaps [options] [-p process]` | Dump bitmap information from `process` (API level 36 and above). Options are:  * `-d|--dump [format]`: dump bitmap contents in the   specified `format`, which can be one of   `png`, `jpg`, or `webp`, default to   `png` if none is specified. A zip file   `dumpbitmaps-<time>.zip` will be created with the bitmaps.* `-p process`: dump bitmaps from     `process`, multiple     `-p process` can be specified.  If no `process` is specified, bitmaps from all processes will be dumped. |
| `set-debug-app [options] package` | Set app `package` to debug. Options are:  * `-w`: Wait for debugger when app starts.* `--persistent`: Retain this value. |
| `clear-debug-app` | Clear the package previous set for debugging with `set-debug-app`. |
| `monitor [options]` | Start monitoring for crashes or ANRs. Options are:  * `--gdb`: Start `gdbserv` on the given port at crash/ANR. |
| `screen-compat {on | off} package` | Control [screen compatibility](/guide/practices/screen-compat-mode) mode of `package`. |
| `display-size [reset | widthxheight]` | Override device display size. This command is helpful for testing your app across different screen sizes by mimicking a small screen resolution using a device with a large screen, and vice versa. Example: `am display-size 1280x800` |
| `display-density dpi` | Override device display density. This command is helpful for testing your app across different screen densities by mimicking a high-density screen environment using a low-density screen, and vice versa. Example: `am display-density 480` |
| `to-uri intent` | Print the given intent specification as a URI. See the [Specification for intent arguments](#IntentSpec). |
| `to-intent-uri intent` | Print the given intent specification as an `intent:` URI. See the [Specification for intent arguments](#IntentSpec). |
| `memory-limiter subcommand [options]` | Adjust or disable the [memory limits imposed on devices running Android 17 and higher](/about/versions/17/behavior-changes-all#app-memory-limits). Has no effect on devices running Android 16 and lower.  Subcommands are:   * `ignore uid|none|all`: Instructs the memory limiter to ignore some or   all processes. Passing a UID (Android User ID) instructs the memory limiter to ignore   enforcement on all processes associated with that UID. You can also pass `all`   (ignore all apps) or `none` (do not ignore any apps). Passing `none`   overrides any previous calls to `am memory-limiter ignore`.  If you instruct the memory limiter to ignore a UID, you can still apply a manual memory   limit to a process within the app by calling `am memory-limiter manual`. * `manual pid limit|max|none`: Instructs the system to   impose a memory constraint on the process with the specified PID (Process ID). The memory   constraint is specified as an integer number of MB; for example, passing 30 specifies that   the process is limited to 30 MB of memory. Passing `max` removes all memory   limits on that process. Passing `none` removes any manual limits set on the   process, restoring the system's default limit (if any). * `status`: Reports the current status of the memory limiter. The status includes   the memory limits imposed on visible and non-visible processes. |

`start [options] intent`
`Activity`
`intent`

See the
[Specification for intent arguments](#IntentSpec).

Options are:

* `-D`: Enable debugging.* `-W`: Wait for launch to complete.* `--start-profiler file`: Start profiler and send results to
      `file`.* `-P file`: Like `--start-profiler`,
        but profiling stops when the app goes idle.* `-R count`: Repeat the activity launch `count`
          times. Prior to each repeat,
          the top activity will be finished.* `-S`: Force stop the target app before starting the activity.* `--opengl-trace`: Enable tracing of OpenGL functions.* `--user user_id | current`: Specify which user to run as; if not
                specified, then run as the current user.

Options are:

* `-D`: Enable debugging.* `-W`: Wait for launch to complete.* `--start-profiler file`: Start profiler and send results to
      `file`.* `-P file`: Like `--start-profiler`,
        but profiling stops when the app goes idle.* `-R count`: Repeat the activity launch `count`
          times. Prior to each repeat,
          the top activity will be finished.* `-S`: Force stop the target app before starting the activity.* `--opengl-trace`: Enable tracing of OpenGL functions.* `--user user_id | current`: Specify which user to run as; if not
                specified, then run as the current user.

`-D`
`-W`
`--start-profiler file`
`file`
`-P file`
`--start-profiler`
`-R count`
`count`
`-S`
`--opengl-trace`
`--user user_id | current`
`startservice [options] intent`
`Service`
`intent`

See the
[Specification for intent arguments](#IntentSpec).

Options are:

* `--user user_id | current`: Specify which user to run as. If not
  specified, then run as the current user.

Options are:

* `--user user_id | current`: Specify which user to run as. If not
  specified, then run as the current user.

`--user user_id | current`
`force-stop package`
`package`
`kill [options] package`
`package`

Options are:

* `--user user_id | all | current`: Specify which user's processes to kill.
  If not specified, then kill all users' processes.

`--user user_id | all | current`
`kill-all`
`broadcast [options] intent`

See the
[Specification for intent arguments](#IntentSpec).

Options are:

* `[--user user_id | all | current]`: Specify which user to send to. If not
  specified, then send to all users.

Options are:

* `[--user user_id | all | current]`: Specify which user to send to. If not
  specified, then send to all users.

`[--user user_id | all | current]`
`instrument [options] component`
`Instrumentation`
`component`
`test_package/runner_class`

Options are:

* `-r`: Print raw results (otherwise decode
  `report_key_streamresult`). Use with
  `[-e perf true]` to generate raw output for performance measurements.* `-e name value`: Set argument `name`
    to `value`.
    For test runners a common form is `-e testrunner_flag value[,value...]`.* `-p file`: Write profiling data to `file`.* `-w`: Wait for instrumentation to finish before returning. Required for
        test runners.* `--no-window-animation`: Turn off window animations while running.* `--user user_id | current`: Specify which user instrumentation runs in.
            If not specified, run in the current user.

`-r`
`report_key_streamresult`
`[-e perf true]`
`-e name value`
`name`
`value`
`-e testrunner_flag value[,value...]`
`-p file`
`file`
`-w`
`--no-window-animation`
`--user user_id | current`
`profile start process file`
`process`
`file`
`profile stop process`
`process`
`dumpheap [options] process file`
`process`
`file`

Options are:

* `--user [user_id | current]`: When supplying a process name,
  specify the user of the process to dump. If not specified, the current user is used.* `-b [| png | jpg | webp]`: Dump bitmaps from graphics memory (API level 35 and above).
    Optionally specify the format to dump in (PNG by default).* `-n`: Dump native heap instead of managed heap.

`--user [user_id | current]`
`-b [| png | jpg | webp]`
`-n`
`dumpbitmaps [options] [-p process]`
`process`

Options are:

* `-d|--dump [format]`: dump bitmap contents in the
  specified `format`, which can be one of
  `png`, `jpg`, or `webp`, default to
  `png` if none is specified. A zip file
  `dumpbitmaps-<time>.zip` will be created with the bitmaps.* `-p process`: dump bitmaps from
    `process`, multiple
    `-p process` can be specified.

If no `process` is specified, bitmaps from all
processes will be dumped.

`-d|--dump [format]`
`format`
`png`
`jpg`
`webp`
`png`
`dumpbitmaps-<time>.zip`
`-p process`
`process`
`-p process`
`process`
`set-debug-app [options] package`
`package`

Options are:

* `-w`: Wait for debugger when app starts.* `--persistent`: Retain this value.

`-w`
`--persistent`
`clear-debug-app`
`set-debug-app`
`monitor [options]`

Options are:

* `--gdb`: Start `gdbserv` on the given port at crash/ANR.

`--gdb`
`gdbserv`
`screen-compat {on | off} package`
`package`
`display-size [reset | widthxheight]`

Example:  
`am display-size 1280x800`

`am display-size 1280x800`
`display-density dpi`

Example:  
`am display-density 480`

`am display-density 480`
`to-uri intent`

See the
[Specification for intent arguments](#IntentSpec).

`to-intent-uri intent`
`intent:`

See the
[Specification for intent arguments](#IntentSpec).

`memory-limiter subcommand [options]`

Adjust or disable the [memory
limits imposed on devices running Android 17 and higher](/about/versions/17/behavior-changes-all#app-memory-limits). Has no effect on devices running
Android 16 and lower.

Subcommands are:

`ignore uid|none|all`: Instructs the memory limiter to ignore some or
all processes. Passing a UID (Android User ID) instructs the memory limiter to ignore
enforcement on all processes associated with that UID. You can also pass `all`
(ignore all apps) or `none` (do not ignore any apps). Passing `none`
overrides any previous calls to `am memory-limiter ignore`.

`ignore uid|none|all`
`all`
`none`
`none`
`am memory-limiter ignore`

If you instruct the memory limiter to ignore a UID, you can still apply a manual memory
limit to a process within the app by calling `am memory-limiter manual`.

`am memory-limiter manual`
`manual pid limit|max|none`
`max`
`none`
`status`

#### Specification for intent arguments

For activity manager commands that take an `intent` argument, you can
specify the intent with the following options:

`intent`

Show all

`-a action`
`android.intent.action.VIEW`
`-d data_uri`
`content://contacts/people/1`
`-t mime_type`
`image/png`
`-c category`
`android.intent.category.APP_CONTACTS`
`-n component`
`com.example.app/.ExampleActivity`
`-f flags`
`setFlags()`
`--esn extra_key`
`-e | --es extra_key extra_string_value`
`--ez extra_key extra_boolean_value`
`--ei extra_key extra_int_value`
`--el extra_key extra_long_value`
`--ef extra_key extra_float_value`
`--eu extra_key extra_uri_value`
`--ecn extra_key extra_component_name_value`
`ComponentName`
`--eia extra_key extra_int_value[,extra_int_value...]`
`--ela extra_key extra_long_value[,extra_long_value...]`
`--efa extra_key extra_float_value[,extra_float_value...]`
`--grant-read-uri-permission`
`FLAG_GRANT_READ_URI_PERMISSION`
`--grant-write-uri-permission`
`FLAG_GRANT_WRITE_URI_PERMISSION`
`--debug-log-resolution`
`FLAG_DEBUG_LOG_RESOLUTION`
`--exclude-stopped-packages`
`FLAG_EXCLUDE_STOPPED_PACKAGES`
`--include-stopped-packages`
`FLAG_INCLUDE_STOPPED_PACKAGES`
`--activity-brought-to-front`
`FLAG_ACTIVITY_BROUGHT_TO_FRONT`
`--activity-clear-top`
`FLAG_ACTIVITY_CLEAR_TOP`
`--activity-clear-when-task-reset`
`FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET`
`--activity-exclude-from-recents`
`FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS`
`--activity-launched-from-history`
`FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY`
`--activity-multiple-task`
`FLAG_ACTIVITY_MULTIPLE_TASK`
`--activity-no-animation`
`FLAG_ACTIVITY_NO_ANIMATION`
`--activity-no-history`
`FLAG_ACTIVITY_NO_HISTORY`
`--activity-no-user-action`
`FLAG_ACTIVITY_NO_USER_ACTION`
`--activity-previous-is-top`
`FLAG_ACTIVITY_PREVIOUS_IS_TOP`
`--activity-reorder-to-front`
`FLAG_ACTIVITY_REORDER_TO_FRONT`
`--activity-reset-task-if-needed`
`FLAG_ACTIVITY_RESET_TASK_IF_NEEDED`
`--activity-single-top`
`FLAG_ACTIVITY_SINGLE_TOP`
`--activity-clear-task`
`FLAG_ACTIVITY_CLEAR_TASK`
`--activity-task-on-home`
`FLAG_ACTIVITY_TASK_ON_HOME`
`--receiver-registered-only`
`FLAG_RECEIVER_REGISTERED_ONLY`
`--receiver-replace-pending`
`FLAG_RECEIVER_REPLACE_PENDING`
`--selector`
`-d`
`-t`
`URI component package`

### Call package manager (`pm`)

`pm`

Within an `adb` shell, you can issue commands with the package manager (`pm`) tool to
perform actions and queries on app packages installed on the device.

`adb`
`pm`

While in a shell, the `pm` syntax is:

`pm`

You can also issue a package manager command directly from `adb`
without entering a remote shell. For example:

`adb`
`com.example.MyApp`

**Table 2.** Available package manager commands

| Command | Description |
| --- | --- |
| `list packages [options] filter` | Print all packages, optionally only those whose package name contains the text in `filter`. Options:  * `-f`: See associated file.* `-d`: Filter to only show disabled packages.* `-e`: Filter to only show enabled packages.* `-s`: Filter to only show system packages.* `-3`: Filter to only show third-party packages.* `-i`: See the installer for the packages.* `-u`: Include uninstalled packages.* `--user user_id`: The user space to query. |
| `list permission-groups` | Print all known permission groups. |
| `list permissions [options] group` | Print all known permissions, optionally only those in `group`. Options:  * `-g`: Organize by group.* `-f`: Print all information.* `-s`: Short summary.* `-d`: Only list dangerous permissions.* `-u`: List only the permissions users will see. |
| `list instrumentation [options]` | List all test packages. Options:  * `-f`: List the APK file for the test package.* `target_package`: List test packages for only this app. |
| `list features` | Print all features of the system. |
| `list libraries` | Print all the libraries supported by the current device. |
| `list users` | Print all users on the system. |
| `path package` | Print the path to the APK of the given `package`. |
| `install [options] path` | Install a package, specified by `path`, to the system. Options:  * `-r`: Reinstall an existing app, keeping its data. * `-t`: Allow test APKs to be installed. Gradle generates a test APK when   you have only run or debugged your app or have used the Android Studio **Build > Build   APK** command. If the APK is built using a developer preview SDK, you must include the   [`-t` option](/studio/command-line/adb#-t-option)   with the `install` command if you are installing a test APK. * `-i installer_package_name`: Specify the installer package name. * `--user user_id`: Specify the user to install the package for. By   default, the package is installed for all users existing on the device. * `--install-location location`: Set the install location   using one of the following values:   + `0`: Use the default install location.   + `1`: Install on internal device storage.   + `2`: Install on external media. * `-f`: Install package on the internal system memory. * `-d`: Allow version code downgrade. * `-g`: Grant all permissions listed in the app manifest. * `--fastdeploy`: Quickly update an installed package by only updating the parts of   the APK that changed. * `--incremental`: Installs enough of the APK to launch the app   while streaming the remaining data in the background. To use this feature, you must sign the   APK, create an   [APK Signature Scheme v4 file](/studio/command-line/apksigner#v4-signing-enabled),   and place this file in the same directory as the APK. This feature is only supported on   certain devices. This option forces `adb` to use the feature or fail if it is not   supported, with verbose information on why it failed. Append the `--wait` option to   wait until the APK is fully installed before granting access to the APK. `--no-incremental` prevents `adb` from using this feature. |
| `uninstall [options] package` | Removes a package from the system. Options:  * `-k`: Keep the data and cache directories after package removal.* `--user user_id`: Specifies the user for whom the package is removed.     By default, the package is removed for all users on the device.* `--versionCode version_code`: Only uninstalls if the app has the given       version code. |
| `clear package` | Delete all data associated with a package. |
| `enable package_or_component` | Enable the given package or component (written as "package/class"). |
| `disable package_or_component` | Disable the given package or component (written as "package/class"). |
| `disable-user [options] package_or_component` | Options:  * `--user user_id`: The user to disable. |
| `grant package_name permission` | Grant a permission to an app. On devices running Android 6.0 (API level 23) and higher, the permission can be any permission declared in the app manifest. On devices running Android 5.1 (API level 22) and lower, must be an optional permission defined by the app. |
| `revoke package_name permission` | Revoke a permission from an app. On devices running Android 6.0 (API level 23) and higher, the permission can be any permission declared in the app manifest. On devices running Android 5.1 (API level 22) and lower, must be an optional permission defined by the app. |
| `set-install-location location` | Change the default install location. Location values:  * `0`: Auto: Let system decide the best location.* `1`: Internal: Install on internal device storage.* `2`: External: Install on external media.   **Note:** This is only intended for debugging. Using this can cause apps to break and other undesireable behavior. |
| `get-install-location` | Returns the current install location. Return values:  * `0 [auto]`: Let system decide the best location* `1 [internal]`: Install on internal device storage* `2 [external]`: Install on external media |
| `set-permission-enforced permission [true | false]` | Specify whether the given permission should be enforced. |
| `trim-caches desired_free_space` | Trim cache files to reach the given free space. |
| `create-user user_name` | Create a new user with the given `user_name`, printing the new user identifier of the user. |
| `remove-user user_id` | Remove the user with the given `user_id`, deleting all data associated with that user |
| `get-max-users` | Print the maximum number of users supported by the device. |
| `get-app-links [options] [package]` | Print the domain verification state for the given package, or for all packages if none is specified. State codes are defined as follows:  * `none`: nothing has been recorded for this domain* `verified`: the domain has been successfully verified* `approved`: force-approved, usually through shell* `denied`: force-denied, usually through shell* `migrated`: preserved verification from a legacy response* `restored`: preserved verification from a user data restore* `legacy_failure`: rejected by a legacy verifier, unknown reason* `system_configured`: automatically approved by the device config* `>= 1024`: custom error code, which is specific to the device verifier   Options are:  * `--user user_id`: include user selections. Include all domains,   not just autoVerify ones. |
| `reset-app-links [options] [package]` | Reset domain verification state for the given package, or for all packages if none is specified.  * `package`: the package to reset, or "all" to reset all packages   Options are:  * `--user user_id`: include user selections. Include all domains,   not just autoVerify ones. |
| `verify-app-links [--re-verify] [package]` | Broadcast a verification request for the given package, or for all packages if none is specified. Only sends if the package has previously not recorded a response.  * `--re-verify`: send even if the package has recorded a response |
| `set-app-links [--package package] state domains` | Manually set the state of a domain for a package. The domain must be declared by the package as autoVerify for this to work. This command will not report a failure for domains that could not be applied.  * `--package package`: the package to set, or "all" to set all packages* `state`: the code to set the domains to. Valid values are:     + `STATE_NO_RESPONSE (0)`: reset as if no response was ever recorded.+ `STATE_SUCCESS (1)`: treat domain as successfully verified by domain         verification agent. Note that the domain verification agent can         override this.+ `STATE_APPROVED (2)`: treat domain as always approved, preventing the           domain verification agent from changing it.+ `STATE_DENIED (3)`: treat domain as always denied, preventing the domain             verification agent from changing it.* `domains`: space-separated list of domains to change, or "all" to       change every domain. |
| `set-app-links-user-selection --user user_id [--package package] enabled domains` | Manually set the state of a host user selection for a package. The domain must be declared by the package for this to work. This command will not report a failure for domains that could not be applied.  * `--user user_id`: the user to change selections for* `--package package`: the package to set* `enabled`: whether to approve the domain* `domains`: space-separated list of domains to change, or "all" to         change every domain |
| `set-app-links-allowed --user user_id [--package package] allowed` | Toggle the auto-verified link-handling setting for a package.  * `--user user_id`: the user to change selections for* `--package package`: the package to set, or "all" to set all     packages; packages will be reset if no package is specified* `allowed`: true to allow the package to open auto-verified links,       false to disable |
| `get-app-link-owners --user user_id [--package package] domains` | Print the owners for a specific domain for a given user in low- to high-priority order.  * `--user user_id`: the user to query for* `--package package`: optionally also print for all web domains     declared by a package, or "all" to print all packages* `domains`: space-separated list of domains to query for |

`list packages [options] filter`
`filter`

Options:

* `-f`: See associated file.* `-d`: Filter to only show disabled packages.* `-e`: Filter to only show enabled packages.* `-s`: Filter to only show system packages.* `-3`: Filter to only show third-party packages.* `-i`: See the installer for the packages.* `-u`: Include uninstalled packages.* `--user user_id`: The user space to query.

`-f`
`-d`
`-e`
`-s`
`-3`
`-i`
`-u`
`--user user_id`
`list permission-groups`
`list permissions [options] group`
`group`

Options:

* `-g`: Organize by group.* `-f`: Print all information.* `-s`: Short summary.* `-d`: Only list dangerous permissions.* `-u`: List only the permissions users will see.

`-g`
`-f`
`-s`
`-d`
`-u`
`list instrumentation [options]`

Options:

* `-f`: List the APK file for the test package.* `target_package`: List test packages for only this app.

`-f`
`target_package`
`list features`
`list libraries`
`list users`
`path package`
`package`
`install [options] path`
`path`

Options:

* `-r`: Reinstall an existing app, keeping its data.
* `-t`: Allow test APKs to be installed. Gradle generates a test APK when
  you have only run or debugged your app or have used the Android Studio **Build > Build
  APK** command. If the APK is built using a developer preview SDK, you must include the
  [`-t` option](/studio/command-line/adb#-t-option)
  with the `install` command if you are installing a test APK.
* `-i installer_package_name`: Specify the installer package name.
* `--user user_id`: Specify the user to install the package for. By
  default, the package is installed for all users existing on the device.
* `--install-location location`: Set the install location
  using one of the following values:
  + `0`: Use the default install location.
  + `1`: Install on internal device storage.
  + `2`: Install on external media.
* `-f`: Install package on the internal system memory.
* `-d`: Allow version code downgrade.
* `-g`: Grant all permissions listed in the app manifest.
* `--fastdeploy`: Quickly update an installed package by only updating the parts of
  the APK that changed.
* `--incremental`: Installs enough of the APK to launch the app
  while streaming the remaining data in the background. To use this feature, you must sign the
  APK, create an
  [APK Signature Scheme v4 file](/studio/command-line/apksigner#v4-signing-enabled),
  and place this file in the same directory as the APK. This feature is only supported on
  certain devices. This option forces `adb` to use the feature or fail if it is not
  supported, with verbose information on why it failed. Append the `--wait` option to
  wait until the APK is fully installed before granting access to the APK.

  `--no-incremental` prevents `adb` from using this feature.

`-r`
`-t`
`-t`
`install`
`-i installer_package_name`
`--user user_id`
`--install-location location`
`0`
`1`
`2`
`-f`
`-d`
`-g`
`--fastdeploy`
`--incremental`
`adb`
`--wait`

`--no-incremental` prevents `adb` from using this feature.

`--no-incremental`
`adb`
`uninstall [options] package`

Options:

* `-k`: Keep the data and cache directories after package removal.* `--user user_id`: Specifies the user for whom the package is removed.
    By default, the package is removed for all users on the device.* `--versionCode version_code`: Only uninstalls if the app has the given
      version code.

`-k`
`--user user_id`
`--versionCode version_code`
`clear package`
`enable package_or_component`
`disable package_or_component`
`disable-user [options] package_or_component`

Options:

* `--user user_id`: The user to disable.

`--user user_id`
`grant package_name permission`
`revoke package_name permission`
`set-install-location location`
`0`
`1`
`2`

**Note:** This is only intended for debugging. Using this can cause
apps to break and other undesireable behavior.

`get-install-location`
`0 [auto]`
`1 [internal]`
`2 [external]`
`set-permission-enforced permission [true | false]`
`trim-caches desired_free_space`
`create-user user_name`
`user_name`
`remove-user user_id`
`user_id`
`get-max-users`
`get-app-links [options] [package]`

Print the domain verification state for the given package, or for all
packages if none is specified. State codes are defined as follows:

* `none`: nothing has been recorded for this domain* `verified`: the domain has been successfully verified* `approved`: force-approved, usually through shell* `denied`: force-denied, usually through shell* `migrated`: preserved verification from a legacy response* `restored`: preserved verification from a user data restore* `legacy_failure`: rejected by a legacy verifier, unknown reason* `system_configured`: automatically approved by the device config* `>= 1024`: custom error code, which is specific to the device verifier

Options are:

* `--user user_id`: include user selections. Include all domains,
  not just autoVerify ones.

`none`
`verified`
`approved`
`denied`
`migrated`
`restored`
`legacy_failure`
`system_configured`
 `>= 1024`

Options are:

* `--user user_id`: include user selections. Include all domains,
  not just autoVerify ones.

`--user user_id`
`reset-app-links [options] [package]`

Reset domain verification state for the given package, or for all
packages if none is specified.

* `package`: the package to reset, or "all" to reset all packages

Options are:

* `--user user_id`: include user selections. Include all domains,
  not just autoVerify ones.

`package`

Options are:

* `--user user_id`: include user selections. Include all domains,
  not just autoVerify ones.

`--user user_id`
`verify-app-links [--re-verify] [package]`

Broadcast a verification request for the given package, or for all
packages if none is specified. Only sends if the package has previously
not recorded a response.

* `--re-verify`: send even if the package has recorded a response

`--re-verify`
`set-app-links [--package package] state domains`

Manually set the state of a domain for a package. The domain must be
declared by the package as autoVerify for this to work. This command
will not report a failure for domains that could not be applied.

* `--package package`: the package to set, or "all" to set all packages* `state`: the code to set the domains to. Valid values are:
    + `STATE_NO_RESPONSE (0)`: reset as if no response was ever recorded.+ `STATE_SUCCESS (1)`: treat domain as successfully verified by domain
        verification agent. Note that the domain verification agent can
        override this.+ `STATE_APPROVED (2)`: treat domain as always approved, preventing the
          domain verification agent from changing it.+ `STATE_DENIED (3)`: treat domain as always denied, preventing the domain
            verification agent from changing it.* `domains`: space-separated list of domains to change, or "all" to
      change every domain.

`--package package`
`state`
`STATE_NO_RESPONSE (0)`
`STATE_SUCCESS (1)`
`STATE_APPROVED (2)`
`STATE_DENIED (3)`
`domains`
`set-app-links-user-selection --user user_id [--package package]
enabled domains`

Manually set the state of a host user selection for a package. The domain
must be declared by the package for this to work. This command will not
report a failure for domains that could not be applied.

* `--user user_id`: the user to change selections for* `--package package`: the package to set* `enabled`: whether to approve the domain* `domains`: space-separated list of domains to change, or "all" to
        change every domain

`--user user_id`
`--package package`
`enabled`
`domains`
`set-app-links-allowed --user user_id [--package package] allowed`

Toggle the auto-verified link-handling setting for a package.

* `--user user_id`: the user to change selections for* `--package package`: the package to set, or "all" to set all
    packages; packages will be reset if no package is specified* `allowed`: true to allow the package to open auto-verified links,
      false to disable

`--user user_id`
`--package package`
`allowed`
`get-app-link-owners --user user_id [--package package] domains`

Print the owners for a specific domain for a given user in low- to high-priority order.

* `--user user_id`: the user to query for* `--package package`: optionally also print for all web domains
    declared by a package, or "all" to print all packages* `domains`: space-separated list of domains to query for

`--user user_id`
`--package package`
`domains`

### Call device policy manager (`dpm`)

`dpm`

To help you develop and test your device management apps, issue
commands to the device policy manager (`dpm`) tool. Use the tool to control the active
admin app or change a policy's status data on the device.

While in a shell, the `dpm`syntax is:

```

dpm command

```

You can also issue a device policy manager command directly from `adb`
without entering a remote shell:

```

adb shell dpm command

```

**Table 3.** Available device policy manager commands

| Command | Description |
| --- | --- |
| `set-active-admin [options] component` | Sets component as active admin. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user. |
| `set-profile-owner [options] component` | Set component as active admin and its package as profile owner for an existing user. Options are:  * `--user user_id`: Specify the target user. You can   also pass `--user current` to select the current user.* `--name name`: Specify the human-readable organization name. |
| `set-device-owner [options] component` | Set component as active admin and its package as device owner. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user.* `--name name`: Specify the human-readable organization name. |
| `remove-active-admin [options] component` | Disable an active admin. The app must declare `android:testOnly` in the manifest. This command also removes device and profile owners. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user. |
| `clear-freeze-period-record` | Clear the device's record of previously set freeze periods for system OTA updates. This is useful to avoid the device scheduling restrictions when developing apps that manage freeze periods. See [Manage system updates](/work/dpc/system-updates#development_and_testing). Supported on devices running Android 9.0 (API level 28) and higher. |
| `force-network-logs` | Force the system to make any existing network logs ready for retrieval by a DPC. If there are connection or DNS logs available, the DPC receives the `onNetworkLogsAvailable()` callback. See [Network activity logging](/work/dpc/logging#development_and_testing). This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher. |
| `force-security-logs` | Force the system to make any existing security logs available to the DPC. If there are logs available, the DPC receives the `onSecurityLogsAvailable()` callback. See [Log enterprise device activity](/work/dpc/security#log_enterprise_device_activity). This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher. |

### Take a screenshot

The `screencap` command is a shell utility for taking a screenshot of a device
display.

While in a shell, the `screencap` syntax is:

```

screencap filename

```

To use `screencap` from the command line, enter the following:

```

adb shell screencap /sdcard/screen.png

```

Here's an example screenshot session, using the `adb` shell to capture the screenshot
and the `pull` command to download the file from the device:

```

$ adb shell
shell@ $ screencap /sdcard/screen.png
shell@ $ exit
$ adb pull /sdcard/screen.png

```

Alternatively, if you omit the filename, `screencap` writes the image to standard output. When combined with the `-p` option to specify PNG format, you can stream the device screenshot directly to a file on your local machine.

Here's an example of capturing a screenshot and saving it locally in a single command:

```

# use 'exec-out' instead of 'shell' to get raw data
$ adb exec-out screencap -p > screen.png

```

### Record a video

The `screenrecord` command is a shell utility for recording the display of devices
running Android 4.4 (API level 19) and higher. The utility records screen activity to an MPEG-4
file. You can use this file to create promotional or training videos or for debugging and testing.

In a shell, use the following syntax:

```

screenrecord [options] filename

```

To use `screenrecord` from the command line, enter the following:

```

adb shell screenrecord /sdcard/demo.mp4

```

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

`dpm`

While in a shell, the `dpm`syntax is:

```

dpm command

```

You can also issue a device policy manager command directly from `adb`
without entering a remote shell:

```

adb shell dpm command

```

**Table 3.** Available device policy manager commands

| Command | Description |
| --- | --- |
| `set-active-admin [options] component` | Sets component as active admin. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user. |
| `set-profile-owner [options] component` | Set component as active admin and its package as profile owner for an existing user. Options are:  * `--user user_id`: Specify the target user. You can   also pass `--user current` to select the current user.* `--name name`: Specify the human-readable organization name. |
| `set-device-owner [options] component` | Set component as active admin and its package as device owner. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user.* `--name name`: Specify the human-readable organization name. |
| `remove-active-admin [options] component` | Disable an active admin. The app must declare `android:testOnly` in the manifest. This command also removes device and profile owners. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user. |
| `clear-freeze-period-record` | Clear the device's record of previously set freeze periods for system OTA updates. This is useful to avoid the device scheduling restrictions when developing apps that manage freeze periods. See [Manage system updates](/work/dpc/system-updates#development_and_testing). Supported on devices running Android 9.0 (API level 28) and higher. |
| `force-network-logs` | Force the system to make any existing network logs ready for retrieval by a DPC. If there are connection or DNS logs available, the DPC receives the `onNetworkLogsAvailable()` callback. See [Network activity logging](/work/dpc/logging#development_and_testing). This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher. |
| `force-security-logs` | Force the system to make any existing security logs available to the DPC. If there are logs available, the DPC receives the `onSecurityLogsAvailable()` callback. See [Log enterprise device activity](/work/dpc/security#log_enterprise_device_activity). This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher. |

### Take a screenshot

The `screencap` command is a shell utility for taking a screenshot of a device
display.

While in a shell, the `screencap` syntax is:

```

screencap filename

```

To use `screencap` from the command line, enter the following:

```

adb shell screencap /sdcard/screen.png

```

Here's an example screenshot session, using the `adb` shell to capture the screenshot
and the `pull` command to download the file from the device:

```

$ adb shell
shell@ $ screencap /sdcard/screen.png
shell@ $ exit
$ adb pull /sdcard/screen.png

```

Alternatively, if you omit the filename, `screencap` writes the image to standard output. When combined with the `-p` option to specify PNG format, you can stream the device screenshot directly to a file on your local machine.

Here's an example of capturing a screenshot and saving it locally in a single command:

```

# use 'exec-out' instead of 'shell' to get raw data
$ adb exec-out screencap -p > screen.png

```

### Record a video

The `screenrecord` command is a shell utility for recording the display of devices
running Android 4.4 (API level 19) and higher. The utility records screen activity to an MPEG-4
file. You can use this file to create promotional or training videos or for debugging and testing.

In a shell, use the following syntax:

```

screenrecord [options] filename

```

To use `screenrecord` from the command line, enter the following:

```

adb shell screenrecord /sdcard/demo.mp4

```

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

While in a shell, the `dpm`syntax is:

`dpm`

You can also issue a device policy manager command directly from `adb`
without entering a remote shell:

`adb`

**Table 3.** Available device policy manager commands

| Command | Description |
| --- | --- |
| `set-active-admin [options] component` | Sets component as active admin. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user. |
| `set-profile-owner [options] component` | Set component as active admin and its package as profile owner for an existing user. Options are:  * `--user user_id`: Specify the target user. You can   also pass `--user current` to select the current user.* `--name name`: Specify the human-readable organization name. |
| `set-device-owner [options] component` | Set component as active admin and its package as device owner. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user.* `--name name`: Specify the human-readable organization name. |
| `remove-active-admin [options] component` | Disable an active admin. The app must declare `android:testOnly` in the manifest. This command also removes device and profile owners. Options are:  * `--user user_id`: Specify the target user. You can also pass   `--user current` to select the current user. |
| `clear-freeze-period-record` | Clear the device's record of previously set freeze periods for system OTA updates. This is useful to avoid the device scheduling restrictions when developing apps that manage freeze periods. See [Manage system updates](/work/dpc/system-updates#development_and_testing). Supported on devices running Android 9.0 (API level 28) and higher. |
| `force-network-logs` | Force the system to make any existing network logs ready for retrieval by a DPC. If there are connection or DNS logs available, the DPC receives the `onNetworkLogsAvailable()` callback. See [Network activity logging](/work/dpc/logging#development_and_testing). This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher. |
| `force-security-logs` | Force the system to make any existing security logs available to the DPC. If there are logs available, the DPC receives the `onSecurityLogsAvailable()` callback. See [Log enterprise device activity](/work/dpc/security#log_enterprise_device_activity). This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher. |

`set-active-admin [options] component`

Options are:

* `--user user_id`: Specify the target user. You can also pass
  `--user current` to select the current user.

`--user user_id`
`--user current`
`set-profile-owner [options] component`

Options are:

* `--user user_id`: Specify the target user. You can
  also pass `--user current` to select the current user.* `--name name`: Specify the human-readable organization name.

`--user user_id`
`--user current`
`--name name`
`set-device-owner [options] component`

Options are:

* `--user user_id`: Specify the target user. You can also pass
  `--user current` to select the current user.* `--name name`: Specify the human-readable organization name.

`--user user_id`
`--user current`
`--name name`
`remove-active-admin [options] component`
`android:testOnly`

Options are:

* `--user user_id`: Specify the target user. You can also pass
  `--user current` to select the current user.

`--user user_id`
`--user current`
`clear-freeze-period-record`

Supported on devices running Android 9.0 (API level 28) and higher.

`force-network-logs`
`onNetworkLogsAvailable()`

This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher.

`force-security-logs`
`onSecurityLogsAvailable()`

This command is rate-limited. Supported on devices running Android 9.0 (API level 28) and higher.

### Take a screenshot

The `screencap` command is a shell utility for taking a screenshot of a device
display.

`screencap`

While in a shell, the `screencap` syntax is:

`screencap`

To use `screencap` from the command line, enter the following:

```

adb shell screencap /sdcard/screen.png

```

Here's an example screenshot session, using the `adb` shell to capture the screenshot
and the `pull` command to download the file from the device:

```

$ adb shell
shell@ $ screencap /sdcard/screen.png
shell@ $ exit
$ adb pull /sdcard/screen.png

```

Alternatively, if you omit the filename, `screencap` writes the image to standard output. When combined with the `-p` option to specify PNG format, you can stream the device screenshot directly to a file on your local machine.

Here's an example of capturing a screenshot and saving it locally in a single command:

```

# use 'exec-out' instead of 'shell' to get raw data
$ adb exec-out screencap -p > screen.png

```

### Record a video

The `screenrecord` command is a shell utility for recording the display of devices
running Android 4.4 (API level 19) and higher. The utility records screen activity to an MPEG-4
file. You can use this file to create promotional or training videos or for debugging and testing.

In a shell, use the following syntax:

```

screenrecord [options] filename

```

To use `screenrecord` from the command line, enter the following:

```

adb shell screenrecord /sdcard/demo.mp4

```

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

`screencap`

Here's an example screenshot session, using the `adb` shell to capture the screenshot
and the `pull` command to download the file from the device:

```

$ adb shell
shell@ $ screencap /sdcard/screen.png
shell@ $ exit
$ adb pull /sdcard/screen.png

```

Alternatively, if you omit the filename, `screencap` writes the image to standard output. When combined with the `-p` option to specify PNG format, you can stream the device screenshot directly to a file on your local machine.

Here's an example of capturing a screenshot and saving it locally in a single command:

```

# use 'exec-out' instead of 'shell' to get raw data
$ adb exec-out screencap -p > screen.png

```

### Record a video

The `screenrecord` command is a shell utility for recording the display of devices
running Android 4.4 (API level 19) and higher. The utility records screen activity to an MPEG-4
file. You can use this file to create promotional or training videos or for debugging and testing.

In a shell, use the following syntax:

```

screenrecord [options] filename

```

To use `screenrecord` from the command line, enter the following:

```

adb shell screenrecord /sdcard/demo.mp4

```

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

`adb`
`pull`

```

$ adb shell
shell@ $ screencap /sdcard/screen.png
shell@ $ exit
$ adb pull /sdcard/screen.png

```

Alternatively, if you omit the filename, `screencap` writes the image to standard output. When combined with the `-p` option to specify PNG format, you can stream the device screenshot directly to a file on your local machine.

Here's an example of capturing a screenshot and saving it locally in a single command:

```

# use 'exec-out' instead of 'shell' to get raw data
$ adb exec-out screencap -p > screen.png

```

### Record a video

The `screenrecord` command is a shell utility for recording the display of devices
running Android 4.4 (API level 19) and higher. The utility records screen activity to an MPEG-4
file. You can use this file to create promotional or training videos or for debugging and testing.

In a shell, use the following syntax:

```

screenrecord [options] filename

```

To use `screenrecord` from the command line, enter the following:

```

adb shell screenrecord /sdcard/demo.mp4

```

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

Alternatively, if you omit the filename, `screencap` writes the image to standard output. When combined with the `-p` option to specify PNG format, you can stream the device screenshot directly to a file on your local machine.

`screencap`
`-p`

Here's an example of capturing a screenshot and saving it locally in a single command:

### Record a video

The `screenrecord` command is a shell utility for recording the display of devices
running Android 4.4 (API level 19) and higher. The utility records screen activity to an MPEG-4
file. You can use this file to create promotional or training videos or for debugging and testing.

`screenrecord`

In a shell, use the following syntax:

To use `screenrecord` from the command line, enter the following:

```

adb shell screenrecord /sdcard/demo.mp4

```

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

`screenrecord`

Stop the screen recording by pressing Control+C. Otherwise, the recording
stops automatically at three minutes or the time limit set by `--time-limit`.

`--time-limit`

To begin recording your device screen, run the `screenrecord` command to record
the video. Then, run the `pull` command to download the video from the device to the host
computer. Here's an example recording session:

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

`screenrecord`
`pull`

```

$ adb shell
shell@ $ screenrecord --verbose /sdcard/demo.mp4
(press Control + C to stop)
shell@ $ exit
$ adb pull /sdcard/demo.mp4

```

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

Limitations of the `screenrecord` utility:

* Audio is not recorded with the video file.
* Video recording is not available for devices running Wear OS.
* Some devices might not be able to record at their native display resolution.
  If you encounter problems with screen recording, try using a lower screen resolution.
* Rotation of the screen during recording is not supported. If the screen does rotate during
  recording, some of the screen is cut off in the recording.

**Table 4.** `screenrecord` options

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

```

adb shell cmd package dump-profiles package

```

To retrieve the file produced, use:

```

adb pull /data/misc/profman/package.prof.txt

```

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

```

adb shell cmd testharness enable

```

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

* The device sets up certain system settings so that initial device setup wizards do not appear.
  That is, the device enters a state from which you can quickly install, debug, and test your app.* Settings:
    + Disables lock screen.+ Disables emergency alerts.+ Disables auto-sync for accounts.+ Disables automatic system updates.* Other:
      + Disables preinstalled security apps.

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

```

$ adb -s emulator-5554 shell
$ sqlite3 /data/data/com.example.app/databases/rssitems.db
SQLite version 3.3.12
Enter ".help" for instructions

```

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

**Experimental:** Support for using the `libusb` backend with Windows is experimental. As of
ADB v34, only the macOS and Linux platforms have been tested with the `libusb` library.

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

The `screenrecord` utility can record at any supported resolution and bit rate you
request, while retaining the aspect ratio of the device display. The utility records at the native
display resolution and orientation by default, with a maximum length of three minutes.

`screenrecord`

Limitations of the `screenrecord` utility:

`screenrecord`

**Table 4.** `screenrecord` options

`screenrecord`

| Options | Description |
| --- | --- |
| `--help` | Display command syntax and options |
| `--size widthxheight` | Set the video size: `1280x720`. The default value is the device's native display resolution (if supported), 1280x720 if not. For best results, use a size supported by your device's Advanced Video Coding (AVC) encoder. |
| `--bit-rate rate` | Set the video bit rate for the video, in megabits per second. The default value is 20Mbps. You can increase the bit rate to improve video quality, but doing so results in larger movie files. The following example sets the recording bit rate to 6Mbps:    ``` screenrecord --bit-rate 6000000 /sdcard/demo.mp4 ``` |
| `--time-limit time` | Set the maximum recording time, in seconds. The default and maximum value is 180 (3 minutes). |
| `--rotate` | Rotate the output 90 degrees. This feature is experimental. |
| `--verbose` | Display log information on the command-line screen. If you do not set this option, the utility does not display any information while running. |

`--help`
`--size widthxheight`
`1280x720`
`--bit-rate rate`
`--time-limit time`
`--rotate`
`--verbose`

### Read ART profiles for apps

Starting in Android 7.0 (API level 24), the Android Runtime (ART) collects execution profiles for
installed apps, which are used to optimize app performance. Examine the collected profiles to
understand which methods are executed frequently and which classes are used during app startup.

**Note:** It is only possible to retrieve the execution profile
filename if you have root access to the file system, for example, on an emulator.

To produce a text form of the profile information, use the following command:

To retrieve the file produced, use:

### Reset test devices

If you test your app across multiple test devices, it may be useful to reset your device between
tests, for example, to remove user data and reset the test environment. You can perform a factory
reset of a test device running Android 10 (API level 29) or higher using the
`testharness` `adb` shell command, as shown:

`testharness`
`adb`

When restoring the device using `testharness`, the device automatically backs up the RSA
key that allows debugging through the current workstation in a persistent location. That is, after
the device is reset, the workstation can continue to debug and issue `adb` commands to
the device without manually registering a new key.

`testharness`
`adb`

Additionally, to help make it easier and more secure to keep testing your app, using the
`testharness` to restore a device also changes the following device settings:

`testharness`

If your app needs to detect and adapt to the default settings of the `testharness`
command, use the
[`ActivityManager.isRunningInUserTestHarness()`](/reference/android/app/ActivityManager#isRunningInUserTestHarness()).

`testharness`
`ActivityManager.isRunningInUserTestHarness()`

### sqlite

`sqlite3` starts the `sqlite` command-line program for examining SQLite databases.
It includes commands such as `.dump` to print the contents of a table and
`.schema` to print the `SQL CREATE` statement for an existing table.
You can also execute SQLite commands from the command line, as shown:

`sqlite3`
`sqlite`
`.dump`
`.schema`
`SQL CREATE`

**Note:** It is only possible to access a SQLite database
if you have root access to the file system, for example, on an emulator.

For more information, see the [`sqlite3` command line documentation](http://www.sqlite.org/cli.html).

`sqlite3`

## adb USB backends

The adb server can interact with the USB stack through two backends. It can either use the native
backend of the OS (Windows, Linux, or macOS) or it can use the `libusb` backend.
Some features, such as `attach`, `detach`, and USB speed detection, are
only available when using `libusb` backend.

`libusb`
`attach`
`detach`
`libusb`

You can choose a backend by using the `ADB_LIBUSB` environment variable.
If it isn't set, adb uses its default backend. The default behavior varies among OS. Starting
with [ADB v34](https://developer.android.com/tools/releases/platform-tools#revisions), the
`liubusb` backend is used by default on all OS except Windows, where the native backend is
used by default. If `ADB_LIBUSB` is
set, it determines whether the native backend or `libusb` is used. See the
[adb manual page](https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md)
for more information about adb environment variables.

`ADB_LIBUSB`
`liubusb`
`ADB_LIBUSB`
`libusb`
`libusb`
`libusb`

## adb mDNS backends

ADB uses the mDNS (multicast DNS) protocol to automatically connect the server and devices for wireless
debugging. As of ADB v37, The ADB server ships with two mDNS backends, `libadbmdns` and
`openscreen`.

`libadbmdns`
`openscreen`

The default and recommended backend is `libadbmdns`. This behavior can be changed
using the environment variable `ADB_MDNS_OPENSCREEN` (set to `1` or `0`).
Support for the Openscreen backend on macOS starts at ADB v35. Windows and Linux are supported as of ADB v34.

`libadbmdns`
`ADB_MDNS_OPENSCREEN`
`1`
`0`

## adb Burst Mode (starting with ADB 36.0.0)

Burst Mode is an experimental feature that lets ADB to keep on sending
packets to a device even before the device has responded to the previous packet. This greatly
increases the throughput of ADB when transferring large files and also reduces latency while
debugging.

Burst Mode is disabled by default. To enable the feature, do one of the following:

* Set the environment variable `ADB_BURST_MODE` to `1`.
* In Android Studio, go to the debugger settings at **File** (or **Android Studio** on macOS) **> Settings > Build, Execution, Deployment > Debugger**
  and set **ADB Server Burst Mode** to **Enabled**.

`ADB_BURST_MODE`
`1`

Content and code samples on this page are subject to the licenses described in the [Content License](/license). Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates.

Last updated 2026-06-18 UTC.

![X](/_static/android/images/logo-x.svg)
![YouTube](//www.gstatic.com/images/icons/material/product/2x/youtube_48dp.png)
![LinkedIn](/_static/android/images/logo-linkedin.svg)

### More Android

### Discover

### Android Devices

### Releases

### Documentation and Downloads

### Support

![Google Developers](https://www.gstatic.com/devrel-devsite/prod/v86d4242899d0b9c3c3542409bdd63e021381cf8309eb1da531e08bd4193a5020/android/images/lockup-google-for-developers.svg)
