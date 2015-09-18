---
title: 'pmxbot command: lunch!'
author: chmullig
layout: post
permalink: /2010/05/pmxbot-command-lunch/
categories:
  - Nerdery
tags:
  - pmxbot
  - python
---
As everyone is well aware, lunch is the most important part of the work day. However it&#8217;s often [hard][1] to find [inspiration][2] when deciding on a delectable dining destination. The ideal solution is to have someone propose options, and everyone reject them until consensus is reached. However nobody enjoys that. Computers can [propose options][3], but that&#8217;s less social.

pmxbot has an existing !lunch command that&#8217;s supposed to help. Unfortunately you have to fill out the dining list yourself, and frankly, that&#8217;s a pain. The result is lots of old, bad definitions in a few limited areas. It does let you sneak in some comedy options (What to have in Canton? PB&J? Leftovers?), but for the main purpose it kinda sucks.

The solution is to use someone else&#8217;s database. I cooked one up yesterday pretty quickly using [Yahoo Local&#8217;s][4] [API][5] and the [pYsearch][6] convenience module. The result is quite easy, really. The only wrinkle is you need that module (someone could rewrite it to use just urllib and simplejson, if they cared) and a Yahoo API key.

The code is below, also available at <http://libpa.st/2K0kh>.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #66cc66;">@</span>command<span style="color: black;">&#40;</span><span style="color: #483d8b;">"lunch"</span><span style="color: #66cc66;">,</span> doc<span style="color: #66cc66;">=</span><span style="color: #483d8b;">"Find a random neary restaurant for lunch using Yahoo Local. Defaults to 1 mile radius, but append Xmi to the end to change the radius."</span><span style="color: black;">&#41;</span>
<span style="color: #ff7700;font-weight:bold;">def</span> lunch<span style="color: black;">&#40;</span>client<span style="color: #66cc66;">,</span> event<span style="color: #66cc66;">,</span> channel<span style="color: #66cc66;">,</span> nick<span style="color: #66cc66;">,</span> rest<span style="color: black;">&#41;</span>:
        <span style="color: #ff7700;font-weight:bold;">from</span> yahoo.<span style="color: black;">search</span>.<span style="color: black;">local</span> <span style="color: #ff7700;font-weight:bold;">import</span> LocalSearch
        location <span style="color: #66cc66;">=</span> rest.<span style="color: black;">strip</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
        <span style="color: #ff7700;font-weight:bold;">if</span> location.<span style="color: black;">endswith</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'mi'</span><span style="color: black;">&#41;</span>:
                radius<span style="color: #66cc66;">,</span> location <span style="color: #66cc66;">=</span> <span style="color: #483d8b;">''</span>.<span style="color: black;">join</span><span style="color: black;">&#40;</span><span style="color: #008000;">reversed</span><span style="color: black;">&#40;</span>location<span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>.<span style="color: black;">split</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">' '</span><span style="color: #66cc66;">,</span> <span style="color: #ff4500;">1</span><span style="color: black;">&#41;</span>
                location <span style="color: #66cc66;">=</span> <span style="color: #483d8b;">''</span>.<span style="color: black;">join</span><span style="color: black;">&#40;</span><span style="color: #008000;">reversed</span><span style="color: black;">&#40;</span>location<span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>
                radius <span style="color: #66cc66;">=</span> <span style="color: #483d8b;">''</span>.<span style="color: black;">join</span><span style="color: black;">&#40;</span><span style="color: #008000;">reversed</span><span style="color: black;">&#40;</span>radius<span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>
                radius <span style="color: #66cc66;">=</span> <span style="color: #008000;">float</span><span style="color: black;">&#40;</span>radius.<span style="color: black;">replace</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'mi'</span><span style="color: #66cc66;">,</span> <span style="color: #483d8b;">''</span><span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>
        <span style="color: #ff7700;font-weight:bold;">else</span>:
                radius <span style="color: #66cc66;">=</span> <span style="color: #ff4500;">1</span>
        srch <span style="color: #66cc66;">=</span> LocalSearch<span style="color: black;">&#40;</span>app_id<span style="color: #66cc66;">=</span>yahooid<span style="color: #66cc66;">,</span> category<span style="color: #66cc66;">=</span><span style="color: #ff4500;">96926236</span><span style="color: #66cc66;">,</span> results<span style="color: #66cc66;">=</span><span style="color: #ff4500;">20</span><span style="color: #66cc66;">,</span> query<span style="color: #66cc66;">=</span><span style="color: #483d8b;">"lunch"</span><span style="color: #66cc66;">,</span> location<span style="color: #66cc66;">=</span>location<span style="color: #66cc66;">,</span> radius<span style="color: #66cc66;">=</span>radius<span style="color: black;">&#41;</span>
        res <span style="color: #66cc66;">=</span> srch.<span style="color: black;">parse_results</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
        <span style="color: #008000;">max</span> <span style="color: #66cc66;">=</span> res.<span style="color: black;">totalResultsAvailable</span> <span style="color: #ff7700;font-weight:bold;">if</span> res.<span style="color: black;">totalResultsAvailable</span> &lt<span style="color: #66cc66;">;</span> <span style="color: #ff4500;">250</span> <span style="color: #ff7700;font-weight:bold;">else</span> <span style="color: #ff4500;">250</span>
        num <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">random</span>.<span style="color: black;">randint</span><span style="color: black;">&#40;</span><span style="color: #ff4500;">1</span><span style="color: #66cc66;">,</span> <span style="color: #008000;">max</span><span style="color: black;">&#41;</span> - <span style="color: #ff4500;">1</span>
        <span style="color: #ff7700;font-weight:bold;">if</span> num &lt<span style="color: #66cc66;">;</span> <span style="color: #ff4500;">19</span>:
                choice <span style="color: #66cc66;">=</span> res.<span style="color: black;">results</span><span style="color: black;">&#91;</span>num<span style="color: black;">&#93;</span>
        <span style="color: #ff7700;font-weight:bold;">else</span>:
                srch <span style="color: #66cc66;">=</span> LocalSearch<span style="color: black;">&#40;</span>app_id<span style="color: #66cc66;">=</span>yahooid<span style="color: #66cc66;">,</span> category<span style="color: #66cc66;">=</span><span style="color: #ff4500;">96926236</span><span style="color: #66cc66;">,</span> results<span style="color: #66cc66;">=</span><span style="color: #ff4500;">20</span><span style="color: #66cc66;">,</span> query<span style="color: #66cc66;">=</span><span style="color: #483d8b;">"lunch"</span><span style="color: #66cc66;">,</span> location<span style="color: #66cc66;">=</span>location<span style="color: #66cc66;">,</span> start<span style="color: #66cc66;">=</span>num<span style="color: black;">&#41;</span>
                res <span style="color: #66cc66;">=</span> srch.<span style="color: black;">parse_results</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
                choice <span style="color: #66cc66;">=</span> res.<span style="color: black;">results</span><span style="color: black;">&#91;</span><span style="color: #ff4500;"></span><span style="color: black;">&#93;</span>
        <span style="color: #ff7700;font-weight:bold;">return</span> <span style="color: #483d8b;">'%s @ %s - %s'</span> % <span style="color: black;">&#40;</span>choice<span style="color: black;">&#91;</span><span style="color: #483d8b;">'Title'</span><span style="color: black;">&#93;</span><span style="color: #66cc66;">,</span> choice<span style="color: black;">&#91;</span><span style="color: #483d8b;">'Address'</span><span style="color: black;">&#93;</span><span style="color: #66cc66;">,</span> choice<span style="color: black;">&#91;</span><span style="color: #483d8b;">'Url'</span><span style="color: black;">&#93;</span><span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>

 [1]: http://lunchstr.appspot.com/
 [2]: http://lunchster.com/
 [3]: http://www.urbanspoon.com/spin-widget "Urban Spoon's slot machine widget"
 [4]: http://local.yahoo.com/ "Yahoo Local"
 [5]: http://developer.yahoo.com/search/local/V3/localSearch.html "Yahoo Local Search API Documentation"
 [6]: http://pysearch.sourceforge.net/docs/yahoo.search.local.html "pYsearch: Python APIs for Y! search services"