* [Join/Login](https://sourceforge.net/auth/)
* [Business Software](/software/)
* [Open Source Software](/directory/)
* [For Vendors](/software/vendors/ "For Vendors")
* [Blog](/blog/ "Blog")
* [About](/about)
* More
* + [Articles](/articles/)
  + [Create](/create)
  + [SourceForge Podcast](https://sourceforge.net/articles/category/sourceforge-podcast/)
  + [Site Documentation](https://sourceforge.net/p/forge/documentation/Docs%20Home/)
  + [Subscribe to our Newsletter](/user/newsletters)
  + [Support Request](/support)

# Win32 Disk Imager

## A Windows tool for writing images to USB sticks or SD/CF cards

Brought to you by: [gruemaster](/u/gruemaster/profile/), [tuxinator2009](/u/tuxinator2009/profile/)

[123 Reviews](/projects/win32diskimager/reviews/ "Win32 Disk Imager Reviews")

**Downloads:**  [14,388 This Week](/projects/win32diskimager/files/stats/timeline "Downloads This Week")

**Last Update:**

[Share This](#)

#### Get an email when there's a new version of Win32 Disk Imager

Windows

* [Summary](/projects/win32diskimager/)
* [Files](/projects/win32diskimager/files/)
* [Reviews](/projects/win32diskimager/reviews/)
* [Support](/projects/win32diskimager/support)
* [Wiki](/p/win32diskimager/wiki/)
* [Feature Requests](/p/win32diskimager/features/)
* [Bugs](/p/win32diskimager/tickets/)
* [Code](/p/win32diskimager/code/)
* [Mailing Lists](/p/win32diskimager/mailman/)
* [Blog](/p/win32diskimager/blog/)

This program is designed to write a raw disk image to a removable device or backup a removable device to a raw image file. It is very useful for embedded development, namely Arm development projects (Android, Ubuntu on Arm, etc). Anyone is free to branch and modify this program. Patches are always welcome.  
   
 This release is for Windows 7/8.1/10. It will should also work on Windows Server 2008/2012/2016 (although not tested by the developmers). For Windows XP/Vista, please use v0.9 (in the files archive).  
   
 Warning: Issues have been reported when using to write to USB Floppy drives (and occasionally other USB devices, although very rare). While this has been fixed in v1.0, it is highly recommended that before an image is written to a device, the user should do a Read to a temporary file first. If this fails, please report the failure along with your system information.  
   
 Known issues:  
 Currently, the program will crash if you are using a Ramdisk. This is being debugged.

### Features

* Raw reading and writing to removable media

### Project Samples

### Project Activity

[See All Activity >](/p/win32diskimager/activity/)

### Categories

[Storage](/directory/storage/), [File Systems](/directory/file-systems/), [Embedded Systems](/directory/embedded-systems/)

### License

GNU General Public License version 2.0 (GPLv2)

### Follow Win32 Disk Imager

[Win32 Disk Imager Web Site](https://win32diskimager.sourceforge.io/ "Win32 Disk Imager Web Site")

Other Useful Business Software

Ship Agents Faster

Transform your applications and workflows into powerful agentic systems at global scale.

Gemini Enterprise Agent Platform lets you rapidly build, scale, govern and optimize production-ready agents grounded in your organization's data. The platform enables developers to build custom or pre-built agents for virtually any use case. New customers get $300 in free credits.

Get Started Free

Rate This Project

[Login To Rate This Project](/projects/win32diskimager/reviews/new)

### User Ratings

3.8 out of 5 stars

★★★★★

★★★★

★★★

★★

★

67

17

9

4

26

ease 1 of 5 2 of 5 3 of 5 4 of 5 5 of 5  3 / 5

features 1 of 5 2 of 5 3 of 5 4 of 5 5 of 5  3 / 5

design 1 of 5 2 of 5 3 of 5 4 of 5 5 of 5  3 / 5

support 1 of 5 2 of 5 3 of 5 4 of 5 5 of 5  3 / 5

## User Reviews

Filter Reviews:

All

* [All](# "Show All")
* [★★★★★](# "Show 5 Stars")
* [★★★★](# "Show 4 Stars")
* [★★★](# "Show 3 Stars")
* [★★](# "Show 2 Stars")
* [★](# "Show 1 Star")

* dpwhite  Posted 2026-03-03

  I have used this a couple times to read and verify exFat microSd cards in a USB adapter. Seems to work decently enough. I have not used this to write the image back to a microsSd card but I have done this with Rufus and then used this again to verify the result - which has been successful. I do wish: 1. There was a command line interface. 2. There was a checkbox to perform verify immediately after a read is performed. 3. There was built-in support for compressing the created image file. I have done this myself using 7-zip and found that a 512GB image file could be reduced substantially to 155GB. And this is significant! Either way, this is definitely added to my tool belt. Thanks!
* ardacosan  Posted 2025-01-13

  if this tool makes your drive's allocated space small, don't be scared. you need to use Disk utility on windows for fully format it. when you opened disk utility (win + x and select disk utility) you see your drive has been allocated in there. right click the black space and select "new basic partition" or something click next until you see "attend drive letter" or another thing. (i don't using my pc english) select a drive letter, name it and your drive is ready. you're welcome
* pxabstraction  Posted 2024-03-28

  Excellent, simple tool that does what it does well and doesn't hold your hand. The vast majority of the negative reviews are from people who either didn't read the instructions or are not technically competent enough to be using a tool like this. This is not a tool designed for newbies. Look on Google or YouTube for instructions on how to use the tool before you go blaming the developers for your lack of knowledge.
* hydra009  Posted 2024-02-03

  First, I would like to note that this software does require some knowledge on the part of the user. Most of the poor reviews are only due to the user's ignorance and failure to understand what they are doing. This software is designed to write an image to a drive. A drive being a hard drive, SSD, USB flash drive, SD card, microSD card, etc. It will overwrite the entire destination drive. You cannot write an image to a partition, only the whole drive. All partitions on the destination are erased and over written. The image was made from a drive and is the same size as the original. When it is written the destination drive becomes the same size as the image. This can be fixed through scripts that auto expand the image to the full size of the destination drive or the expansion can be done manually through a partition manager. Many partition mangers have free versions capable of this. A partition manager can also be used to restore your drive to its original blank state. Since your destination drive has actually been overwritten, even data recovery software will not restore your destination drive data if you mistakenly wrote to the wrong drive. BE 100% SURE OF YOUR DESTINATION DRIVE! Then check again. Google this whole process. Watch a YouTube video. Watch many times if necessary. As a final note, there do exist some images that do not work well with this program and some drives that have problems. In some cases, downloaded images are not what they are described as. There are several other programs of this type. Google is your friend ;-)
* don-w-p  Edited 2023-10-25

  I have used this to write Raspbian OS images to microSD cards, most recently the image 2023-10-10-raspios-bookworm-arm64-full.img, This is the 64 bit Raspbian Bookworm OS with the recommended software and is 13.4 GB in size. I have never had a problem, always successful writes. The free program SD Formatter can always be used to restore the original format. I have used it both on Windows 10 and Windows 11 computers. "Expand file system" should be done on the Raspberry Pi computer to recover the original microSD card storage capacity.

[Read more reviews >](/projects/win32diskimager/reviews/#reviews)

### Additional Project Details

#### Awards

* [Mar 2014](http://sourceforge.net/blog/march-2014-sp-potm/ "Project of the Month: March 2014")

#### Operating Systems

[Windows](/directory/windows/)

#### Intended Audience

Advanced End Users

#### User Interface

Qt

#### Programming Language

[C++](/directory/c-plus-plus/)

#### Related Categories

[C++ Storage Software](/directory/storage/c++/), [C++ File Systems](/directory/file-systems/c++/), [C++ Embedded Systems Software](/directory/embedded-systems/c++/)

#### Registered

2012-10-12

[Report inappropriate content](/projects/win32diskimager/report_inappropriate)

 
