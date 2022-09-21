### In this exercise, I created 2 Ubuntu VMs, with user ubuntu_1 on VM ubuntu_1 and user ubuntu_2 on VM ubuntu_2
----

#### VM 1
```bash
innocent@innocent-HP-EliteBook-x360-1030-G2:~/VirtualMachines/VMs$ vagrant ssh ubuntu-1
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Aug 25 12:52:04 UTC 2022

  System load:  0.45              Processes:               121
  Usage of /:   3.5% of 38.70GB   Users logged in:         0
  Memory usage: 20%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 192.168.56.8


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@ubuntu-1:~$ sudo su
```

#### VM2
```bash
innocent@innocent-HP-EliteBook-x360-1030-G2:~/VirtualMachines/VMs$ vagrant ssh ubuntu-2
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Aug 25 12:52:40 UTC 2022

  System load:  0.59              Processes:               121
  Usage of /:   3.5% of 38.70GB   Users logged in:         0
  Memory usage: 20%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 192.168.56.9


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@ubuntu-2:~$ sudo su
```
<br>

### Here, I created the different Users on each VM
<br>

#### User ubuntu_1 on VM 1
```bash
root@ubuntu-1:/home/vagrant# su - ubuntu_1
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu_1@ubuntu-1:~$ ssh keygen
```

#### User ubuntu_2 on VM 2
```bash
root@ubuntu-2:/home/vagrant# su - ubuntu_2
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu_2@ubuntu-2:~$ su - vagrant
```

After creating both users, I generated an ssh key on ubuntu_1 and connected to ubuntu_2
```bash
ubuntu_1@ubuntu-1:~$ ssh ubuntu_2@192.168.56.9
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Aug 25 13:13:22 UTC 2022

  System load:  0.0               Processes:               131
  Usage of /:   3.7% of 38.70GB   Users logged in:         1
  Memory usage: 23%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%                IPv4 address for enp0s8: 192.168.56.9


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '22.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu_2@ubuntu-2:~$ ls
ubuntu_2@ubuntu-2:~$ mkdir testing
ubuntu_2@ubuntu-2:~$ ls
testing
```

I then ran the `ls` command to show that there's nothing in ubuntu_2 **`home`** directory.

After which I then created a directory **`testing`** in the **`home`** directory.

Which I then confirmed that the changes were reflected on the host machine **ubuntu_2**
```bash
ubuntu_2@ubuntu-2:~/.ssh$ cd ~
ubuntu_2@ubuntu-2:~$ ls
testing
ubuntu_2@ubuntu-2:~$ 
```

And that's it!