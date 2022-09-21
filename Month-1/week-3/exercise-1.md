# Exercise 1

- Setup Ubuntu 20.04 LTS on your local machine using Vagrant

<br>

> **Instruction:**
>
> - Customize your Vagrant file as necessary with private_network set to DHCP.
>
> - Once the machine is up, run ifconfig and share the output in your submission along with your Vagrant file in a folder for this exercise.

<br><br>

---

<br>

### Output of running ifconfig after setting up the VM

```bash
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::b7:dfff:fec4:9d17  prefixlen 64  scopeid 0x20<link>
        ether 02:b7:df:c4:9d:17  txqueuelen 1000  (Ethernet)
        RX packets 929  bytes 114214 (114.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 746  bytes 116526 (116.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.3  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::a00:27ff:fe64:a1f5  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:64:a1:f5  txqueuelen 1000  (Ethernet)
        RX packets 8  bytes 3660 (3.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 23  bytes 3627 (3.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 8  bytes 712 (712.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 712 (712.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

<br>

Here's a copy of the [Vagrant File](./assets/Vagrantfile) :point_left: