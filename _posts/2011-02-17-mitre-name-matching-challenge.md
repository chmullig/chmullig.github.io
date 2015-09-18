---
title: MITRE Name Matching Challenge
author: chmullig
layout: post
permalink: /2011/02/mitre-name-matching-challenge/
categories:
  - Nerdery
tags:
  - programming
  - python
  - work
---
My illustrious former colleague Ryan is now over at MITRE doing operations research and who knows what. He pointed me toward the [MITRE Challenge][1].

> The MITRE Challenge™ is an ongoing, open competition to encourage innovation in technologies of interest to the federal government. The current competition involves multicultural person name matching, a technology whose uses include vetting persons against a watchlist (for screening, credentialing, and other purposes) and merging or deduplication of records in databases. Person name matching can also be used to improve document searches, social network analysis, and other tasks in which the same person might be referred to by multiple versions or spellings of a name.

Basically they give you a small list of target names, and a ginormous list of candidate names, and for each target name you return up to 500 possible matches from the candidate name list. Currently the matching software we built at Polimetrix back in 2005-2007 is doing pretty well. It was designed for full voter records, but I broke out the name component by itself. The result is pretty awesome. Currently we&#8217;re ranked #1 at 72.038. Below us are a few teams, including Intaka at 68.801 and Beethoven at 58.501.

 [1]: mitrechallenge.mitre.org/NameMatching