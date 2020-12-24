```
SA: 007
Title: How to Connect iPhone to KOOMPI OS
Author: Saing Sab
Status: Active
Create: 2020-12-24
Update: NA
version: 0.1.0
```
### How to Connect iPhone to KOOMPI OS

### Indro: 
iDevice like iPone, iPad connection will need to install the software and mount with command line , but I presume since you are in KOOMPI or Linux OS, you are not scared of terminal (and you should not be as well).

### Solution:
Step 1: Unplug your iPhone, if it is already plugged in.

Step 2: Now, open a terminal and use the following command to install some necessary packages. Donâ€™t worry if they are already installed.

sudo pacman -Sy ifuse usbmuxd libplist libimobiledevice

Step 3: Once these programs and libraries are installed, reboot your system.

sudo reboot

Step 4: Make a directory where you want the iPhone to be mounted. I would suggest making a directory named iPhone in your home directory.

mkdir ~/iPhone

Step 5: Unlock your phone and plug it in. If asked to trust the computer, allow it.

Step 6: Verify that iPhone is recognized by the system this time.
dmesg | grep -i iphone

This should show you some result with iPhone and Apple in it. Something like this:

[ 31.003392] ipheth 2-1:4.2: Apple iPhone USB Ethernet device attached
[ 40.950883] ipheth 2-1:4.2: Apple iPhone USB Ethernet now disconnected
[ 47.471897] ipheth 2-1:4.2: Apple iPhone USB Ethernet device attached
[ 82.967116] ipheth 2-1:4.2: Apple iPhone USB Ethernet now disconnected
[ 106.735932] ipheth 2-1:4.2: Apple iPhone USB Ethernet device attached

This means that iPhone has been successfully recognized by Antergos/Arch Linux.

Step 7: When everything is set, itâ€™s time to mount the iPhone. Use the command below:
idevicepair pair
ifuse ~/iPhone

Since we created the mount directory in home, it wonâ€™t need root access and you should also be able to see it easily in your home directory. If the command is successful, you wonâ€™t see any output.

Go back to Files and see if the iPhone is recognized or not. For me, it looks like this in Antergos:
You can access the files in this directory. Copy files from it or to it.

Step 8: When you want to unmount it, you should use this command:

sudo umount ~/iPhone

Worked for you?

I know that it is not very convenient and ideally, iPhone should be recognized as any other USB storage device but things donâ€™t always behave as they are expected to. Good thing is that a little DIY hack can always fix the issue and it gives a sense of achievement (at least to me). That being said, I must say Antergos should work to fix this issue so that iPhone can be mounted by default.