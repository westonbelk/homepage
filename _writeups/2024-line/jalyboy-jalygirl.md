---
tags:
  - ctf
layout: ctf
type: problem
ctf: 2024-line
category: web
title: jalyboy-jalygirl
points: 100
solved: true
---

# jalyboy-jalygirl

## Instructions

It's almost spring. Do you like Java?

## Solution

Unlike the previous challenge, this one correctly checks for a signed JWT.

```java
@Controller

public class JwtController {

    public static final String ADMIN = "admin";
    public static final String GUEST = "guest";
    public static final String UNKNOWN = "unknown";
    public static final String FLAG = System.getenv("FLAG");
    KeyPair keyPair = Keys.keyPairFor(SignatureAlgorithm.ES256);

    @GetMapping("/")
    public String index(@RequestParam(required = false) String j, Model model) {
        String sub = UNKNOWN;
        String jwt_guest = Jwts.builder().setSubject(GUEST).signWith(keyPair.getPrivate()).compact();

        try {
            Jws<Claims> jwt = Jwts.parser().setSigningKey(keyPair.getPublic()).parseClaimsJws(j);
```

However, this application is vulnerable to a [physic signature attack](https://neilmadden.blog/2022/04/19/psychic-signatures-in-java/):

![](attachments/Pasted%20image%2020240325095140.png)
