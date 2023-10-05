---
# Obsidian
tags:
- ctf
- 2022-deadface
- forensics
- linux

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2022-deadface
category: forensics
title: Grave Digger 1
points: 15
solved: true
---

# Grave Digger 1

## Instructions

Turbo Tactical has gained access to a machine owned by DEADFACE. It appears `crypto_vamp`, a new recruit at DEADFACE, used a weak password for his account on `d34th`'s machine. See if you can find the flag associated with "Grave Digger 1"

`env.deadface.io`  
Password: `123456789q`


## Solution

Connect as the compromised user using the provided credentials and list environment variables.

```
$ ssh crypto_vamp@env.deadface.io
crypto_vamp@env.deadface.io's password: 123456789q
crypto_vamp@da4c4c0c34da:~$ env
GRAVEDIGGER1=flag{d34dF4C3_en1roN_v4r}
HOSTNAME=da4c4c0c34da
PWD=/home/crypto_vamp
HOME=/home/crypto_vamp
TERM=xterm
TMOUT=1600
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
_=/usr/bin/env
crypto_vamp@da4c4c0c34da:~$
```

```
flag{d34dF4C3_en1roN_v4r}
```

## Continued On

[Grave Digger 2](Grave%20Digger%202)
