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
title: SHAshank Redemption
points: 100
solved: true
---

# SHAshank Redemption

## Instructions

There is some internal back-and-forth at ESU regarding which file was exfiltrated by DEADFACE. They've asked us to determine "the hash of the file". When asked what kind of hash, they responded "It doesn't matter - anything so that we can verify the integrity of the data stolen". See if you can find a hash for the file stolen by DEADFACE within the packet capture.

Submit the flag as `flag{hash}`.

_Use the packet capture from **[Scans](Scans)**._


## Solution

The attack exfiltrated the backup and provided us with a sha1sum of the exfiltrated backup. 

![](attachments/Pasted%20image%2020221016162003.png)

`flag{334a3d4f976cdf39d49b860afda77d6ac0f8a3c6}`

## Continued On

[New Addition](New%20Addition)

