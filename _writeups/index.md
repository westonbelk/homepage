---
layout: default

# CTF info
title: CTF Writeups
hero-title: CTF Writeups
hero-text: 
---

{% assign events = site.writeups | where: "type", "homepage" %}

{% for event in events  %}

## {{event.title}}
[Writeups]({{event.url}})

{% endfor %}
