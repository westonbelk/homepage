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
title: Shells
points: 75
solved: true
---

# Scans

## Instructions

We know now that the attacker uploaded a file called `info.php` to gain access to the web server backend. What is the name of the tool/shell that gave the attacker a web shell?

Submit the flag as `flag{tool_name}`. For example: `flag{psexec}`.

_Use the file from **[Scans](Scans)**._


## Solution

Searching for the string `info.php` leads us to this TCP stream where we see the attacker obtain a shell as the web server user. `b374k shell: connected` is displayed at the beginning of this session.

![](attachments/Pasted%20image%2020221016160545.png)

`flag{b374k}`

## Continued On

[Passing on Complexity](Passing%20on%20Complexity)