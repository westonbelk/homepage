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
title: Blood Bash
points: 10
solved: true
---

# Blood Bash

## Instructions

We've obtained access to a system maintained by bl0ody_mary. There are five flag files that we need you to read and submit. Submit the contents of `flag1.txt`.

Username: `bl0ody_mary`  
Password: `d34df4c3`

`bloodbash.deadface.io:22`

## Solution
SSH with the provided credentials and grep for flag. We can see that we discovered the flag we were looking for as well as a future flag.

![](attachments/Pasted%20image%2020211018160943.png)

## Continued On

[Blood Bash 2](Blood%20Bash%202)