---
layout: post
title: "Cloud Monitoring Announces Suppressions"
date: 2014-03-31 13:37
comments: true
author: Justin Gallardo
published: false
categories:
 - Cloud Monitoring
---

Above all, Cloud Monitoring has the goal of making sure that when something goes wrong we are the first to know, and the first to let you know. As your app grows, it becomes more critical that every monitoring notification you get is actionable. If it isn't something you can take action on, it ends up taking time away from what really matters. Because of this tenet we've realized that not only is it important to create actionable alerts, but also to have the ability to let the monitoring system know if any of those alerts *won't* be actionable for a period of time.

Today the Cloud Monitoring team is excited to announce suppressions. Suppressions add the ability to schedule a time wherein a specified set of notifications will be muted. A common use case for this is silencing alerts during a scheduled maintenance period when some downtime is expected so that you can focus on what matters, and not worry about all of the notifications you are receiving for things that you are already fixing.

<!--more-->

Creating a suppression consists of specifying a set of suppression targets, a start time, and an end time. While a suppression is active, any notifications triggered associated with the specifiied targets will not be sent, and instead a suppression log will be created. The suppression log contains important information about the notification that would have been sent. This means that you always have full visibility into what is happening. Once the suppression expires, notifications will resume as expected.

Much like how careful we are when we send notifications to you, we wanted to be sure to provide a way for you to be just as careful when choosing which notifications to not receive. There are 4 types of targets that you can specify:

 * notification plans - A notification plan tells an alarm how to notify you when its state changes.
 * entities - An entity represents a collection of monitoring checks. Most of the time this correlates to a single server.
 * checks - Checks are what actually run and generate metrics so that we can make decisions about the health of your system.
 * alarms - Alarms let us know how to respond to the metrics gathered by checks, and how to let you know what we decide.

Unlike notification plan targets, the entity, alarm, and check targets are combined so that they expand the scope of the suppression. The resulting filter will be the union of these three targets. If a notification plan's target is specified in addition to the other targets, the scope of the suppression is limited to notifications that match those targets *and* the given notification plan. This expression shows how the suppression filter is created:
 
`suppressionFilter = (entities || checks || alarms) && notification plans`

You can use [raxmon](https://github.com/racker/rackspace-monitoring-cli), our command line tool, to work with suppressions. Lets imagine that we are planning a scheduled maintenance period for 30 minutes to upgrade the kernel on one of our servers in order to get a critical security patch. The following creates a suppression to silence all of the notifications that would be sent when we restart the server:

```
$ raxmon-entities-list |grep milfred
<Entity: id=enCXUIFSeh label=milfred provider=Rackspace Monitoring ...>

$ raxmon-suppressions-create --entities=enCXUIFSeh --start-time=1413865800000 --end-time=1413867600000
Resource created. ID: spn7QiWAVB
```

While the server is offline to boot into the newly installed kernel, the [ping check](http://docs.rackspace.com/cm/api/v1.0/cm-devguide/content/appendix-check-types-remote.html#section-ct-remote.ping) will become unreachable and decide to send a notification. Instead of getting an email, a new suppression log will be created. 

```
$ raxmon-suppression-logs-list
<SuppressionLog: id=c756bb30-a57a-11e3-b3c9-9ad9721a84e2, entity=enCXUIFSeh, alarm=alBZ6EsFWu, check=chIJi3dHLw, state=CRITICAL, timestamp=1413865804353>
<SuppressionLog: id=321c3a50-abc3-11e3-9f45-731553f753b0, entity=enCXUIFSeh, alarm=alBZ6EsFWu, check=chIJi3dHLw, state=OK, timestamp=1413865913420>

Total: 2
```

You can think of these suppression logs as the "paper trail" of suppressed notifications. We feel it is very important to ensure that at any time you will know exactly what happened when, and why you did or did not hear about it.

You can read more about suppressions and how they are used in our [API documentation](http://docs.rackspace.com/cm/api/v1.0/cm-devguide/content/overview.html).

Over the years we have seen some [creative](http://developer.rackspace.com/blog/using-rackspace-cloud-monitoring-to-help-reduce-food-waste.html) uses of Cloud Monitoring so we are very excited to see people use suppressions in ways that we’ve never thought of. When it comes down to it, the most important thing to us is to deliver a tool that makes it easier for you to build awesome things, and sleep easily knowing that someone is looking out for you and your app. We hope the addition of suppressions makes running your applications a little bit easier.

Happy monitoring!
