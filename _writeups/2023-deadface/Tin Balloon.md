---
tags:
  - ctf
  - 2023-deadface
  - forensics
  - mp3
layout: ctf
type: problem
ctf: 2023-deadface
category: forensics
title: Tin Balloon
points: 150
solved: true
---

# Tin Balloon

## Instructions

Created by: Shamel

We've discovered that DEADFACE was somehow able to extract a fair amount of data from Techno Global Research Industries. We are still working out the details, but we believe they crafted custom malware to gain access to one of TGRI's systems. We intercepted a Word document that we believe mentions the name of the malware, in addition to an audio file that was part of the same conversation. We're not sure what the link is between the two files, but I'm sure you can figure it out!

Submit the flag as: `flag{executable_name}`. Example: `flag{malware.exe}`.

[Download ZIP](#)  
SHA1: `19d82c3dc14b342c3e3bd1e5761378ab821475e4`

## Solution

After extracting the ZIP, we are presented with two files: an MP3 and a .docx.

Trying to open the docx shows that it is password-protected.

Opening the mp3 in Audacity and switching the view from waveform to spectrogram reaveals the hidden message.

![](attachments/Pasted%20image%2020231020153345.png)

Using the secret message `Gr33dK1Lzz@11Wh0Per5u3` as the password to the .docx file unlocks the document. The document has the following text:

```
We have the ID card of one the brand new employees Alejandro, We now know the location of Techno Global, we have a man on sight that has been tailing him. We believe we can get into the facility at 3 am.

We don’t know how long we can have a foothold on the system but we are going to use Wh1t3_N01Z3.exe to sent out a reverse shell. Be prepared to listen for the signal.
```

The challenge description says that the flag is the name of the malware.

Flag: `flag{Wh1t3_N01Z3.exe}`