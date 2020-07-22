```
SA      : 004
Title   : Fix Temporary Failure In Name Resolution
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
AWS(apply to all cloud) not resolve the name, can't install npm because the host server is unreachable.
You also encounter a ping problem. That is, you can ping with IP address but cannot ping with domain name.

#### Solution
1. Backup the resolv.config file
```
sudo mv /etc/resolv.conf /etc/resolv.conf-original
```
2.Create new symlink of resolve config file
```
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
```
3. Restart the service 
```
sudo systemctl restart systemd-resolved
```
4. Verify 
ping to name server example:
```
ping google.com
```
