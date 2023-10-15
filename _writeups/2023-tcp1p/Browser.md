---
tags:
  - ctf
  - 2023-tcp1p
  - forensics
  - browser
  - opera
layout: ctf
type: problem
ctf: 2023-tcp1p
category: forensics
title: Browser
points: 100
solved: true
---

# Browser

## Instructions

**Author**: `daffainfo`

Maybe some people in this world have tried forensics on Chrome and Mozilla Firefox. What if we try to do forensics on this unknown browser?

## Solution

Looking at the `History` database, we can see that there's a Pastebin link. Unfortunately this link is prompting us for a password.

![](attachments/Pasted%20image%2020231014152632.png)

A bit of poking around the manifests in the extensions folder leads me to believe we're looking at an Opera browser.Since Opera is based on Microsoft Edge, I did a bit of research and found that autofill data is stored in the `Web Data` database. Opening this database leads us to the autofill password for the Pastebin.

![](attachments/Pasted%20image%2020231014153246.png)

```
TCP1P{51m1L4R_t0_Go0gl3_cHr0m3_r1gHT_B35E77F38AB0DEC2}
```


