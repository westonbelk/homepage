---
# Obsidian
tags:
- ctf
- 2021-deadface
- forensics
- windows
- memory
- volatility
- malware
- clamav

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-deadface
category: forensics
title: Window Pains 3
points: 100
solved: true
---

# Window Pains 3

## Prerequisites

### Install Volatility
```bash
$ python3 -m venv venv/
$ source venv/bin/activate
(venv) $ pip install volatility3 yara-python pycryptodome capstone
```

## Instructions

Using the [memory dump file](#) from **Window Pains**, find out the name of the malicious process.

Submit the flag as `flag{process-name_pid}` (include the extension).

Example: `flag{svchost.exe_1234}`

## Solution

Use the volatility malfind function to search for and dump memory ranges that potentially contain injected code. 

![](attachments/Pasted%20image%2020211018165027.png)

Use Clamav to search for known malware.

![](attachments/Pasted%20image%2020211018165330.png)

Pid 8180 appears to contain known malware signatures. Use the volatility pslist function to get more information about the process.

`flag{userinit.exe_8180}`

## Continued On

[Window Pains 4](Window%20Pains%204.md)

