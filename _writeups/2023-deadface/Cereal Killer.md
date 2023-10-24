---
tags:
  - ctf
  - reversing
  - binary
layout: ctf
type: problem
ctf: 2023-deadface
category: Reverse Engineering
title: Cereal Killer
points: 50
solved: true
---


# Cereal Killer

## Instructions

Created by: TheZeal0t

How well do you know your DEADFACE hackers? Test your trivia knowledge of our beloved friends at our favorite hactivist collective! We’ll start with `bumpyhassan`. Even though he grates on `TheZeal0t` a bit, we find him to be absolutely ADORKABLE!!!

Choose one of the binaries below to test your BH trivia knowlege.

Enter the flag in the format: `flag{Ch33ri0z_R_his_FAV}`.

## Solution

After opening this binary up in Ghidra we can see that there's an encoded text and that the flag gets written out to us after we put in the correct password. However, I quickly noticed that the flag reading function does involve the guess that we input. Taking a closer look at the flag decoding routine, it's just grabbing every other letter of the string.

![](attachments/Pasted%20image%2020231023234016.png)

I just used a pencil and paper to write every other letter since the string was fairly short. I still don't know what their favorite breakfast cereal is.

```
flag{I_am_REDDY_for_FREDDY!!!}
```