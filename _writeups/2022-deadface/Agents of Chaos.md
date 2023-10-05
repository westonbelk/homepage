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
title: Agents of Chaos
points: 25
solved: true
---

# Agents of Chaos

## Instructions

What is the _first_ user agent of the _second_ scanning tool used by the attacker? Submit the flag as `flag{user agent string}`.

_Use the files from **[First Strike](First%20Strike)**._

## Solution

The first scanning tool used was NMAP, indicated by the following in access.log:
```
165.227.73.138 - - [27/Jul/2022:14:13:52 +0000] "GET / HTTP/1.1" 200 6225 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
```

After NMAP, we can see Nikto being used:
```
165.227.73.138 - - [27/Jul/2022:14:15:13 +0000] "GET / HTTP/1.1" 200 6262 "-" "Mozilla/5.00 (Nikto/2.1.6) (Evasions:None) (Test:Port Check)"
```

The user agent is:

```
flag{Mozilla/5.00 (Nikto/2.1.6) (Evasions:None) (Test:Port Check)}
```
