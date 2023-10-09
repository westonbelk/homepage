---
tags:
  - ctf
  - 2023-sunshine
  - forensics
layout: ctf
type: problem
ctf: 2023-sunshine
category: forensics
title: Low Effort Wav 🌊
points: 100
solved: True
---

# Low Effort Wav 🌊

## Instructions

### The low-effort wave 🌊

Ride the wave man. 🏄‍♂️🏄‍♀️🌊

The wave is life. The waves are like, sound, and like water, and like cool and refreshing dude.

### But waves are hard to ride

So listen to them instead, crashing on the seashore. Listen to the music of the sea. Like the theme this year is music or something. So I theme this challenge, like, minimum effort music. Listen to this attached .wav file. It's amazing. Or so I've heard. Or rather, haven't. Something's broken with it. I don't know dude.

It also doesn't work. Can you fix this for me? I think there's a flag if you can find it.

[Download low_effort.wav](#)
SHA1: `84ba2dd67e0327ac2c63366a6c0cabc4efc3e509`

### Hints

There will be no hints given for this challenge by judges. The flag is in standard sun{} format. **If anything, we've already given you too much data.**

## Solution

Looking at the downloaded file in the file explorer, we can see that the thumbnail appears to be a screenshot of a conversation on Discord. Extracting the thumbnail gives us this: 

![](attachments/Pasted%20image%2020231007100030.png)

Getting some information about the image metadata reveals that the image was taken with a Google Pixel 7.

```
$ exiftool 0.png
Original File Name              : Screenshot_20230319-223111.png
Unique Camera Model             : Google Pixel 7
Warning                         : [minor] Trailer data after PNG IEND chunk
```

Exiftool also warns us that there is trailing data after the PNG IEND chunk. These indications pointed me towards this image being vulnerable to [Acropalypse](https://www.theverge.com/2023/3/19/23647120/google-pixel-acropalypse-exploit-cropped-screenshots).

Putting the image through an online Acropalypse extractor reveals the flag:

![](attachments/Pasted%20image%2020231007100515.png)

```
sun{well_that_was_low_effort}
```

## Continued On


