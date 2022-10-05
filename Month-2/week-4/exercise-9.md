# Exercise 9

- Create an Ansible Playbook to setup a server with Apache
- The server should be set to the Africa/Lagos Timezone
- Host an index.php file with the following content, as the main file on the server:

<br>

~~~php
<?php
date("F d, Y h:i:s A e", time());
?>
~~~

> **Instruction:**
>
> Submit the Ansible playbook, the output of systemctl status apache2 after deploying the playbook and a screenshot of the rendered page

<br><br>

---

<br>

### Output of running `systemctl status apache2`

<br>

Here, I made use of 2 ubuntu servers as the nodes. So I used ansible to run the command on both servers and got the output.

~~~bash

user_admin@ubuntu-focal:~$ ansible ubuntu_servers -a "systemctl status apache2"
192.168.56.9 | CHANGED | rc=0 >>
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-10-05 17:43:17 WAT; 50min ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 16915 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
   Main PID: 16928 (apache2)
      Tasks: 6 (limit: 1131)
     Memory: 10.0M
     CGroup: /system.slice/apache2.service
             ├─16928 /usr/sbin/apache2 -k start
             ├─16930 /usr/sbin/apache2 -k start
             ├─16931 /usr/sbin/apache2 -k start
             ├─16932 /usr/sbin/apache2 -k start
             ├─16933 /usr/sbin/apache2 -k start
             └─16934 /usr/sbin/apache2 -k start
192.168.56.8 | CHANGED | rc=0 >>
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-10-05 17:43:17 WAT; 50min ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 17368 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
   Main PID: 17382 (apache2)
      Tasks: 7 (limit: 1131)
     Memory: 16.4M
     CGroup: /system.slice/apache2.service
             ├─17382 /usr/sbin/apache2 -k start
             ├─17383 /usr/sbin/apache2 -k start
             ├─17384 /usr/sbin/apache2 -k start
             ├─17385 /usr/sbin/apache2 -k start
             ├─17386 /usr/sbin/apache2 -k start
             ├─17387 /usr/sbin/apache2 -k start
             └─17473 /usr/sbin/apache2 -k start

~~~


<br>

#### Here's my [ansible playbook](./assets/playbook.yml) used :point_left:


#### And here's a screenshot of the PHP page as requested

![PHP page Screenshot](./assets/images/apache-and-php-with-ansible.png)