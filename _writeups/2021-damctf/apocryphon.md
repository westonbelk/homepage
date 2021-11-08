---
# Obsidian
tags:
- ctf
- 2021-damctf
- misc

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-damctf
category: misc
title: apocryphon
points: {{points}}
solved: false
---

# apocryphon

## Instructions

We got this suspicious email today in our inbox from someone claiming to have popped our infra and are now demanding a ransom. While we have high confidence that these claims are fake, we would still like to investigate the matter fully.

Can you help us find the true identity of the person behind this email?

The flag is in standard flag format.

[Iv3_g0t_yo=0u_r19ht_1n_my_7r4ck5.eml](#)

## Prerequisites

## Solution

The malicious email has the following contents:
```
From the-information-society-231645@protonmail.com  Fri Nov 05 06:22:21 2021
X-Original-To: admin@damctf.xyz
To: admin@damctf.xyz
Subject: Iv3 g0t yo=0u r19ht 1n my 7r4ck5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Date: Fri, 05 Nov 2021 06:22:21 +0000 (UTC)
From the-information-society <the-information-society-231645@protonmail.com>

== ATTENTION ADMINS OF DAMCTF ==
== VERY IMPORTANT MESSAGE MUST READ ==

ive hacked into your systems and can see all your infra >:)
i can see all of your secrets >:)
you better send me one million dogecoin or im gonna send your browsing history to the entire internet :O
i want those dogs in my wallet by tomorrow or youre gonna get leaked sucker B)

ciao nerds

- best hacker
```


## Continued On


