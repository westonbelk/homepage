---
# Obsidian
tags:
- ctf
- 2022-deadface
- bonus

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2022-deadface
category: bonus
title: Contact
points: 50
solved: true
---

# Contact

## Instructions

What is lilith's email address?

Submit the flag as `flag{user@domain}`

## Solution

From [Grave Digger 3](Grave%20Digger%203), the man page for `/opt/reader` includes lilith's email address.

```
AUTHOR
       Lilith (bl0ody_mary@deadface.io)
```

```
flag{bl0ody_mary@deadface.io}
```
