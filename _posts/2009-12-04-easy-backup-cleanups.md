---
title: Easy backup cleanups
author: chmullig
layout: post
permalink: /2009/12/easy-backup-cleanups/
categories:
  - Nerdery
tags:
  - python
  - sysadmin
---
I often create little cron jobs that create backups of various things on linux systems. Typically there&#8217;s a baks dir that has a tarball for each day with some clever name like &#8216;bak-2009-12-04.tar.gz&#8217;. This works well, but it can be a little difficult to clean the directory up without moving to a much more complicated system. I wrote a little python script to help me sort out the ones I wanted to save and the ones I wanted to trash. It took me a while to find it, so I&#8217;m posting here for posterity.

The basic idea is it loops through all the files in the current directory and moves ones older than a certain date  that don&#8217;t meet certain criteria to a trash folder. I have it configured to save every day for the last month, every week for the last 6 months, and the beginning of every month forever. You can then delete the trash manually, but it makes the script fairly non-destructive.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #808080; font-style: italic;">#!/usr/bin/env python</span>
<span style="color: #ff7700;font-weight:bold;">import</span> <span style="color: #dc143c;">os</span><span style="color: #66cc66;">,</span> <span style="color: #dc143c;">time</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">def</span> categorize<span style="color: black;">&#40;</span>zeta<span style="color: black;">&#41;</span>:
	<span style="color: #ff7700;font-weight:bold;">for</span> <span style="color: #008000;">file</span><span style="color: #66cc66;">,</span> date <span style="color: #ff7700;font-weight:bold;">in</span> zeta:	
		<span style="color: #ff7700;font-weight:bold;">if</span> date.<span style="color: black;">tm_mday</span> <span style="color: #66cc66;">==</span> <span style="color: #ff4500;">1</span>: <span style="color: #808080; font-style: italic;">#save the first bak for each month, no matter what</span>
			tosave.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: #008000;">file</span><span style="color: black;">&#41;</span>
		<span style="color: #ff7700;font-weight:bold;">elif</span> <span style="color: #dc143c;">time</span>.<span style="color: black;">localtime</span><span style="color: black;">&#40;</span><span style="color: #dc143c;">time</span>.<span style="color: #dc143c;">time</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span> - <span style="color: #ff4500;">15778463</span><span style="color: black;">&#41;</span> <span style="color: #66cc66;">&gt;</span> date: <span style="color: #808080; font-style: italic;">#if the file is over 6 months old delete it</span>
			tomove.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: #008000;">file</span><span style="color: black;">&#41;</span>
		<span style="color: #ff7700;font-weight:bold;">elif</span> <span style="color: #dc143c;">time</span>.<span style="color: black;">localtime</span><span style="color: black;">&#40;</span><span style="color: #dc143c;">time</span>.<span style="color: #dc143c;">time</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span> - <span style="color: #ff4500;">15778463</span><span style="color: black;">&#41;</span> <span style="color: #66cc66;">&lt;</span> date <span style="color: #ff7700;font-weight:bold;">and</span> date.<span style="color: black;">tm_wday</span> <span style="color: #66cc66;">==</span> <span style="color: #ff4500;"></span>: <span style="color: #808080; font-style: italic;">#if the file is less than 6 months old and made on a sunday than delete it </span>
			tosave.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: #008000;">file</span><span style="color: black;">&#41;</span>
		<span style="color: #ff7700;font-weight:bold;">elif</span> <span style="color: #dc143c;">time</span>.<span style="color: black;">localtime</span><span style="color: black;">&#40;</span><span style="color: #dc143c;">time</span>.<span style="color: #dc143c;">time</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span> - <span style="color: #ff4500;">2592000</span><span style="color: black;">&#41;</span> <span style="color: #66cc66;">&lt;</span> date: <span style="color: #808080; font-style: italic;">#if the file is less than a month old, save it</span>
			tosave.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: #008000;">file</span><span style="color: black;">&#41;</span>
		<span style="color: #ff7700;font-weight:bold;">else</span>:
			tomove.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: #008000;">file</span><span style="color: black;">&#41;</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">def</span> makeEasier<span style="color: black;">&#40;</span>files<span style="color: black;">&#41;</span>:
	zeta <span style="color: #66cc66;">=</span> <span style="color: black;">&#91;</span><span style="color: black;">&#93;</span>
	<span style="color: #ff7700;font-weight:bold;">for</span> <span style="color: #008000;">file</span> <span style="color: #ff7700;font-weight:bold;">in</span> files:
		<span style="color: #ff7700;font-weight:bold;">if</span> <span style="color: #483d8b;">"tar"</span> <span style="color: #ff7700;font-weight:bold;">in</span> <span style="color: #008000;">file</span>:
			<span style="color: #ff7700;font-weight:bold;">if</span> <span style="color: #008000;">file</span>.<span style="color: black;">startswith</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">"trac"</span><span style="color: black;">&#41;</span>:
				date <span style="color: #66cc66;">=</span> <span style="color: #008000;">file</span><span style="color: black;">&#91;</span><span style="color: #ff4500;">5</span>:<span style="color: #ff4500;">13</span><span style="color: black;">&#93;</span>
			<span style="color: #ff7700;font-weight:bold;">elif</span> <span style="color: #008000;">file</span>.<span style="color: black;">startswith</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">"svn"</span><span style="color: black;">&#41;</span>:
				date <span style="color: #66cc66;">=</span> <span style="color: #008000;">file</span><span style="color: black;">&#91;</span><span style="color: #ff4500;">4</span>:<span style="color: #ff4500;">12</span><span style="color: black;">&#93;</span>
			<span style="color: #ff7700;font-weight:bold;">else</span>:
				<span style="color: #ff7700;font-weight:bold;">continue</span>		
			date <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">time</span>.<span style="color: black;">strptime</span><span style="color: black;">&#40;</span>date<span style="color: #66cc66;">,</span> <span style="color: #483d8b;">"%Y%m%d"</span><span style="color: black;">&#41;</span>
			zeta.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: black;">&#91;</span><span style="color: #008000;">file</span><span style="color: #66cc66;">,</span>date<span style="color: black;">&#93;</span><span style="color: black;">&#41;</span>
	<span style="color: #ff7700;font-weight:bold;">return</span> zeta
&nbsp;
<span style="color: #ff7700;font-weight:bold;">def</span> moveEm<span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>:
	<span style="color: #ff7700;font-weight:bold;">for</span> <span style="color: #008000;">file</span> <span style="color: #ff7700;font-weight:bold;">in</span> tomove:
		<span style="color: #ff7700;font-weight:bold;">if</span> <span style="color: #008000;">file</span> <span style="color: #ff7700;font-weight:bold;">not</span> <span style="color: #ff7700;font-weight:bold;">in</span> tosave:
			<span style="color: #ff7700;font-weight:bold;">try</span>:
				<span style="color: #dc143c;">os</span>.<span style="color: black;">rename</span><span style="color: black;">&#40;</span>path+<span style="color: #483d8b;">'/'</span>+<span style="color: #008000;">file</span><span style="color: #66cc66;">,</span>path+<span style="color: #483d8b;">"/trash/"</span>+<span style="color: #008000;">file</span><span style="color: black;">&#41;</span>
			<span style="color: #ff7700;font-weight:bold;">except</span> <span style="color: #008000;">Exception</span><span style="color: #66cc66;">,</span> detail:
				<span style="color: #ff7700;font-weight:bold;">print</span> <span style="color: #483d8b;">"Error with"</span><span style="color: #66cc66;">,</span> <span style="color: #008000;">file</span><span style="color: #66cc66;">,</span> <span style="color: #483d8b;">":"</span><span style="color: #66cc66;">,</span> detail
			<span style="color: #ff7700;font-weight:bold;">else</span>:
				<span style="color: #ff7700;font-weight:bold;">print</span> <span style="color: #483d8b;">"Moved"</span><span style="color: #66cc66;">,</span> <span style="color: #008000;">file</span><span style="color: #66cc66;">,</span> <span style="color: #483d8b;">"to trash"</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">if</span> __name__ <span style="color: #66cc66;">==</span> <span style="color: #483d8b;">"__main__"</span>:
	path <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">os</span>.<span style="color: black;">getcwd</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
	tomove <span style="color: #66cc66;">=</span> <span style="color: black;">&#91;</span><span style="color: black;">&#93;</span>
	tosave <span style="color: #66cc66;">=</span> <span style="color: black;">&#91;</span><span style="color: black;">&#93;</span>
&nbsp;
	files <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">os</span>.<span style="color: black;">listdir</span><span style="color: black;">&#40;</span>path<span style="color: black;">&#41;</span>
	zeta <span style="color: #66cc66;">=</span> makeEasier<span style="color: black;">&#40;</span>files<span style="color: black;">&#41;</span>
	categorize<span style="color: black;">&#40;</span>zeta<span style="color: black;">&#41;</span>
	moveEm<span style="color: black;">&#40;</span><span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>