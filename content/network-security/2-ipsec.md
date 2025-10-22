---
title: Untitled
tags: []
draft: true
date: 2025-10-10
---
# IPSec

A suite of protocols to implement the following security hardenings:

* Data authentication (through an _Authentication Header_)
* Data integrity (through an _Authentication Header_)
* Data confidentiality (through an _Encapsulating Security Payload_, ESP)
* Replay protection (optionally both with _AH and ESP_)

The implementation can reside at multiple points in the communication:
* Host-to-Host (E2E) (not really common)
* Host-to-Router
* Router-to-Router (Virtual Private Networks)

And also in multiple modes:
* Transport mode: the IPSec header is added on top of the original IP header, and this last one is modified to inform that IPSec is in use
* Tunnel mode: same as above, but the original IP header is preserved on top of the IPSec header (sort of like a wrapper mode)