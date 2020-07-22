```
SA      : 003
Title   : Resize Linux Disk Partition
Author  : Saing Sab
Status  : Active
Create  : 2020-07-22
Update  : 2020-07-22
Version : 1
```
## Resize Linux Disk Partition
#### Intro
Expanding disk partitions to use all the available (unallocated) disk space is a common issue among Linux Administrators, 
expecially when working in a Cloud environment.

#### Scenario
AWS(apply to all cloud) install with 8GB root. after few month we found out that it's runn out of space then need to extend the disk.
After shutdown the instance and resized the disk the logical volume on instance does not increase. 

#### Solution
1. Login with root permission 
2. Enter command 
```
# parted
```
Then it's should occure as below:
```
GNU Parted 3.2
Using /dev/xvda
Welcome to GNU Parted! Type 'help' to view a list of commands.
```
3. Enter command
```
# print
```  
To see the current number of volume. 
```
(parted) print
Model: Xen Virtual Block Device (xvd)
Disk /dev/xvda: 32.2GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  8590MB  8589MB  primary  ext4         boot
 ```
 4. To extend enter the following commend:
 ```
 (parted) resizepart 1 (Volume number)
Warning: Partition /dev/xvda1 is being used. Are you sure you want to continue?
Yes/No? Yes                                                               
End?  [8590MB]? 30720 (eq to 30GB the sized of the disk to be extended)
```
5. Resize the logical volume
```
# resize2fs /dev/xvda1 (xvda1 is a volume)
```
6. Verify
```
#df -h
```
