---
# Obsidian
tags:
- ctf
- 2021-deadface
- forensics
- windows
- memory
- volatility

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-deadface
category: forensics
title: Window Pains 2
points: 50
solved: true
---

# Window Pains 2

## Instructions

Using the [memory dump file](#) from **Window Pains**, submit the victim's computer name.

Submit the flag as `flag{COMPUTER-NAME}`.

## Prerequisites
Python `requirements.txt`:

```bash
volatility3
yara-python
pycryptodome
capstone
```

## Solution

Use volatility to list the environment variables and grep for the appropriate variable.
![](attachments/Pasted%20image%2020211018164504.png)

## Continued On

[Window Pains 3](Window%20Pains%203)

