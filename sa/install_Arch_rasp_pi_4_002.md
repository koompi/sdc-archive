```
SA: 002
Title: Installation Archlinux on Raspberry pi 4
Author: Heng Hongsea
Status: Active
Create: 2020-06-10
Update: NA
Version: 0.0.1
```

# Installation Archlinux on Raspberry pi 4

## Installation

Go to this link for Installation Archlinux arm : 

* https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4

## lxqt on archlinux arm

* **Network**

    Use netctl service for connect to internet.

    ```
    $  su       #and type password root user
    $ wifi-menu     #you will see wifi list and select wifi that you want connect and type password
    $ cd /etc/netctl        #go to netctl directory
    $ netctl start <wifi_profile>       #use will see wifi profile when you connecting to wifi
    $ ping fb.com       #test ping
    ```

* **Timezones**

    To change the hardware clock time standard to localtime, use: 

    ```
    $    timedatectl set-local-rtc 1
    ```

    To check the current zone defined for the system: 
    
    ```
    $ timedatectl status
    ```

    To list available zones: 

    ```
    $ timedatectl list-timezones
    ```

    To set your time zone: 

    ```
    $ timedatectl set-timezone Zone/SubZone
    ```

    Example: 

    ```
    $ timedatectl set-timezone Asia/Phnom_Penh
    ```

    This will create an /etc/localtime symlink that points to a zoneinfo file under /usr/share/zoneinfo/

    ```
    $ ln -sf /usr/share/zoneinfo/Zone/SubZone /etc/localtime
    ```

    And then you can reboot your system.
* **System update**

    Make sure you have already type both command : `pacman-key --init` and `pacman-key --populate archlinuxarm` 

    ```
    $ pacman -Syu       #update all system
    $ pacman -S sudo 
    $ nano /etc/sudoers

        #uncomment this line
        %wheel ALL=(ALL) ALL
    
    ```
    And exit to use normal user.

* **Install Lxqt on archlinux arm**

    ```
    $ sudo  pacman -S xorg xorg-xinit mesa lightdm lightdm-gtk-greeter lxqt xf86-video-fbdev breeze-icons xf86-video-fbturbo-git
    $ sudo systemctl enable lightdm networkmanager networkmanager-ap    
    $ sudo reboot
    ```
    After reboot use will see Lightdm Display Manager use login.