---
tags:
  - ctf
  - 2023-deadface
  - forensics
  - windows
layout: ctf
type: problem
ctf: 2023-deadface
category: forensics
title: Malum
points: 75
solved: true
---

# Malum

## Instructions

Created by: RP-01?

Well, it happened. The ransomware event took us out but we are recovering. It's Tuesday now and time to head into the office. As you arrive your boss walks into the SOC with a sigh and look right to you; here we go. He drops a USB on your desk and says "I need you to go through all the logs to find out HOW these guys got valid credentials to attack us". Can you identify the threat vector that was used to gain persistence into the network by reading through security logs? What you find will be the flag.

Submit the flag as `flag{flagText}`

[Download File](#)  
SHA1: `557c6ea508dd7ca7891fb254e5d137a7786fcc4e`

## Prerequisites

Install EvtxECmd and Timeline Explorer from [Eric Zimmerman](https://ericzimmerman.github.io/#!index)

## Solution

Using `EvtxECmd`, convert the Windows event logs from the EventLog format to CSV.

```
EvtxECmd.exe -f .\Maybehere.evtx --csv . --csvf maybehere.csv
```

Open `maybehere.csv` in Timeline Explorer and filter to failed logon attempts. (`Event ID = 4625`)

![](attachments/Pasted%20image%2020231023224845.png)

We can see logon attempts for `fkreuger` and `stabBingStabber1`. 

The flag is `flag{stabBingStabber1}`.

I think the threat vector that the challenge author was trying to portray was a user accidentally entering their password in the username field and having this logged.