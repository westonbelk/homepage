---
tags:
  - ctf
  - 2023-tcp1p
  - forensics
  - pdf
layout: ctf
type: problem
ctf: 2023-tcp1p
category: forensics
title: EZ PDF
points: 100
solved: true
---

# EZ PDF

## Instructions

**Author**: `daffainfo`

I just downloaded this PDF file from a strange site on the internet....

## Solution

### Part 1

Examining the EXIF info for the PDF gives us a the first part of the flag, which has been divided into three pieces.

```
$ exiftool TCP1P-CTF.pdf 
ExifTool Version Number         : 12.65
File Name                       : TCP1P-CTF.pdf
Directory                       : .
File Size                       : 81 kB
File Modification Date/Time     : 2023:10:14 15:36:29-07:00
File Access Date/Time           : 2023:10:14 15:37:17-07:00
File Inode Change Date/Time     : 2023:10:14 15:37:17-07:00
File Permissions                : -rw-r--r--
File Type                       : PDF
File Type Extension             : pdf
MIME Type                       : application/pdf
PDF Version                     : 1.3
Linearized                      : No
Has XFA                         : No
Page Count                      : 1
XMP Toolkit                     : Image::ExifTool 12.40
Creator                         : SW4gdGhpcyBxdWVzdGlvbiwgdGhlIGZsYWcgaGFzIGJlZW4gZGl2aWRlZCBpbnRvIDMgcGFydHMuIFlvdSBoYXZlIGZvdW5kIHRoZSBmaXJzdCBwYXJ0IG9mIHRoZSBmbGFnISEgVENQMVB7RDAxbjlfRjAyM241MUM1
```

```
$ echo "SW4gdGhpcyBxdWVzdGlvbiwgdGhlIGZsYWcgaGFzIGJlZW4gZGl2aWRlZCBpbnRvIDMgcGFydHMuIFlvdSBoYXZlIGZvdW5kIHRoZSBmaXJzdCBwYXJ0IG9mIHRoZSBmbGFnISEgVENQMVB7RDAxbjlfRjAyM241MUM1" | base64 -d
In this question, the flag has been divided into 3 parts. You have found the first part of the flag!! TCP1P{D01n9_F023n51C5
```

### Part 2

Running the `pdftohtml` utility on the PDF produces two images for the pdf. One of which appears to be the middle part of the flag.

```
$ pdftohtml TCP1P-CTF.pdf
```
![](attachments/Pasted%20image%2020231014162345.png)

### Part 3

Looking through the PDF source, there is a block of Javascript code. Executing the `else { }` block in an isolated sandbox without network connectivity produces the last part of the flag. 

![](attachments/Pasted%20image%2020231014155155.png)
```
_15N7_17_l3jaf9ci293m1d}
```

Final flag.

```
TCP1P{D01n9_F023n51C5_0N_pdf_f1L35_15_345y_15N7_17_l3jaf9ci293m1d}
```

