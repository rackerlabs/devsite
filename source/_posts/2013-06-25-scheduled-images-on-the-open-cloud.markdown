---
layout: post
title: "Scheduled Images On The Open Cloud"
date: 2013-06-25 08:58
comments: true
author: Brian Rosmaita
published: false
categories: Cloud Servers
---

So there's this First Gen feature called "backup schedules", you may
have heard of it.  A lot of people liked it so much that they told us
they didn't want to move to the Rackspace open cloud until we built
something like it there.  So we did.  We're calling this feature
"Scheduled Images", here's how it works.

First, what this feature does is take a daily snapshot of your server
without any intervention by you.  So whether the resulting image is a
backup depends on what you've got going on in your server.  As you
know, for instance, with some RDBMS software, simply copying the files
underlying a running database and restoring those files is not a good
idea if you want a working database.  So this feature may not be
suitable for all backup scenarios.

Second, about the scheduling.  With this feature, the image is
scheduled by us, and we don't tell you when since it's subject to
change at any time.  The reason for this is that we don't want
automatic snapshots to interfere with normal cloud image operations or
adversely affect throughput througout the cloud.  We can spread out
the load more equitably and increase the probability of scheduled
images being taken successfully if we make the schedule ourselves.

Third, there is one configuration option, the "retention" value.  It's
the number of scheduled images that will be retained in your account.
When a new automatic snapshot has been taken successfully, the
scheduled images service will remove the oldest scheduled images until
the retention value is reached.  The retention value can be
independently set for each of your servers.

Finally, there's no charge for using the scheduled images service--you
simply pay for the storage of your scheduled images at the same rate
you pay for storing your regular snapshots.

Scheduled images can be activated for any of your servers by using the
Cloud Control Panel, the Cloud Servers API (with the Rackspace
Scheduled Images Extension), or by using the python-novaclient (with
the Rackspace Scheduled Images Novaclient extension).  As you can tell
from the discussion above, it's a very simple feature to understand and
use.  The following links tell you pretty much everything you need to
know to use it.

For more information:

*  [Rackspace Scheduled Images API Extension documentation](http://docs.rackspace.com/servers/api/v2/cs-devguide/content/ch_extensions.html#scheduled_images)
*  [Using the python-novaclient to manage scheduled images](http://www.rackspace.com/knowledge_center/article/using-python-novaclient-to-manage-scheduled-images)
*  [The Scheduled Images FAQ](http://www.rackspace.com/knowledge_center/article/scheduled-images-faq)
