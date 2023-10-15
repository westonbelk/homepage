---
tags:
  - ctf
  - 2023-tcp1p
  - forensics
  - ntfs
  - windows
  - filesystem
layout: ctf
type: problem
ctf: 2023-tcp1p
category: forensics
title: hide and split
points: 100
solved: true
---

# hide and split

## Instructions

**Author**: `underzero`

Explore this disk image file, maybe you can find something hidden in it.

505f90ceb7ed8250fbb4add69ab07ab2  challenge.zip

## Solution

Using `fls` from Sleuthkit lists the files on the NTFS filesystem. 
```
$ fls challenge.ntfs
r/r 4-128-1:	$AttrDef
r/r 8-128-2:	$BadClus
r/r 8-128-1:	$BadClus:$Bad
r/r 6-128-1:	$Bitmap
r/r 7-128-1:	$Boot
d/d 11-144-2:	$Extend
r/r 2-128-1:	$LogFile
r/r 0-128-1:	$MFT
r/r 1-128-1:	$MFTMirr
r/r 9-128-2:	$Secure:$SDS
r/r 9-144-3:	$Secure:$SDH
r/r 9-144-4:	$Secure:$SII
r/r 10-128-1:	$UpCase
r/r 10-128-2:	$UpCase:$Info
r/r 3-128-3:	$Volume
r/r 64-128-2:	flag00.txt
r/r 64-128-4:	flag00.txt:flag0
r/r 65-128-2:	flag01.txt
r/r 65-128-4:	flag01.txt:flag1
r/r 66-128-2:	flag02.txt
r/r 66-128-4:	flag02.txt:flag2
r/r 67-128-2:	flag03.txt
r/r 67-128-4:	flag03.txt:flag3
```

Reading `flag00.txt` (and any other `flagXX.txt`) gives the following content:
```
$ fcat flag00.txt challenge.ntfs
Unfortunately this is not the flag
The flag has been split and stored in the hidden part of the disk
```

Instead, each of the `flagXX.txt` files contain an alternate data stream with the actual flag content. We can read the alternate data stream by passing the inode of the entry of the ADS file to the `icat` utility.

```
$ icat challenge.ntfs 64-128-4
89504e470d0a1a0a0000000d49484452000003390000033908000000000179a0c500000e684
```

This appears to be hex-encoded data. Decoding this using `xxd` indicates that this is the header to a PNG file.

```
$ icat challenge.ntfs 64-128-4 | xxd -p -r - | file -
/dev/stdin: PNG image data, 825 x 825, 8-bit grayscale, non-interlaced
```

We can iterate through each alternate data stream in the filesystem to reconstruct the original file which is a picture of a QR code.

![](attachments/Pasted%20image%2020231013192514.png)

Decoding the QR code gives the flag:

```
TCP1P{hidden_flag_in_the_extended_attributes_fea73c5920aa8f1c}
```

Bash one-liner
```
$ fls challenge.ntfs | grep "txt:flag" | cut -d ' ' -f 2 | sort -n | cut -d ':' -f 1 | xargs -n 1 icat challenge.ntfs | xxd -p -r -  | zbarimg -

QR-Code:TCP1P{hidden_flag_in_the_extended_attributes_fea73c5920aa8f1c}
scanned 1 barcode symbols from 1 images in 0.06 seconds

```