---
tags:
  - ctf
  - 2022-deadface
  - pwn
  - hashcat
layout: ctf
type: problem
ctf: 2022-deadface
category: pwn
title: Spectre WiFi
points: 300
solved: true
---

# Spectre WiFi

## Instructions

A NETGEAR router in the main library of Eastern State University was hacked, leading to a prolonged man-in-the-middle attack and student passwords getting swiped. The network admin cannot remember how to log into the router’s admin portal to change the password and review the logs. He does not remember the WPA key to log in. He also thinks the default wpa keys were never changed. Here was the hash he found:

Original Hash: `124438d426a9cfe4d5c7cb7ac1a091c1b32a2b7bc70d81dd036ae8e41ead2523`

Updated Hash: `4be29bb887c260061afb229d81d250a05f92fa59e324cc16fa7ae2fd3fadd1a9`

Can you find out what the wpa keys were? Assume the key is not salted due to the age of the NETGEAR router.

Enter the answer as `flag{password}`.


## Solution

Default Netgear passwords follow a pattern of \<noun>\<adjective>\<numbers>. By searching online I found [some wordlists](https://github.com/LivingInSyn/netgear_hashcat_wordlist) that can be used to generate a list of passwords to brute force the hash.

As shown in the Github repository, we can use the hashcat combinator3 program to combine the noun, adjectives, and numbers we’ll need for our password list. 

```
$ /usr/lib/hashcat-utils/combinator3.bin wordlists/adjectives.txt wordlists/nouns.txt wordlists/numbers.txt | hashcat -O -w 3 -D 2 -d 1 -m 1400 --show hashes

124438d426a9cfe4d5c7cb7ac1a091c1b32a2b7bc70d81dd036ae8e41ead2523:flexiblewillow831
4be29bb887c260061afb229d81d250a05f92fa59e324cc16fa7ae2fd3fadd1a9:calmcarrot515
```

```
flag{flexiblewillow831}
or
flag{calmcarrot515}
```



