---
# Obsidian
tags:
- ctf
- 2022-deadface
- forensics
- web

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2022-deadface
category: forensics
title: First Strike
points: 10
solved: true
---

# First Strike

## Instructions

There was a cyber attack on ESU's website on **July 27th**. ESU IT staff collected data from the attack and need your help sifting through it.

What IP Address did the attack originate from? Submit the flag as: `flag{ip_address}`. Example: `flag{192.168.1.1}`.

[Download access.log](#)  
SHA1: `b71d59350a6802b9fc1b772a76388ca250ba6d89`  

[Download error.log](#)  
SHA1: `8fc2c50a21e7133c319c6bb4df597cc707f21c91`

## Solution

Given the first line showing an NMAP scan:

```
165.227.73.138 - - [27/Jul/2022:14:13:52 +0000] "GET / HTTP/1.1" 200 6225 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
```

We can see that the attacker is originating from `165.227.73.138`

```
flag{165.227.73.138}
```


## Continued On
[Toolbox](Toolbox)

