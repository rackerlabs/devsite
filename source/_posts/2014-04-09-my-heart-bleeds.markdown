---
layout: post
title: "My Heart Bleeds for You"
date: 2014-04-09 10:45
comments: true
author: Kyle Kelley
published: false
categories:
 - Security
 - HeartBleed
---

![My heart bleeds](http://heartbleed.com/heartbleed.png)

If you haven't already heard about [HeartBleed](http://heartbleed.com/), it's about time you read about it and upgrade the OpenSSL version on your box(es). **This should be done regardless of whether you're using SSL/TLS currently**, in case you *deploy a service later*. This affects OpenSSL 1.0.1 through 1.0.1f (inclusive), and the relevant patch is in 1.0.1g.

# Upgrade your servers

For most boxes, upgrading is as simple as running `apt-get update && apt-get upgrade` or `yum -y update openssl` as most distributions got the patch in the repositories as quickly as possible.

Even after your upgrade, make sure you don't have any processes with the old OpenSSL still running. Either restart services, kill the processes, or reboot the box.

To find them, use this command to list open files with ssl in the name where the file is marked as deleted or comes up as "No such file".

```
lsof -n | grep ssl | grep -P '(DEL|No such)'
```

Make sure you revoke your certificates.
