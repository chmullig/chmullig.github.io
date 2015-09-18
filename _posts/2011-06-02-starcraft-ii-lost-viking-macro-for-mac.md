---
title: 'Starcraft II: Lost Viking &#8220;macro&#8221; for mac'
author: chmullig
layout: post
permalink: /2011/06/starcraft-ii-lost-viking-macro-for-mac/
categories:
  - Gaming
tags:
  - gaming
  - programming
  - starcraft 2
  - starcraft II
---
So Stracraft II is a fantastic game, and includes achievements. I&#8217;ve turned into a bit of a SC2 achievement whore (Currently: [3350][1]). I long ago completed every achievement in the single player campaign except 4: [The Lost Viking][2]. It&#8217;s a stupid arcade game within the game! It doesn&#8217;t matter at all! Yet I was tantalizingly close to 100%, so finally I decided to tackle it.

First, you can read all sorts of strategies. Basically they come down to this: immediately get 2 side missiles, then get 2 drones. Whenever you loose a drone, replace it first chance you get. Then everything else should be bombs. (Any drop goes through a sequence, so wait until it&#8217;s the one you want). Use bombs liberally to prevent death and loss of drones. They make you invincible for a few seconds, in addition to clearly crap away. You&#8217;ll have basically all the bombs you need. Press space as fast as you can to shoot faster.

So it&#8217;s mostly a question of staying alive, and keeping your drones alive. Except for the bosses/mini bosses there&#8217;s not a ton of strategy. After a few attempts yesterday I beat it once, then hit 245k points, then 279k points (getting Silver). That only left gold (500k points), and I didn&#8217;t have the energy. However I knew there was a macro on the Windows side to hit space for you. In that case all you&#8217;d have to do is navigate around, which isn&#8217;t too hard. A few attempts to track one down on the Mac failed. Mac OS X is nice, but it definitely lacks some of the rom emulation tools so popular on Windows. I wanted an OS X program to simply pres the space bar over and over and over again forever, quickly, while not interfering with the rest of the system. It was useless if I couldn&#8217;t 

However I figured there must be a better option, perhaps Objective-C? My Obj-C is super rusty, but I stumbled across a StackOverflow hint suggesting how easy it would be to do in plain C. Here&#8217;s the C program I wrote that uses CG Quartz Events to simulate pressing the space bar every .05 seconds (In retrospect that&#8217;s probably way faster than it needs, could probably easily be .1 seconds).

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="c" style="font-family:monospace;"><span style="color: #339933;">#include &lt;stdio.h&gt;</span>
<span style="color: #339933;">#include &lt;ApplicationServices/ApplicationServices.h&gt;</span>
<span style="color: #339933;">#include &lt;unistd.h&gt;</span>
&nbsp;
<span style="color: #993333;">int</span> main <span style="color: #009900;">&#40;</span><span style="color: #993333;">int</span> argc<span style="color: #339933;">,</span> <span style="color: #993333;">const</span> <span style="color: #993333;">char</span> <span style="color: #339933;">*</span> argv<span style="color: #009900;">&#91;</span><span style="color: #009900;">&#93;</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span>
    CGEventRef spaceDown <span style="color: #339933;">=</span> CGEventCreateKeyboardEvent <span style="color: #009900;">&#40;</span>NULL<span style="color: #339933;">,</span> <span style="color: #009900;">&#40;</span>CGKeyCode<span style="color: #009900;">&#41;</span><span style="color: #0000dd;">49</span><span style="color: #339933;">,</span> <span style="color: #000000; font-weight: bold;">true</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    CGEventRef spaceUp <span style="color: #339933;">=</span> CGEventCreateKeyboardEvent <span style="color: #009900;">&#40;</span>NULL<span style="color: #339933;">,</span> <span style="color: #009900;">&#40;</span>CGKeyCode<span style="color: #009900;">&#41;</span><span style="color: #0000dd;">49</span><span style="color: #339933;">,</span> <span style="color: #000000; font-weight: bold;">false</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #993333;">int</span> sleepTime <span style="color: #339933;">=</span> <span style="color: #0000dd;">50000</span><span style="color: #339933;">;</span>
    <span style="color: #000066;">printf</span><span style="color: #009900;">&#40;</span><span style="color: #ff0000;">"Pressing space every %d microseconds<span style="color: #000099; font-weight: bold;">\n</span>"</span><span style="color: #339933;">,</span> sleepTime<span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    sleep<span style="color: #009900;">&#40;</span><span style="color: #0000dd;">2</span><span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
&nbsp;
    <span style="color: #b1b100;">while</span> <span style="color: #009900;">&#40;</span><span style="color: #0000dd;">1</span><span style="color: #009900;">&#41;</span> <span style="color: #009900;">&#123;</span>
        CGEventPost<span style="color: #009900;">&#40;</span>kCGHIDEventTap<span style="color: #339933;">,</span> spaceDown<span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
        CGEventPost<span style="color: #009900;">&#40;</span>kCGHIDEventTap<span style="color: #339933;">,</span> spaceUp<span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
        usleep<span style="color: #009900;">&#40;</span>sleepTime<span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #009900;">&#125;</span>
&nbsp;
    CFRelease<span style="color: #009900;">&#40;</span>spaceDown<span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    CFRelease<span style="color: #009900;">&#40;</span>spaceUp<span style="color: #009900;">&#41;</span><span style="color: #339933;">;</span>
    <span style="color: #b1b100;">return</span> <span style="color: #0000dd;"></span><span style="color: #339933;">;</span>
<span style="color: #009900;">&#125;</span></pre>
      </td>
    </tr>
  </table>
</div>

It can be copied to a file like &#8220;cstroker.c&#8221; and compiled with this gcc command (you may need to install Xcode if you don&#8217;t already have it) from Terminal.app: 

<pre>gcc -o cstroker cstroker.c -O -Wall -framework ApplicationServices</pre>

You then execute it by simply calling ./cstroker

Update: Because some folks asked I&#8217;ve [uploaded the binary][3]. Might work for you, in which case you can skip the gcc compilation. 

<div id="attachment_361" style="width: 310px" class="wp-caption alignnone">
  <a href="http://chmullig.com/wp-content/uploads/2011/06/Lost-Viking-Gold.png"><img src="http://chmullig.com/wp-content/uploads/2011/06/Lost-Viking-Gold-300x179.png" alt="" title="Lost Viking Gold" width="300" height="179" class="size-medium wp-image-361" /></a>
  
  <p class="wp-caption-text">
    Finally nailed Lost Viking Gold!
  </p>
</div>

 [1]: us.battle.net/sc2/en/profile/463552/1/chmullig/achievements/ "My battle.net profile"
 [2]: http://wiki.teamliquid.net/starcraft2/Lost_Viking
 [3]: http://chmullig.com/wp-content/uploads/2011/06/cstroker