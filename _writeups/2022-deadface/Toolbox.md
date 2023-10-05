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
title: Toolbox
points: 15
solved: true
---

# Toolbox

## Instructions

What tool was used when the attack started at 2022-07-27 14:13 UTC? Submit the flag as `flag{tool}`. Example: `flag{notepad}`.

_Use the files from **[First Strike](First%20Strike)**._

## Solution

Given the first line showing an NMAP scan:

```
165.227.73.138 - - [27/Jul/2022:14:13:52 +0000] "GET / HTTP/1.1" 200 6225 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
```

```
flag{nmap}
```

## Continued On
[Agents of Chaos](Agents%20of%20Chaos)

