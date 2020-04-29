### How to fix Amazon EC2 instance when you accidentally block port 22

### Scenario: 
You enable UFW on your Amazon EC2 instance then you log off the system. When you try to connect to that EC2 instance, it doesn’t work because you forget to add SSL (port 22) in the UFW rules.

### Solution:
1. We need another running EC2 instance to fix the broken EC2 instance. Please create a new EC2 instance if you don’t have an extra one handy

2. Stop the broken EC2 instance and detach the volume

3. Attach the volume from the broken EC2 to the other EC2 instance or the one you just created in step #1. For device name, you can use /dev/sdf (you can choose from sdf through sdp)

4. Now connect to the new EC2 instance

5. Create a folder named fixme (it can be any name you prefer) in your home directory

6. Mount the volume to the fixme folder using the following command:
    ```sudo mount /dev/xvdf ~/fixme```
Note: newer linux kernels may rename your device to /dev/xvdf (which it did so in my case)

7. After successful mount, go to ~/fixme/etc/ufw and edit ufw.conf

8. Set enabled=no and save the change

9. Unmount the volume using the following command:
    ```sudo umount /dev/xvdf```

10. Return to AWS console, detach the volume and reattach it to the broken EC2 instance

11. Start that broken EC2 instance, it is now no longer broken and you will be able to SSH into that instance like before.
