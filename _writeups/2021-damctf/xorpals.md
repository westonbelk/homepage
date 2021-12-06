---
# Obsidian
tags:
- ctf
- 2021-damctf
- crypto
- xor
- python

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-damctf
category: crypto
title: xorpals
points: 188
solved: true
---

# xorpals

## Instructions

One of the 60-character strings in the provided file has been encrypted by single-character XOR. The challenge is to find it, as that is the flag.

Hint: Always operate on raw bytes, never on encoded strings. Flag must be submitted as UTF8 string.

## Solution

The lines in the flag file appear to be 120 characters long and all characters are in the hex range. As such, we need convert the bytes from a string to the appropriate hex bytes. From there, we can test all the strings on possible xor transformations.

```python
#!/usr/bin/env python3
from binascii import unhexlify

def main():
    # read inputs into array of bytearrays
    encoded = None
    with open("flags.txt", "r") as f:
        lines = f.readlines()
        encoded = [unhexlify(line.rstrip()) for line in lines]

    # generate possible xor bytes
    possible_xor_bytes = range(256)
    
    # xor all input strings with possible xor bytes and search for flag format
    for xor_byte in possible_xor_bytes:
        for line in encoded:
            try:
                xored_bytes = bytes([line[i] ^ xor_byte for i in range(len(line))])
                string = xored_bytes.decode()
                if string.startswith("dam{"):
                    print(string)
                    print(f"xor value: {xor_byte}")
            except:
                pass

if __name__ == "__main__":
    main()

```

```shell
$ python3 -m xorpals
dam{antman_EXPANDS_inside_tHaNoS_never_sinGLE_cHaR_xOr_yeet}
xor value: 69
```

## Continued On


