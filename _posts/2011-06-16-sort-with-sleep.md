---
title: Sort with sleep
author: chmullig
layout: post
permalink: /2011/06/sort-with-sleep/
categories:
  - Nerdery
tags:
  - programming
  - sleep
  - sort
---
Inspired by an [Ars thread][1] that was inspired by a [4chan thread][2] found on reddit, it&#8217;s an interesting sort idea for integers.

Basically, sort a list of integers by spawning a new thread or process for each element then sleep for the value of that element then print out that element. Here&#8217;s the original bash example, but I&#8217;d love to see other crazy languages.

<pre>#!/bin/bash
function f() {
    sleep "$1"
    echo "$1"
}
while [ -n "$1" ]
do
    f "$1" &
    shift
done
wait</pre>

 [1]: http://arstechnica.com/civis/viewtopic.php?f=20&t=1147843
 [2]: http://dis.4chan.org/read/prog/1295544154