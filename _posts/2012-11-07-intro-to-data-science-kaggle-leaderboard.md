---
title: 'Intro to Data Science &#8211; Kaggle Leaderboard'
author: chmullig
layout: post
permalink: /2012/11/intro-to-data-science-kaggle-leaderboard/
categories:
  - Nerdery
  - School
tags:
  - Columbia
  - data science
  - graphing
  - kaggle
  - r
---
This semester I&#8217;m auditing Rachel Schutt&#8217;s [Intro to Data Science class][1]. I originally registered for it, but at the end of the add/drop period decided I wasn&#8217;t confident in my academic background, and wasn&#8217;t sure about the workload that would be required. In retrospect it was a mistake to drop it. However I have been attending class as I can (about half the time).

The final project, accounting for most of the grade, is a [Kaggle competition][2]. It&#8217;s based on an earlier competition, and the goal is to develop a model to grade standardized test essays (approximately middle school level). As an auditor Rachel asked me not to submit, but my cross-validation suggests my model (linear regressions with some neat NLP derived features) is still besting the public leaderboard (Quadratic Weighted Kappa Error Measure of .75), but who knows.

I thought I could easily adjust my [MITRE competition leaderboard graph][3] to Kaggle&#8217;s CSV, and it turned out to be pretty easy. The biggest issue ended up being that MITRE scored 0 to 100, and this scores 0 to 1. That had some unintended consequences. launchd + python + R should upload this every hour or so (when my laptop is running).

I&#8217;m frankly surprised Kaggle hasn&#8217;t done something like this before. Maybe if I have a bored evening I&#8217;ll try to do it in [D3][4], which should look much nicer.

[<img class="alignnone size-full wp-image-496" title="Data Science Inclass Kaggle Leaderboard" alt="" src="http://chmullig.com/wp-content/uploads/2012/11/datascience_leaderboard.png" width="100%" />][5]

&nbsp;

Update, 12/16: I&#8217;ve [posted a followup][6] after the end of the semester.

 [1]: http://columbiadatascience.com
 [2]: http://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012
 [3]: http://chmullig.com/2011/02/mitre-challenge-graph/ "MITRE Challenge Graph"
 [4]: http://d3js.org/
 [5]: http://chmullig.com/wp-content/uploads/2012/11/datascience_leaderboard.png
 [6]: http://chmullig.com/2012/12/intro-data-sciencekaggle-update/ "Intro Data Science/Kaggle update"