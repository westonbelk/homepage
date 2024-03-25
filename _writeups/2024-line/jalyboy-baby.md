---
tags:
  - ctf
layout: ctf
type: problem
ctf: 2024-line
category: web
title: jalyboy-baby
points: 100
solved: true
---

# jalyboy-baby

## Instructions

It's almost spring. I like spring, but I don't like hay fever.

http://localhost:10000
## Solution

Navigating to the website and clicking "login as guest" provides a JWT in the query string.

![](attachments/Pasted%20image%2020240325091043.png)

Since we were provided source code with this challenge we can see that the JWT is being parsed using the `.parse(String jwt)` method which parses the JWT string and returns the resulting JWT or JWS instance. Since this method will accept both signed and unsigned JWTs, we can just provide an unsigned token.

```java
@Controller                             
public class JwtController {

    public static final String ADMIN = "admin"; 
    public static final String GUEST = "guest"; 
    public static final String UNKNOWN = "unknown";
    public static final String FLAG = System.getenv("FLAG");
    Key secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    @GetMapping("/")
    public String index(@RequestParam(required = false) String j, Model model) {
        String sub = UNKNOWN;
        String jwt_guest = Jwts.builder().setSubject(GUEST).signWith(secretKey).compact();

        try {
            Jwt jwt = Jwts.parser().setSigningKey(secretKey).parse(j);
```

![](attachments/Pasted%20image%2020240325094212.png)

![](attachments/Pasted%20image%2020240325094331.png)
