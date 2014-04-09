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

For most boxes, upgrading is as simple as using your package manager. Most distributions got the patch in their repositories as quickly as possible.

## Debian/Ubuntu
```
sudo apt-get update
sudo apt-get upgrade
```

or

## RHEL/CentOS/Fedora
```
yum -y update openssl
```

If you're using DevOps tools, there's another path to take

## SaltStack

```
salt \* pkg.install openssl refresh=True
```

## Chef

```

```


Even after your upgrade, make sure you don't have any processes with the old OpenSSL still running. Either restart services, kill the processes, or reboot the box.

To find them, use this command to list open files with ssl in the name where the file is marked as deleted or comes up as "No such file".

```
lsof -n | grep ssl | grep -P '(DEL|No such)'
```

# Change your passwords

Because anyone could have scraped your credentials from a compromised server, it's important to reset all of your passwords and API keys as soon as you can confirm that the service has been patched.

To do this for your Rackspace account, log in to [the MyCloud portal](https://mycloud.rackspace.com/) and click on your account name in the upper-right of the screen:

![account menu](account-settings.png)

On the account settings page, click the pencil icon to change your password, and use the "Reset..." link to generate a new API key:

![reset links](reset.png)

# Regenerate your SSH keys

Since the vulnerability is bidirectional, malicious servers can read memory from vulnerable clients, too. For this reason, you should consider any private SSH keys compromised, and [generate new ones](https://help.github.com/articles/generating-ssh-keys).
