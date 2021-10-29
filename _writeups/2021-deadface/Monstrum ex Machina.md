---
# Obsidian
tags:
- ctf
- 2021-deadface
- traffic-analysis
- pcap
- wireshark
- python

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-deadface
category: traffic-analysis
title: Monstrum ex Machina
points: 30
solved: true
---

# Monstrum ex Machina

## Instructions

Our person on the "inside" of Ghost Town was able to plant a packet sniffing device on Luciafer's computer. Based on our initial analysis, we know that she was attempting to hack a computer in Lytton Labs, and we have some idea of what she was doing, but we need a more in-depth analysis. This is where YOU come in.

We need YOU to help us analyze the packet capture. Look for relevant data to the potential attempted hack.

To gather some information on the victim, investigate the victim's computer activity. The "victim" was using a search engine to look up a name. Provide the name with standard capitalization: `flag{Jerry Seinfeld}`.

[Download file](#)  
SHA1: 6c0caf366dae3e03bcbd7338de0030812536894c

_NOTE:_ All of the packet capture challenges use this PCAP file.

## Solution

The instructions state that the attacker was using a search engine. My initial thought is to filter the traffic to HTTP requests and look for keywords like "search".

```python
import pyshark

def monstrum_ex_machinima(pcap_file):
    http_reqs_filter = "http.request.full_uri and tcp"
    http_reqs = pyshark.FileCapture(pcap_file, keep_packets=False, display_filter=http_reqs_filter)
    
    search = [pkt for pkt in http_reqs if "search" in pkt.http.request_full_uri]
    log.info(f"Found {len(search)} results for query.")

    with open('monstrum_ex_machinima-results.txt', 'w') as f:
        for pkt in search:
            f.write( pkt.http.request_full_uri + "\n" )
        log.info("Wrote query results to file.")
```

We can see that there was a baidu search for Charles Geschickter.

![](attachments/Pasted%20image%2020211022152456.png)

`flag{Charles Geschickter}`

## Continued On


