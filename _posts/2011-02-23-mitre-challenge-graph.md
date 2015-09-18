---
title: MITRE Challenge Graph
author: chmullig
layout: post
permalink: /2011/02/mitre-challenge-graph/
categories:
  - Nerdery
tags:
  - graph
  - matching
  - mitre
  - python
  - r
---
For my own curiosity I created a python + R script to grab the MITRE leaderboard and graph it. It&#8217;s a [bit of python][1] to grab the leaderboard and write out some CSVs. Then a bit of <strike>[R code][2]</strike> (updated link: <http://a.libpa.st/4KFGq>) generates the graph. It&#8217;s running automatically with launchd on my laptop, and it should be regularly uploading a png to the address below. Launchd is pretty awesome, but a royal pain in the ass to get set up. It doesn&#8217;t feel very deterministic.

I still need to figure out how to jitter the names so they don&#8217;t overlap (like YouGov & Agent Smith), but other than that I thought it was a nifty little exercise.

<div style="width: 590px" class="wp-caption alignnone">
  <img title="Leader Board Graphed over time" src="http://chmullig.com/mitre_leaderboard.png" alt="" width="580" height="580" />
  
  <p class="wp-caption-text">
    Each line is a team, with their best MAP scores as datapoints
  </p>
</div>

 [1]: http://a.libpa.st/Wor48
 [2]: http://a.libpa.st/0_3Kh