---
# Obsidian
tags:
- ctf
- 2021-damctf
- misc
- minecraft
- python

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-damctf
category: misc
title: library-of-babel
points: {{points}}
solved: true
---

# library-of-babel

## Instructions

Legend has it there is a secret somewhere in this library. Unfortunately, all of our Babel Fishes have gotten lost and the books are full of junk.

_Note: You do not need a copy of Minecraft to play this challenge._

The flag is in standard flag format.

[library-of-babel.zip](#)

## Prerequisites
Python `requirements.txt`:
```
NBT
```

## Solution

We are given what appears to be the world folder from a Minecraft save. We can use the NBT Python library to import the world save and parse through the data.

The challenge hints towards the fact that the information we are looking for is stored somewhere in a book within the Minecraft world save. My first approach was to look in player inventories and chests for written books, but I did not find any. My next tactic was to broaden the search and look through all tile entities in the world save. This came back with a large number of hoppers and lecterns being found.

```python
from nbt.world import WorldFolder
import os

def main(world_folder):
    world = WorldFolder(world_folder)
    find_tile_entities(world)

def find_tile_entities(world):
    for chunk in world.iter_nbt():
        for entity in chunk['Level']['TileEntities']:
            print(f"{entity['id']} at {entity['x']},{entity['y']},{entity['z']}")

if __name__ == "__main__":
    world_folder = os.path.normpath("world/")
    main(world_folder)
```

```bash
$ python -m nbt_scan
minecraft:lectern at -95,39,186
minecraft:lectern at -94,37,184
minecraft:lectern at -96,37,186
minecraft:hopper at -96,61,207
minecraft:hopper at -88,61,215
... (lots more)
```

Lecterns in Minecraft can hold written books and the NBT data for those books are stored within the lectern entity. Iterating through all the lecterns in the world and searching for the flag format gets us the flag.
```python
from nbt.world import WorldFolder
import os

def main(world_folder):
    world = WorldFolder(world_folder)
    search_lecterns(world)

def search_lecterns(world):
    for chunk in world.iter_nbt():
        for entity in chunk['Level']['TileEntities']:
            if entity['id'].value == 'minecraft:lectern':
                for page in entity['Book']['tag']['pages']:
                    if "dam{" in page.value:
                        print(page.value)

if __name__ == "__main__":
    world_folder = os.path.normpath("world/")
    main(world_folder)
```
```bash
$ python3 -m book-scan | grep -oE dam{[^}]*.
dam{b@B3l5-b@bBL3}
```

## Continued On


