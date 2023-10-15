---
tags:
  - ctf
layout: ctf
type: problem
ctf: 2023-tcp1p
category: forensics
title: Reminiscence
points: 500
solved: false
---

# Reminiscence

## Instructions

We've detected unusual network traffic within our network. Upon inspection, it turns out that a malicious actor gained access to one of our staff's credentials and logged into the server. Could you analyze what actually occurred?

Hint: It is necessary to decrypt all of the packets in order to gain a better understanding of what truly occurred during each session. In this case, you may need to use a certain tool based on a specific CVE

## Solution


### Question 1

```
Q1:
Question: What TCP protocol is recorded in the network packet? Please enter the port as well
Format: ftp:1337
```

```
ssh:23425
```

### Question 2

```
Q2:
Question: What is the SSH version that could be affected by a security bug? Is it a client or server?
Format: OpenSSH_6.9_server
Answer: OpenSSH_4.3_client
Correct
```

### Question 3

observe number of tcp streams

```
tcp.stream eq 3 and data.len > 128 and ip.dst eq 172.18.0.2
```

#### Question 4

```
Q4:
Question: What is the name of the malicious script uploaded during the SFTP session?

```