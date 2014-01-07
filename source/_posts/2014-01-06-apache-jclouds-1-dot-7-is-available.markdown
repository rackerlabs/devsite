---
layout: post
title: "Apache jclouds 1.7 is available!"
date: 2014-01-06 20:40
comments: true
author: YOUR_NAME_HERE
published: false
categories: 
---
# Apache jclouds 1.7 is available! #

If you happen to use the cloud (and not necessarily just the Rackspace cloud) and Java together, you might have heard of [jclouds](http://jclouds.apache.org/documentation/gettingstarted/what-is-jclouds/), the open source cloud-agnostic SDK.

The fourth Apache release of jclouds is now available. This is also the first major version Apache release of jclouds. A full list of fixes and improvements can be found [here](https://issues.apache.org/jira/browse/JCLOUDS/fixforversion/12324405). Instead of going over the full list though, I would like to focus on some of the OpenStack and Rackspace-related new features in this release: Marconi, Auto Scale, and Neutron.

OpenStack Marconi is a distributed message-queuing service. On the Rackspace cloud, it is called Cloud Queues. Developers would find it useful for communicating between applications, parallel computing (such as data processing), and similar applications.

Auto Scale is currently a Rackspace project, but it is not a part of OpenStack yet. It allows developers to configure policies specifying how a compute cloud should shrink and grow.

OpenStack Neutron provides networking as a service. It allows developers to build advanced networking topologies and policies to specification.

Examples on using these technologies with jclouds can be found [here](https://github.com/jclouds/jclouds-examples/tree/master/rackspace). These examples will cover most common situations of working with the Rackspace cloud and jclouds. And to top that, jclouds is officially supported for use with the Rackspace cloud, which means we will help you resolve any issues you might encounter.

Because jclouds is an open-source project, none of these cool new features would have been made possible without our amazing  community. You can find us in #jclouds on [freenode](http://webchat.freenode.net/?channels=#jclouds).

Now, it is possible the specific technology you wanted jclouds to support was not made available in 1.7. In this case, we would be glad to help you contribute support for it! A good place to start is reading our [how-to](https://wiki.apache.org/jclouds/How%20to%20Contribute).
