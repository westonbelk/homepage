---
# Obsidian
tags:
- ctf
- 2021-deadface
- forensics
- linux

# Jekyll
layout: ctf
type: problem

# CTF info
ctf: 2021-deadface
category: forensics
title: Blood Bash 3
points: 100
solved: true
---

# Blood Bash 3

## Instructions

There's a flag on this system that we're having difficulty with. Unlike the previous flags, we can't seem to find a file with this flag in it. Perhaps the flag isn't stored in a traditional file?

Username: `bl0ody_mary`  
Password: `d34df4c3`

`bloodbash.deadface.io:22`

## Solution

For this flag I went a bit further than was necessary. I initially checked the sudo privileges for my user and saw that I was able to run `/opt/start.sh` as root. Running this program elevated my permissions to root.

![](attachments/Pasted%20image%2020211018161338.png)

Checking root's bash history we can see multiple calls to `netstat -ano`. This gives us a clue that there may be a service that we should investigate

![](attachments/Pasted%20image%2020211018161512.png)

Checking services, we see that there is a udp service on port 43526. Using netcat we can connect to this service and it replies with the flag.

![](attachments/Pasted%20image%2020211018161548.png)

## Continued On
[Blood Bash 4](Blood%20Bash%204)

