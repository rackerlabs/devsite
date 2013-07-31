---
layout: post
title: "How BuiltLean Survived the Front Page of Reddit"
date: 2013-07-26 10:49
comments: true
author: Alexander Baldwin
published: false
categories: 
---

{% img right /images/2013-07-26-how-builtlean-survived-the-front-page-of-reddit/builtlean.png %}

It was February 14th and [BuiltLean](http://www.builtlean.com/) was about to have the biggest traffic day in its 2 year existence. A post on [posture problems that develop from office work](http://www.builtlean.com/2011/11/28/posture-problems/) was submitted to the [LifeProTips](http://www.reddit.com/r/LifeProTips/comments/18ilo9/lpt_you_should_know_how_office_chairs_negatively/) subreddit at 10 AM eastern time. Within the first hour, it had garnered 500 upvotes and 35 comments; by the second, it reached over 1000 upvotes and had hit the front page.<!--More-->

Previously, we had survived hitting the front page twice on Digg, largely in part because we had hit during off-peak hours. But it was a Thursday at noon and there was no avoiding a lot of traffic arriving at once from Reddit.

Like the once fabled “Digg Effect”, Reddit has the ability to send a tremendous amount of traffic. What makes this type of traffic especially difficult to handle is the rapidity and frequency in which it arrives, with it often resembling a small-scale DDoS attack. We were prepared for a hundred thousand hits in a day but we weren't prepared for a hundred thousand hits in an hour.

BuiltLean had a pretty simple set-up that was optimized completely on the CMS side: our HTML, JavaScript, and CSS files were minimized and compressed; all PHP scripts and pages were cached; and most elements of the site were served through our CDN. However, we had two significant blind-spots, which were a lack of HTTP accelerator and a server set-up that was woefully underpowered to handle such a traffic surge.

Luckily through active monitoring of our referral traffic, we spotted the Reddit submission within the first hour. When we knew we weren't ready for what was potentially about to happen, we called up RackSpace support, who quickly diagnosed the situation and prescribed an upgrade of our database server and the temporary addition of a second server with a load balancer to distribute requests between our two servers. Within 20 minutes, both had been implemented, almost simultaneously with our post hitting the front page of Reddit.

Thanks to Rackspace's swift deployment, we were largely able to absorb the amount of traffic sent from Reddit. All told, we received over 125 thousand visitors from Reddit, 60 thousand of which came between 12 PM to 2 PM. But the on-the-fly adjustments that had been made weren't a long-term fix for the underlying issues and we wanted to be ready in case something similar happened again.

Going forward in collaboration with RackSpace’s support staff, we made two substantial changes:

1. We added Varnish, a HTTP accelerator that greatly reduces the time in which pages are served. When we did have errors during the Reddit traffic surge, it was largely due to maxed out simultaneous connections in Apache that was exacerbated by the slow distribution of the page requested.

2. We permanently added a second server with a load balancer that acted on-demand during our most trafficked hours and which we could activate when situations demanded it.
We're happy to report that with the above implemented and constant refinements done to BuiltLean’s WordPress configuration, page speed has greatly improved across the board as well server stability. Akin to the saying "dress for the job you want, not the job you have", our takeaway was to always be prepared for the traffic we wanted.

This guest post was written by Alexander Baldwin of [BuiltLean](http://www.builtlean.com/), a Rackspace customer. BuiltLean is a fitness resource for busy professionals who want to get lean and stay lean with time-efficient workouts. The company provides free medically-reviewed articles and videos accessed by over 1 million visitors per month alongside an 8-week fitness program used by customers in over 90 countries.

