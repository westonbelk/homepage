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

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-deadface
category: forensics
title: Window Pains 4
points: 200
solved: true
---

# Window Pains 4

## Prerequisites

### Install Volatility
```bash
$ python3 -m venv venv/
$ source venv/bin/activate
(venv) $ pip install volatility3 yara-python pycryptodome capstone
```

## Instructions

We want to see if any other machines are infected with this malware. Using the [memory dump file](#) from **Window Pains**, submit the SHA1 checksum of the malicious process.

Submit the flag as `flag{SHA1 hash}`.

**CAUTION** Practice good cyber hygiene! Use an isolated VM to download/run the malicious process. While the malicious process is relatively benign, if you're using an insecurely-configured Windows host, it may be possible for someone to compromise your machine if they can reach you on the same network.

## Solution

Use the DLL list function of volatility to list and dump the DLLs associated with our malicious process. Calculate the sha1sum for the userinit executable.
![](attachments/Pasted%20image%2020211018165831.png)

`flag{f1fed7aca78502c041dba20e63e2e3fde07d0777}`

## Continued On


