![Android Developers](https://www.gstatic.com/devrel-devsite/prod/v86d4242899d0b9c3c3542409bdd63e021381cf8309eb1da531e08bd4193a5020/android/images/lockup.png)
![Android Developers](https://www.gstatic.com/devrel-devsite/prod/v86d4242899d0b9c3c3542409bdd63e021381cf8309eb1da531e08bd4193a5020/android/images/lockup.png)

# SDK Platform Tools release notes Stay organized with collections Save and categorize content based on your preferences.

Android SDK Platform-Tools is a component for the Android SDK.
It includes tools that interface with the Android platform, primarily
[`adb`](/tools/adb) and
[`fastboot`](https://android.googlesource.com/platform/system/core/+/master/fastboot/#fastboot).
Although `adb` is required for Android app development, app developers will
normally just use the copy Studio installs. This download is useful if you want
to use `adb` directly from the command-line and don't have Studio installed.
(If you do have Studio installed, you might want to just use the copy it
installed because Studio will automatically update it.) `fastboot` is needed
if you want to unlock your device bootloader and flash it with a new system
image. This package used to contain `systrace`, but that has been obsoleted in
favor of Studio Profiler, gpuinspector.dev, or Perfetto.

`adb`
`fastboot`
`adb`
`adb`
`fastboot`
`systrace`

Although some new features in `adb` and `fastboot` are available only for recent
versions of Android, they're backward compatible, so you should only need the
latest version of the SDK Platform-Tools and should file bugs if you find
exceptions.

`adb`
`fastboot`

## Downloads

If you're an Android developer, you should get the latest
SDK Platform-Tools from Android Studio's [SDK Manager](/studio/intro/update#sdk-manager) or from the
[`sdkmanager`](/studio/command-line/sdkmanager)
command-line tool. This ensures the tools are saved to the right place with
the rest of your Android SDK tools and easily updated.

`sdkmanager`

But if you want just these command-line tools, use the following links:

Although these links do not change, they always point to the most recent version
of the tools.

## Revisions

#### 37.0.1

**Canary: July 2026**

##### adb

`openscreen`
`ADB_MDNS_OPENSCREEN`
`libadbmdns`
`ADB_TRACE`
`usb:v, services:w`

**Linux:**

`kill-server`

**Windows:**

`wlanapi.dll`
`wlanapi.dll`
`libadbusb`
`libusb`
`libadbusb`
`ADB_USB_LEGACY`
`1`

**MacOS:**

`libusb`
`libusb`
`ADB_LIBUSB`
`1`

#### 37.0.0 (Feb 2026)

`libadbmdns`
`openscreen`

#### 36.0.2 (Sep 2025)

`Miscellaneous`

#### 36.0.1

Never released past Canary due to [issue #439152273](https://issuetracker.google.com/439152273).

#### 36.0.0 (Apr 2025)

`server-status`

#### 35.0.2 (July 2024)

#### 35.0.1 (March 2024)

#### 35.0.0 (February 2024)

`adb shell`

#### 34.0.5 (October 2023)

`error: protocol fault (couldn't read status message...)`
`echo $?`
`1`
`adb wait-for-disconnect`

#### 34.0.4 (July 2023)

`-a (gListenAll)`
`adb -a server nodaemon`
`Flag(env) guarding clear endpoint (device)
feature for OSX usb start.`

#### 34.0.1 (March 2023)

#### 34.0.0 RC2 (March 2023)

#### 34.0.0 (February 2023)

`flashall`

#### 33.0.3 (Aug 2022)

`adb root`

#### 33.0.2 (May 2022)

`vendor_kernel_boot`

#### 33.0.1 (March 2022)

#### 33.0.0 (February 2022)

#### 32.0.0 (January 2022)

#### 31.0.3 (August 2021)

#### 31.0.2 (April 2021)

`adb track-devices`
`ADB_MDNS_OPENSCREEN`

#### 31.0.1 (March 2021)

#### 31.0.0 (February 2021)

#### 30.0.5 (November 2020)

`adb push`
`adb push/pull`
`adb push --sync`

#### 30.0.4 (July 2020)

`adb install-multi-package`
`fastboot oem`
`fastboot flashall`

#### 30.0.3 (June 2020)

`ADB_VENDOR_KEYS`
`adb -H`

#### 30.0.2 (June 2020)

`adb logcat`
`adb transport-id`

#### 30.0.1 (May 2020)

`ADB_MDNS_AUTO_CONNECT`
`adb install-multi`
`adb root/unroot`

#### 30.0.0 (April 2020)

`adb {push, pull, sync}`
`adb push`

#### 29.0.6 (February 2020)

`adb ls`
`::1`
`adb install`

#### 29.0.5 (October 2019)

`--fastdeploy`
`adb install`

#### 29.0.4 (September 2019)

`AdbCommandRejectedException`
`idea.log`

#### 29.0.3 (September 2019)

`adb forward --list`
`adb install`
`adb connect <host>`

#### 29.0.2 (July 2019)

#### 29.0.1 (June 2019)

#### 29.0.0 (June 2019)

`adb reconnect`
`adb root`
`adb root; adb wait-for-device`
`adb wait-for-device`

#### 28.0.2 (March 2019)

`adb shell`
`ADB_VENDOR_KEYS`

#### 28.0.1 (September 2018)

`adb connect`
`adb forward --list`

#### 28.0.0 (June 2018)

`adb devices`
`adb connect`
`-v`
`product.img`
`odm.img`
`fastboot flashall`

#### 27.0.1 (December 2017)

#### 27.0.0 (December 2017)

#### 26.0.2 (October 2017)

#### 26.0.1 (September 2017)

#### 26.0.0 (June 2017)

#### 25.0.5 (April 24, 2017)

Fixed adb sideload of large updates on Windows, manifesting as
"std::bad\_alloc" ([bug
37139736](https://issuetracker.google.com/37139736)).

Fixed adb problems with some Windows firewalls, manifesting as "cannot open
transport registration socketpair"
([bug 37139725](https://issuetracker.google.com/37139725)).

Both `adb --version` and `fastboot --version` now include the install path.

`adb --version`
`fastboot --version`

Changed adb to not resolve `localhost` to work around misconfigured VPN.

`localhost`

Changed adb to no longer reset USB devices on Linux, which could affect
other attached USB devices.

#### 25.0.4 (March 16, 2017)

To use the libusb backend, set the environment variable ADB\_LIBUSB=true before
launching a new adb server. The new `adb host-features` command will tell you
whether or not you're using libusb.

`adb host-features`

To restart adb with libusb and check that it worked, use `adb kill-server;
ADB_LIBUSB=1 adb start-server; adb host-features`. The output should include
"libusb".

`adb kill-server;
ADB_LIBUSB=1 adb start-server; adb host-features`

In this release, the old non-libusb implementation remains the default.

fastboot doesn't hang 2016 MacBook Pros anymore
([bug
231129](https://code.google.com/p/android/issues/detail?id=231129))

Fixed Systrace command line capture on Mac

#### 25.0.3 (December 16, 2016)

#### 25.0.2 (December 12, 2016)

#### 25.0.1 (November 22, 2016)

#### 25.0.0 (October 19, 2016)

#### 24.0.4 (October 14, 2016)

## Download Android SDK Platform-Tools

Before downloading, you must agree to the following terms and conditions.

## Terms and Conditions

### 1. Introduction

### 2. Accepting this License Agreement

### 3. SDK License from Google

### 4. Use of the SDK by You

### 5. Your Developer Credentials

### 6. Privacy and Information

### 7. Third Party Applications

### 8. Using Android APIs

### 9. Terminating this License Agreement

### 10. DISCLAIMER OF WARRANTIES

### 11. LIMITATION OF LIABILITY

### 12. Indemnification

### 13. Changes to the License Agreement

### 14. General Legal Terms

*platform-tools-latest-windows.zip*

## Download Android SDK Platform-Tools

Before downloading, you must agree to the following terms and conditions.

## Terms and Conditions

### 1. Introduction

### 2. Accepting this License Agreement

### 3. SDK License from Google

### 4. Use of the SDK by You

### 5. Your Developer Credentials

### 6. Privacy and Information

### 7. Third Party Applications

### 8. Using Android APIs

### 9. Terminating this License Agreement

### 10. DISCLAIMER OF WARRANTIES

### 11. LIMITATION OF LIABILITY

### 12. Indemnification

### 13. Changes to the License Agreement

### 14. General Legal Terms

*platform-tools-latest-darwin.zip*

## Download Android SDK Platform-Tools

Before downloading, you must agree to the following terms and conditions.

## Terms and Conditions

### 1. Introduction

### 2. Accepting this License Agreement

### 3. SDK License from Google

### 4. Use of the SDK by You

### 5. Your Developer Credentials

### 6. Privacy and Information

### 7. Third Party Applications

### 8. Using Android APIs

### 9. Terminating this License Agreement

### 10. DISCLAIMER OF WARRANTIES

### 11. LIMITATION OF LIABILITY

### 12. Indemnification

### 13. Changes to the License Agreement

### 14. General Legal Terms

*platform-tools-latest-linux.zip*

Content and code samples on this page are subject to the licenses described in the [Content License](/license). Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates.

Last updated 2026-07-14 UTC.

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
