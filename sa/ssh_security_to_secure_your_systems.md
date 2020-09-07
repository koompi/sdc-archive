```
SA : 006
Title : SSH Security to secure you systems
Author : Heng Hongsea
Status : Active
Create : 2020-09-07
Update : 2020-09-07
Version : 1.0
```

# SSH Security to secure your systems

I have two method for do this: 

### Method 1:  Run Script Automatically

suppose a user will logon to my computer from another system(connected via lan) using ssh connection. At that time, A script(python or shell) should be run automatically in my system to perform some validation?

You can do so by adding the following parameter to your config file (/etc/ssh/sshd_config).

```
ForceCommand
	Forces the execution of the command specified by ForceCommand, ignoring any command supplied by the client and ~/.ssh/rc if present. The command is invoked by using the user's login shell
	with the -c option. This applies to shell, command, or subsystem execution. It is most useful inside a Match block. The command originally supplied by the client is available in the
	SSH_ORIGINAL_COMMAND environment variable. Specifying a command of “internal-sftp” will force the use of an in-process sftp server that requires no support files when used with
	ChrootDirectory.

```

To use the ForceCommand method you just add `ForceCommand /usr/bin/sshpassword` at the bottom of the file `/etc/ssh/sshd_config` (on the server).

The script looks like this:

```
#!/bin/bash

read -s -p "Enter Password: " PASSWORD
echo
if [[ "${PASSWORD}" != "PASSWORD" ]];then
        exit 0;
else
        /bin/bash
fi
```

And give permisson script and restart service.
```
$ shc -v -r -f sshpassword
$ sudo cp sshpassword.x /usr/bin/sshpassword
$ sudo chmod +x /usr/bin/sshpassword
$ sudo systemctl restart sshd
```

### Method 2: Private key and user password both required

Requirement is secure login, mainly on ssh. To achive more security SSH password based login, we shifted to key based login.

**Setup for both public key and password**
```
ssh-keygen
```
***Note: Copy the private key to the another client that you want ssh***

Login to the ssh server (the board) and edit the `/etc/ssh/sshd_config` file. Add the following line in the file:

```
AuthenticationMethods publickey,password
```
**Warning:** Make sure the the `PasswordAuthentication` looks like:
```
#PasswordAuthentication yes
```

Restart the ssh service in the server by:
```
sudo systemctl restart sshd
```
