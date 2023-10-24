---
tags:
  - ctf
  - 2023-deadface
  - forensics
  - powershell
layout: ctf
type: problem
ctf: 2023-deadface
category: forensics
title: What's the Wallet
points: 20
solved: true
---

# What's the Wallet

## Instructions

Created by: hotstovehove

Ransomware was recently discovered on a system within De Monne’s network courtesy of a DEADFACE member. Luckily, they were able to restore from backups. You have been tasked with finding the Bitcoin wallet address from the provided sample so that it can be reported to the authorities. Locate the wallet address in the code sample and submit the flag as `flag{wallet_address}`.

[Download File](#)  
SHA1: `69c2fd859d7f3666349b41106bef348ce51ca0da`

## Solution

Looking through the Powershell script, we find a `Store-BtwWalletAddress` function with a base64-encoded Bitcoin wallet address.

```powershell
function Store-BtcWalletAddress {
    `$global:BtcWalletAddress = [System.Convert]::FromBase64String([System.Text.Encoding]::UTF8.GetBytes('bjMzaGE1bm96aXhlNnJyZzcxa2d3eWlubWt1c3gy'))
```

```
$ echo "bjMzaGE1bm96aXhlNnJyZzcxa2d3eWlubWt1c3gy" | base64 -d
n33ha5nozixe6rrg71kgwyinmkusx2

flag{n33ha5nozixe6rrg71kgwyinmkusx2}
```
