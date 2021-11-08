---
# Obsidian
tags:
- ctf
- 2021-damctf
- misc
- forensics
- windows
- registry
- discord
- python
- github

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-damctf
category: misc
title: Imp3rs0nAt0r-1
points: {{points}}
solved: true
---

# Imp3rs0nAt0r-1

## Instructions

Some dumb college student thought he was leet enough to try and hack our university using a school computer. Thankfully we were able to stop the attack and we confiscated the equipment for forensic analysis.

Can you help us figure out what their next moves are?

Flag is in standard flag format.

[UsrClass.dat](#)

## Solution

Opening the UsrClass.dat in ShellBags Explorer shows that our attacker had some git repositories on his machine. Looking for these repositories online leads us to the attacker's Github page where these repos are found. https://github.com/nc-lnvp

![](attachments/Pasted%20image%2020211107082651.png)

There are leaked credentials for a discord located in the repository at:

https://github.com/nc-lnvp/h4ckerman-3000-bot/blob/main/bot.py

Using  `discord.py` we can dump the message history of the channels that the bot is in.

```python
import discord

client = discord.Client()

@client.event
async def on_ready():
    for channel in client.get_all_channels():
        if isinstance(channel, discord.channel.TextChannel):
            print(channel.guild, channel)
            messages = await channel.history(limit=100000).flatten()
            with open(f'messages-{channel.name}.log', 'w') as message_log:
                for message in messages:
                    message_log.write(f"{message.author}: {message.content}\n")
                    for attachment in message.attachments:
                        message_log.write(f"Attachment: {attachment.content_type}, {attachment.filename}, {attachment.url}\n")

token = base64.b64decode(b'T0RReU1qUTNPRFl6TWpVek56STVNamt3LllKeWljZy5oVFZjak1Dc3hjTkJCaGFPT1lYWGFrWUNDcDg=').decode()
client.run(token)
```

One of the attachments in the message history contains their master plan and the flag:
```
=== MASTER HACKER PLAN (do not share) ===

1) Get acc3ss t0 un1v3R5i7y
2) F0rK b0mB 33Cs Serv3r
3) ???????????
4) sT3al 4ll t3h R0buX
5) Pr0fiT
6) dam{Ep1c_Inf1ltr4t0r_H4ck1ng!!!!!!1!}

=========================================
```


## Continued On


