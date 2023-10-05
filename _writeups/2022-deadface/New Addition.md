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
title: New Addition
points: 100
solved: true
---

# New Addition

## Instructions

DEADFACE tried to add a user to the ESU database. What is the username of the user they tried to add to the database?

Submit the flag as `flag{username}`.

_Use the packet capture from **[Scans](Scans)**._


## Solution

DEADFACE tried to add the user `areed2022`.

![](attachments/Pasted%20image%2020221016162422.png)

`flag{areed2022}`
