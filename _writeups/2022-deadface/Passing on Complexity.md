---
# Obsidian
tags:
- ctf
- 2022-deadface
- traffic-analysis
- pcap
- wireshark

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2022-deadface
category: traffic-analysis
title: Passing on Complexity
points: 50
solved: true
---

# Passing on Complexity

## Instructions

ESU's IT staff swears up and down that the backup user's password is secure and follows best practice. Their internal auditors are not convinced and are asking for your help to determine the backup user's password at the time of the breach.

Submit the flag as `flag{password}`.

_Use the packet capture from **[Scans](Scans)**._


## Solution

The username and password for the backup user is exposed in the `backup.py` file.

![](attachments/Pasted%20image%2020221016163156.png)

`flag{backup123}`

## Continued On

[Escalation](Escalation)