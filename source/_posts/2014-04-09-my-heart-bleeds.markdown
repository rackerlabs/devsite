---
layout: post
title: "My Heart Bleeds for You"
date: 2014-04-09 10:45
comments: true
author: Kyle Kelley, Hart Hoover, and Ash Wilson
published: false
categories:
 - Security
 - Heartbleed
---

{% img /images/2014-04-09-my-heart-bleeds/heartbleed.png 'Bleeding Heart' 'My heart bleeds for you' %}

If you haven't already heard about [Heartbleed](http://heartbleed.com/), it's time you read about it and upgrade the OpenSSL version on your box(es). **This should be done regardless of whether you're using SSL/TLS currently**, in case you *deploy a service later*. This affects OpenSSL 1.0.1 through 1.0.1f (inclusive), and the relevant patch is in 1.0.1g.

# Upgrade your servers

For most servers, upgrading is as simple as using your package manager. Most distributions got the patch in their repositories as quickly as possible.

## Command line upgrades

### Debian/Ubuntu
```
sudo apt-get update
sudo apt-get upgrade
```

### RHEL/CentOS/Fedora
```
yum -y update openssl libssl1.0.0
```

## DevOps Tools

If you're using DevOps tools, there's another path to take

### Ansible

Ansible has their own article on [fixing heartbleed with Ansible](http://www.ansible.com/blog/fixing-heartbleed-with-ansible), but here's a snippet from a play by [@carsongee](https://github.com/carsongee):

```yaml
---
# Patch openssl+libssl
- name: "Install packages and update cache"
  apt: pkg="{{ item }}" state=latest update_cache=yes
  with_items:
    - libssl1.0.0
    - openssl
```

The full play has some other neat goodies including restarting known affected services and checking that we don't have other affected processes running. Check the [whole gist](https://gist.github.com/carsongee/10137729) out to see a really great play.

### SaltStack

```bash
$ salt \* pkg.install openssl refresh=True
```

### Chef

Using knife:
```bash
$ knife ssh -a ipaddress "chef_environment:*" "sudo apt-get update && sudo apt-get install openssl"
```

Alternatively, you can add this to your recipes, taking care to restart services:

```ruby
%w{ openssl libssl1.0.0 }.each do |pkg|
  package pkg do
    action :upgrade
    notifies :reload, "service[SERVICE]", :delayed
  end
end
```

If you are using configuration management and the cloud, you may want to deploy new instances, swapping them into load balancer pools and such as needed.

## After the upgrade, restart services

Even after your upgrade, make sure you don't have any processes with the old OpenSSL still running. Either restart services, kill the processes, or reboot the box.

To find them, use this command to list open files with ssl in the name where the file is marked as deleted or comes up as "No such file".

```bash
lsof -n | grep ssl | grep -P '(DEL|No such)'
```

# Protect your users, protect yourself

The biggest concern out of Heartbleed is the potential leakage of credentials from your users.

We're talking about

* Passwords
* OAuth Tokens
* API Keys
* Session cookies

For your users' sake, force them to change these credentials on your web services and expire their previous sessions. Any attacker that went after your system prior to your upgrade could have stolen data.

That also includes *your* API keys. For the sake of safety, we highly recommend doing this with your Rackspace account as well.

## Change your Rackspace password + API Keys

Because anyone could have scraped your credentials from a compromised server, it's important to reset all of your passwords and API keys as soon as you can confirm that the service has been patched.

To do this for your Rackspace account, log in to [the MyCloud portal](https://mycloud.rackspace.com/) and click on your account name in the upper-right of the screen:

{% img /images/2014-04-09-my-heart-bleeds/account-settings.png 'Account Settings' 'Username to Account Settings in the upper right' %}

On the account settings page, click the pencil icon to change your password, and use the "Reset..." link to generate a new API key:

{% img /images/2014-04-09-my-heart-bleeds/reset.png 'Reset password and API Key' 'Reset password and API Key' %}

# Relax

Take a deep breath. Pat yourself on the back for helping to protect your users and the internet. You need it.

If you weren't the one to patch systems, go thank your Ops folks. Major props to Heartbleed for completely viral marketing that made people patch fast.

This whole incident should teach us all how much of the web relies on open source and how we need to continue to support it for years to come. This confirms our [resolution to support open source and open source development](http://www.rackspace.com/blog/rackspaces-policy-on-contributing-to-open-source/).
