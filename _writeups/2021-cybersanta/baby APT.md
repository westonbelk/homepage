---
# Obsidian
tags:
- ctf
- 2021-cybersanta
- forensics
- wireshark

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-cybersanta
category: forensics
title: baby APT
points: 300
solved: true
---

# baby APT

## Instructions

This is the most wonderful time of the year, but not for Santa's incident response team. Since Santa went digital, everyone can write a letter to him using his brand new website. Apparently an APT group hacked their way in to Santa's server and destroyed his present list. Could you investigate what happened?

[christmaswishlist.pcap](#)

## Solution
Browsing through the pcap we can see some http traffic to the host named christmaswishlist with the address 192.168.1.11.

![](attachments/Pasted%20image%2020211201151450.png)

In the second POST request the attacker drops a PHP web shell onto the web server.

![](attachments/Pasted%20image%2020211201151822.png)

The attacker then uses this to perform some recon on the machine including listing users, groups, and files. In the last request they remove the database at `.ht.sqlite` and echo the base64 encoded flag.

![](attachments/Pasted%20image%2020211201152103.png)

```HTB{0k_n0w_3v3ry0n3_h4s_t0_dr0p_0ff_th3ir_l3tt3rs_4t_th3_p0st_0ff1c3_4g41n}```


