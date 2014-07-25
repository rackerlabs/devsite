---
layout: post
title: "ApacheCon Recap"
date: 2014-04-11 21:10
comments: true
author: Zack Shoylev
published: true
categories: 
---
# ApacheCon Recap #

If you are into open-source you might have heard that ApacheCon was held earlier this April in Denver. The venue was packed, ambiance was great, and the topics relevant - which would be the important part.

{% img center /images/2014-04-11-apachecon/common_space.jpg Break %}

{% img center /images/2014-04-11-apachecon/nice_ambiance.jpg Ambiance %}

{% img center /images/2014-04-11-apachecon/food_trucks.jpg Food %}

Everett Toews (@everett_toews) presented an intro to #jclouds (the provider-agnostic, portable, open-source Java cloud SDK). He also had a talk on how improved and awesome the jclouds documentation process is now. Walk-up contributions are easy and welcome thanks to a combination of both GitHub (markdown editing) and Apache tools with testing on CloudBees - a process that should be easily adoptable by other OS projects.

{% img center /images/2014-04-11-apachecon/everett_intro.jpg Intro %}

I presented a talk on the current status of database support in jclouds, with emphasis  on OpenStack Trove. So we had a total of three jclouds-related talks!

Here are some more bad quality photos from among other interesting projects that I got up-to-date on:

1. Phoenix - SQL-izes HBASE (also has a bunch of query optimizations). 
{% img center /images/2014-04-11-apachecon/phoenix_sqlizing.jpg Phoenix %}

2. DataFu - UDFs for Pig. If you are a data scientist, this project will contain a lot of goodies for you. 
{% img center /images/2014-04-11-apachecon/pig_datascience.jpg DataFu %}
{% img center /images/2014-04-11-apachecon/pig_datafu.jpg DataFu %}

3. Yarn. Part of the Hadoop ecosystem, uses containers to manage resources. 
{% img center /images/2014-04-11-apachecon/helix_talk.jpg Helix %}
{% img center /images/2014-04-11-apachecon/more_yarn.jpg Yarn %}

4. Giraph. If you already have a hadoop cluster and want to do graph processing, this is the project for you. Interestingly enough, running it on Yarn was not recommended (though it is supported).
{% img center /images/2014-04-11-apachecon/giraph.jpg Giraph %}
