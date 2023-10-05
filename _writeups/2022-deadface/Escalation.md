---
# Obsidian
tags:
- ctf
- 2022-deadface
- traffic analysis
- pcap
- wireshark

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2022-deadface
category: traffic-analysis
title: Escalation
points: 75
solved: true
---

# Escalation

## Instructions

Somehow, the attacker was able to gain root access to the web server. We believe the attacker leveraged an existing file to gain root access. What file was modified to allow the attacker to gain root on the web server?

Submit the name of the file and the name of the variable used to store the added command. Example: `flag{backdoor.exe_var1}` if `backdoor.exe` is the name of the file and `var1` is the name of the variable.

_Use the packet capture from **[Scans](Scans)**._


## Solution

The `cmd` variable stored the command in the `backup.py` file that was used by the attacker to escalate their privileges to root.

![](attachments/Pasted%20image%2020221016160955.png)

`{backup.py_cmd}`

## Continued On

[The Root of All Evil](The%20Root%20of%20All%20Evil)