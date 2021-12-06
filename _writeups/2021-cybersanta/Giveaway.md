---
# Obsidian
tags:
- ctf
- 2021-cybersanta
- forensics
- office
- macros
- vbscript

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-cybersanta
category: forensics
title: Giveaway
points: 300
solved: true
---

# Giveaway

## Instructions

Santa's SOC team is working overtime during December due to Christmas phishing campaigns. A new team of malicious actors is targeting mainly those affected by the holiday spirit. Could you analyse the document and find the command & control server?

## Prerequisites
Python `requirements.txt`:

```bash
oletools
```

## Solution

Our download contains a Word document with macros. We can use the olevba tool to extract the VBA code that executes within the document.

```
$ olevba christmas_giveaway.docm
```

The extracted vba is obfuscated and appears to writes a powershell script to a hidden file and then executes it. The relevant section which writes the address to our C2 server in the script is here: 

```vb
Dim strFileURL, HPkXUcxLcAoMHOlj, cxPZSGdIQDAdRVpziKf, fqtSMHFlkYeyLfs, ehPsgfAcWaYrJm, FVpHoEqBKnhPO As String

HPkXUcxLcAoMHOlj = "https://elvesfactory/" & Chr(Asc("H")) & Chr(84) & Chr(Asc("B")) & "" & Chr(123) & "" & Chr(84) & Chr(Asc("h")) & "1" & Chr(125 - 10) & Chr(Asc("_")) & "1s" & Chr(95) & "4"
cxPZSGdIQDAdRVpziKf = "_" & Replace("present", "e", "3") & Chr(85 + 10)
fqtSMHFlkYeyLfs = Replace("everybody", "e", "3")
fqtSMHFlkYeyLfs = Replace(fqtSMHFlkYeyLfs, "o", "0") & "_"
ehPsgfAcWaYrJm = Chr(Asc("w")) & "4" & Chr(110) & "t" & Chr(115) & "_" & Chr(Asc("f")) & "0" & Chr(121 - 7) & Chr(95)
FVpHoEqBKnhPO = Replace("christmas", "i", "1")
FVpHoEqBKnhPO = Replace(FVpHoEqBKnhPO, "a", "4") & Chr(119 + 6)

Open XPFILEDIR For Output As #FileNumber
Print #FileNumber, "strRT = HPkXUcxLcAoMHOlj & cxPZSGdIQDAdRVpziKf & fqtSMHFlkYeyLfs & ehPsgfAcWaYrJm & FVpHoEqBKnhPO"

```

We can either manually trace the replacements/char conversions or just rewrite this string building section of VBA as VBScript and execute to print the C2 server:

```vb
Dim strFileURL, HPkXUcxLcAoMHOlj, cxPZSGdIQDAdRVpziKf, fqtSMHFlkYeyLfs, ehPsgfAcWaYrJm, FVpHoEqBKnhPO

HPkXUcxLcAoMHOlj = "https://elvesfactory/" & Chr(Asc("H")) & Chr(84) & Chr(Asc("B")) & "" & Chr(123) & "" & Chr(84) & Chr(Asc("h")) & "1" & Chr(125 - 10) & Chr(Asc("_")) & "1s" & Chr(95) & "4"
cxPZSGdIQDAdRVpziKf = "_" & Replace("present", "e", "3") & Chr(85 + 10)
fqtSMHFlkYeyLfs = Replace("everybody", "e", "3")
fqtSMHFlkYeyLfs = Replace(fqtSMHFlkYeyLfs, "o", "0") & "_"
ehPsgfAcWaYrJm = Chr(Asc("w")) & "4" & Chr(110) & "t" & Chr(115) & "_" & Chr(Asc("f")) & "0" & Chr(121 - 7) & Chr(95)
FVpHoEqBKnhPO = Replace("christmas", "i", "1")
FVpHoEqBKnhPO = Replace(FVpHoEqBKnhPO, "a", "4") & Chr(119 + 6)

dim strRT
strRT = HPkXUcxLcAoMHOlj & cxPZSGdIQDAdRVpziKf & fqtSMHFlkYeyLfs & ehPsgfAcWaYrJm & FVpHoEqBKnhPO 
WScript.Echo strRT
```

```powershell
PS > cscript .\script.vbs
Microsoft (R) Windows Script Host Version 5.812
Copyright (C) Microsoft Corporation. All rights reserved.

https://elvesfactory/HTB{Th1s_1s_4_pr3s3nt_3v3ryb0dy_w4nts_f0r_chr1stm4s}
```



