---
title: Voter File Documentation Project?
author: chmullig
layout: post
permalink: /2011/03/voter-file-documentation-project/
categories:
  - Nerdery
  - politics
tags:
  - data
  - documentation
  - voter file
---
Political Data Nerds,

I&#8217;ve spent far, far too many hours of my life working with voter files. Every voter file sucks in its own unique way, and figuring out exactly how Montana sucks differently from Kansas is a unique and constant battle. Well, I&#8217;m tired of it! I don&#8217;t want to have to re-learn these challenges next time I work on a file, I don&#8217;t want to dig for the raw documentation (only to realize that it&#8217;s not always accurate).

I&#8217;m thinking of starting/contributing to a resource that consolidates *documentation* on all voter files out there. It wouldn&#8217;t be the data, it would just be freely available documentation to help anyone who&#8217;s already working with the data work with it more easily. What do you think?

I imagine it would have a list of vendors who provide these services as well, but the focus would be on helping anyone who&#8217;s trying to do it themselves. Probably should also have some more general tech recommendations, like how to concatenate files together, standardize addresses, geocode, etc.

Questions it would most definitely answer for every voter file (at least states, counties aren&#8217;t that important to me right now):

  * Where can I request this, and how much does it cost?
  * What format is it? CSV? Tab delimited text? Does it have a header? One file per county, or one per state?
  * How is vote history stored?
  * How do I translate from their geopolitical districts to something &#8220;standard?&#8221;
  * How do I translate from their counties to county FIPS codes?
  * What fields does it contain? Name? Address? Date of Birth? Phone? Party?
  * Mapping their vote history to some more global standard (for the common elections).

This wouldn&#8217;t be doing anything for you, but hopefully it would ease the pain of anyone having to work with raw voter files.

Pew&#8217;s <a title="Data For Democracy PDF" href="http://www.pewcenteronthestates.org/uploadedFiles/Final%20DfD.pdf" target="_blank">Data for Democracy report</a> is an excellent start. However it&#8217;s a static and higher level document. I&#8217;d like a living document that contains more concrete information, and can be easily updated.

Does anyone know of an existing project doing this that I could contribute to? If not, are there any platforms better than Mediawiki to use? I&#8217;d rather not spend a lot of time writing original code for this, but that might be inevitable if I don&#8217;t want to do a ton of copy/pasting in mediawiki (boy does Mediawiki suck, too)&#8230;