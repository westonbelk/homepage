---
# Obsidian
tags:
- ctf
- 2021-deadface
- forensics
- windows
- memory
- volatility

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-deadface
category: forensics
title: Window Pains
points: 30
solved: true
---

# Window Pains

## Instructions

One of De Monne's employees had their personal Windows computer hacked by a member of DEADFACE. The attacker managed to exploit a portion of a database backup that contains sensitive employee and customer PII.

Inspect the memory dump and tell us the Windows Major Operating System Version, bit version, and the image date/time (UTC, no spaces or special characters). Submit the flag as `flag{OS_BIT_YYYYMMDDhhmmss}`.

Example: `flag{WindowsXP_32_202110150900}`

[Download File](#) (1.5GB; ~5GB after decompression)  
SHA1: 293c3a2a58ed7b15a8454f6dcd8bec0773ba550e  
Password: `d34df4c3`

## Prerequisites
Python `requirements.txt`:

```bash
volatility3
yara-python
pycryptodome
capstone
```

## Solution

We can use the `windows.info` volatility function to get the information we need.

![](attachments/Pasted%20image%2020211018163859.png)

* NTMajorVersion 10
* Is64Bit True
* SystemTime 2021-09-07 14:57:44

`flag{Windows10_64_20210907145744}`

## Continued On

[Window Pains 2](Window%20Pains%202)

