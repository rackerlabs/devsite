---
layout: post
title: "My Heart Bleeds for You"
date: 2014-04-09 10:45
comments: true
author: Kyle Kelley & Hart Hoover
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

To run these commands using knife:
```
knife ssh -a ipaddress "chef_environment:*" "sudo apt-get update && sudo apt-get install openssl"
```

Alternatively, you can add this to your recipes, taking care to restart services:

```
package ‘openssl’ do
  action :upgrade
  notifies :reload, "service[SERVICE]", :delayed
end
```

If you are using configuration management and the cloud, you may want to deploy new instances, swapping them into load balancer pools and such as needed.

Even after your upgrade, make sure you don't have any processes with the old OpenSSL still running. Either restart services, kill the processes, or reboot the box.

To find them, use this command to list open files with ssl in the name where the file is marked as deleted or comes up as "No such file".

```
lsof -n | grep ssl | grep -P '(DEL|No such)'
```

Make sure you revoke your certificates.
