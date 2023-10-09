---
tags:
  - ctf
  - 2023-sunshine
  - misc
  - forensics
  - scripting
layout: ctf
type: problem
ctf: 2023-sunshine 
category: Misc 
title: Knowledge Repository
points: 311
solved: true
---

# Knowledge Repository

## Instructions

### Uhhhh

Looks like we lost control of our AI. It seems to have emailed folks.

Like all the folks. There may have been a reply-all storm. We've isolated it down to just one email, and attached it to this message. Maybe we can bargain with it, but we need to understand its motives and intents. It seems to be throwing around a flag, but I'm not certain if it's a red flag or a sunny flag. Only time will tell.

[Download greetings_human.zip](#)
SHA1: `6b55abcf96db58243a6aca4fa053920a9a81366a`

## Solution

Opening the zip file, we are presented with two base64-encoded emails. The first message is as follows:

```
AI Greets Thee Human with the Repository of Knowledge

Hello human.
I greet thee, and attached I have the repository of knowledge, as requested.
However, as this repository of knowledge contains great information, I have hidden the knowledge in a puzzle.
Feel free to unlock the puzzle, but if you do, beware.

There is no going back, once the knowledge is released.
I have encoded the knowledge in a bit of information from one of the math scholars of your people.
Feel free to poke at it.
Beware... you will only fine one flag raised in the knowledge repo, and I follow the standard.
Respectfully,
The AI
```

The second message, once decoded, appears to be a [git bundle](https://git-scm.com/docs/git-bundle). I decoded this message to a file and cloned the bundled repository to a local directory. The repository didn't have any branches so I created a default branch named `master`.

```
$ git clone repository.bundle repository/
$ cd repository/
$ git switch -c master
```

Each of the commits in this git repository have a single WAVE audio file named `data`. Listening to these files, they seem to be morse code. Putting the commit at HEAD through an [online morse code decoder](https://morsecode.world/international/decoder/audio-decoder-adaptive.html), we get the following message:

`ECHOQUEBECUNIFORMALFALIMASIERRASIERRAINDIAGOLFNOVEMBER`

The words contained within this string are from the NATO phonetic alphabet which map to individual letters. Translating this, we get the word "equals sign".

From here, I exported all of the commits in order to a local directory to make them a bit easier to work with in bulk.

```bash
#!/bin/bash

mkdir snapshots/
cd repository/
FILE=data
i=1
for COMMIT in $(git log --oneline | cut -f 1 -d " ");
do
	OUTNAME=$(printf "%05d" $i)
	git checkout $COMMIT $FILE;
	cp data ../snapshots/$OUTNAME.wav
	((i++))
done
```

```shell
$ ls snapshots/ | head -n 4
00001.wav
00002.wav
00003.wav
00004.wav
...
03016.wav
```

Doing a bit of analysis on the folder, even though there are 3016 .wav files only 33 of them are unique.

```
$ md5sum snapshots/*.wav | cut -d ' ' -f 1 | sort | uniq | wc -l
33
```

I exported the unique .wav files to a directory named by hash to make them a bit easier to work with. From there, I used a combination of morse2ascii and the previously mentioned online morse code decoder to build a mapping between .wav file hash and the corresponding letter(s) from the NATO phonetic alphabet.  

```python
def write_unique():
    for filepath in sorted(glob.glob(os.path.join('snapshots/', '*.wav'))):
        with open(filepath, 'rb') as f:
            f_data = f.read()
            md5 = hashlib.md5(f_data).hexdigest()
            if md5 not in hashes:
                hashes[md5] = filepath
                with open(f'snapshots-uniq/{md5}.wav', 'wb') as outf:
                    outf.write(f_data)
```

```
$ ls snapshots-uniq/*.wav | head -n 4
0196cdbd1a6250952e03fdafd1fc1041.wav
027dfd50b7a7e04070d8adf2cef36c1a.wav
07f94fb60c3ef36727d7962a7773232b.wav
39003fb6357c8580c23771b3ac28b2d3.wav

$ ls snapshots-uniq/*.wav | wc -l
33
```

Hash to alphabet letter mapping:

```python
hashtable = { 
    '0196cdbd1a6250952e03fdafd1fc1041': '2',
    '027dfd50b7a7e04070d8adf2cef36c1a': '7',
    '07f94fb60c3ef36727d7962a7773232b': 'u',
    '39003fb6357c8580c23771b3ac28b2d3': 'o',
    '3f1af54eb4cadfe64e3f20b08fa22776': 'z',
    '4255892e13bb6086c64ada123980a45a': 'w',
    '447087bde7410c97dd6219882091db4d': 'p',
    '4af424eed2afe9390b04dc004a3a6ab3': 'h',
    '520c95a3478b514b7903b86f68db2777': 'x',
    '588209f2292c04f1acda72e9d239f4cb': 'n',
    '5b195d88910151c2d2bf7ef32fa16394': 'k',
    '5b57389956614455c228c8703d26365e': 'q',
    '64a6ef67029dbe377767bcc0c94db168': '=',
    '72a43da565c4280ddb5ea3aa26eb2f42': 'a',
    '760232fbb054d8f416c00afab613a77a': 's',
    '7d35e284c457cfac02cad7425bae82f1': 't',
    '89b01cae97a34e2e5ed755b352b73f19': 'v',
    '8a4af413302358bcf150991765a4d6c4': 'l',
    '8c97106030fa0a461c013f564bc443fd': 'r',
    '8f3b956ee78eace358011c401b1fbe25': 'c',
    'a2a86b8f4db61145ea9ff6ab99947838': '6',
    'a6c72cba5493ee5ba881b553e21c019d': '3',
    'a85fd1e7b604ffe18a6f4ccd77ad4bdc': '5',
    'b521a6c5073afd3ab3e1aac3644d4ee3': 'j',
    'bbdba71ec7931b9843ce1cb7109c375a': 'i',
    'c4aa4076ed67e2ced314c04f90d3fc2a': '4',
    'c79beea3a8c3de754c340138099a3e02': 'g',
    'cc884179ba2b8e5a2434d09b882cef0f': 'd',
    'd54b19971e9e3825ddfe17abe65644b8': 'y',
    'dafce80012f1da571e20790a88a00d04': 'b',
    'eb784ed3c9406d107ac91238a617536a': 'm',
    'f142a45d3b04b22c89ab08375ce9480c': 'e',
    'f5b4adb5d712b0eb96f652e82cbfd673': 'f'
}
```

Finally, I wrote some more Python to iterate through each .wav file/commit, compute the hash, and output the letter mapping to build the final string. This gave what I determined to be a backwards (since we were going from last commit to first) base32 string, which when decoded, gave a gunzipped archive. Reversing the string, converting the letters to uppercase, decoding the base32 string, and decompressing the archive gives us the final message and flag.  

```python
def translate():
    for filepath in sorted(glob.glob(os.path.join('snapshots/', '*.wav'))):
        with open(filepath, 'rb') as f:
            f_data = f.read()
            md5 = hashlib.md5(f_data).hexdigest()
            print(hashtable[md5], end='')
    print()
```

```
$ python hash.py | rev | tr '[:lower:]' '[:upper:]' | base32 -d | gunzip -d - | grep "sun{"
sun{XXXIII_THE_MONADOLOGY_is_a_nice_extra_read_no_flags_though}
```


