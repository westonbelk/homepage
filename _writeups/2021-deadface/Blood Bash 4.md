---
# Obsidian
tags:
- ctf
- 2021-deadface
- forensics
- linux

# Jekyll
layout: ctf
type: problem

# CTF info
ctf: 2021-deadface
category: forensics
title: Blood Bash 4
points: 200
solved: true
---

# Blood Bash 4

## Instructions

A sensitive file from De Monne was exfiltrated by mort1cia. It contains data relating to a new web portal they're creating for their consumers. Read the contents of the file and return the flag as `flag{flag_goes_here}`.

Username: `bl0ody_mary`  
Password: `d34df4c3`

`bloodbash.deadface.io:22`

## Solution

In bl0ody_mary's home directory there is a pdf which may container the sensitive information related to the customer portal that we are after. 
![](attachments/Pasted%20image%2020211018161838.png)

First I attempted to use scp to grab this pdf file, and read it on my machine, but SCP was unable to copy it. There may have been a workaround or configuration change I could have done to get this method to work, but it was not something I explored. 
![](attachments/Pasted%20image%2020211018161824.png)

Instead, i just base64-encoded the file, copied the text to my local machine, then decoded the exfiltrated pdf.
![](attachments/Pasted%20image%2020211018161915.png)

![](attachments/Pasted%20image%2020211018162034.png)

The flag.
![](attachments/Pasted%20image%2020211018162234.png)


## Continued On


