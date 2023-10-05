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
title: Scans
points: 10
solved: true
---

# Scans

## Instructions

ESU's IT staff noticed some peculiar traffic from DEADFACE at the beginning of the attack. They sent a series of handshakes - the IT staff is stumped as to what DEADFACE was trying to do.

What type of scan did DEADFACE launch first?

Submit the flag as `flag{scantype}`.

[Download File](#)  
SHA1: `c2b1fcb40d8959d24e45752fbb040521c8fcb110`  
Password: `d34df4c3`


## Solution

At the beginning of the attack we can see a large number of `SYN` TCP packets indicated by `0x002`. 

![](attachments/Pasted%20image%2020221016232042.png)

`flag{syn}`

## Continued On

[Shells](Shells)