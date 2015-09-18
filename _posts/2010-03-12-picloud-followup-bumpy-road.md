---
title: 'PiCloud followup&#8230; bumpy road'
author: chmullig
layout: post
permalink: /2010/03/picloud-followup-bumpy-road/
categories:
  - Nerdery
tags:
  - data
  - picloud
  - python
---
I had to crunch some data today, and decided to experiment a bit. It mostly involved lots and lots of Levenshtein ratios. On my laptop it took over 25 minutes to complete a single run (45k rows, several thousand calculations per row) &#8211; a bummer when you want to quickly iterate the rules, cutoffs, penalties, etc. First step was simply cutting out some work that was a nice-to-have. That got me down to 16 minutes.

Second was adding multiprocessing. I figured this would be easy, but the way I originally wrote the code (the function required both an element, and a penalty matrix) meant that just plain multiprocessing.Pool.map() wasn&#8217;t working. I wrapped it up with itertools.izip(iterator, itertools.repeat(matrix)), but that gives a tuple which you can&#8217;t easily export. It turns out that this, basically [calculatorstar][1] from the Pool example, is a godsend:

<pre>def wrapper(args):
    return func(*args)
</pre>

So that got me down to 8 minutes on my laptop. However the cool part is that on an 8 core server I was down to only 1 minute, 30 seconds. Those are the sorts of iteration times I can deal with.

Then I decided to try the [PiCloud][2]. After [trying it out ][3]earlier this week I thought it would be interesting to test it on a real problem that linearly scales with more cores.  They advertise it in the docs, so I figured maybe it would be useful and even faster. Not so fast. It was easy to write after I already had multiprocessing working, but the first version literally crashed my laptop. I later figured out that the &#8220;naive&#8221; way to write it made it suck up all the RAM on the system. After less than 5 minutes I killed it with 1.7GB/2GB consumed. Running it on the aforementioned 8 core/32GB server had it consume 5GB before it finally crashed with a HTTP 500 error. I [posted][4] in the forums, got some advice, but still can&#8217;t get it working. (Read that short thread for the rest of the story). This seems like exactly what they should be nailing, but so far they&#8217;re coming up empty.

 [1]: http://docs.python.org/library/multiprocessing.html#examples
 [2]: http://picloud.com
 [3]: 2010/03/picloud-introduction
 [4]: http://support.picloud.com/entries/126939-cloud-map-using-huge-amounts-of-memory-failing