---
title: Bulk changing tickets in Trac
author: chmullig
layout: post
permalink: /2010/01/bulk-changing-tickets-in-trac/
categories:
  - Nerdery
tags:
  - python
  - trac
---
At work we use the [Trac][1] wiki/ticket/software dev management system. I have ended up as its primary maintainer here. We&#8217;ve had a few [developers][2] leave, and Trac had lots of tickets orphaned with the ex-employees as owner or polluting the CC list. I whipped together a python script using the XML-RPC plugin from trac-hacks. It leaves a nice comment (polluting the timeline some) but doesn&#8217;t send out emails by default.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #ff7700;font-weight:bold;">import</span> <span style="color: #dc143c;">xmlrpclib</span><span style="color: #66cc66;">,</span> <span style="color: #dc143c;">re</span>
&nbsp;
<span style="color: #808080; font-style: italic;">#connect</span>
t <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">xmlrpclib</span>.<span style="color: black;">ServerProxy</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'https://user:password@tracserver.example/xmlrpc'</span><span style="color: black;">&#41;</span>
&nbsp;
<span style="color: #808080; font-style: italic;">#regular expression for the CC field. </span>
byere <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">re</span>.<span style="color: #008000;">compile</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'(?:jamie|dave|brad)(?:@DOMAIN1<span style="color: #000099; font-weight: bold;">\.</span>LOCAL|@DOMAIN1<span style="color: #000099; font-weight: bold;">\.</span>COM)?,? ?'</span><span style="color: #66cc66;">,</span> <span style="color: #dc143c;">re</span>.<span style="color: black;">IGNORECASE</span><span style="color: black;">&#41;</span>
&nbsp;
<span style="color: #808080; font-style: italic;">#This first loop sets the owner to blank, the status to 'new', and cleans the CC list for any open tickets assigned to Jamie or Dave. Doing the CC fix here makes the timeline a little cleaner.</span>
<span style="color: #ff7700;font-weight:bold;">for</span> ticketid <span style="color: #ff7700;font-weight:bold;">in</span> t.<span style="color: black;">ticket</span>.<span style="color: black;">query</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'owner=jamie@DOMAIN1.LOCAL&owner=dave@DOMAIN1.LOCAL&status=new&status=accepted&status=assigned&testing&status=planning'</span><span style="color: black;">&#41;</span>:
    ticket <span style="color: #66cc66;">=</span> t.<span style="color: black;">ticket</span>.<span style="color: black;">get</span><span style="color: black;">&#40;</span>ticketid<span style="color: black;">&#41;</span>
    cclist <span style="color: #66cc66;">=</span> ticket<span style="color: black;">&#91;</span><span style="color: #ff4500;">3</span><span style="color: black;">&#93;</span><span style="color: black;">&#91;</span><span style="color: #483d8b;">'cc'</span><span style="color: black;">&#93;</span>
    newcclist <span style="color: #66cc66;">=</span> byere.<span style="color: black;">sub</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">''</span><span style="color: #66cc66;">,</span> cclist<span style="color: black;">&#41;</span>
    t.<span style="color: black;">ticket</span>.<span style="color: black;">update</span><span style="color: black;">&#40;</span>ticketid<span style="color: #66cc66;">,</span> <span style="color: #483d8b;">''</span><span style="color: #66cc66;">,</span> <span style="color: black;">&#123;</span><span style="color: #483d8b;">'owner'</span> : <span style="color: #483d8b;">''</span><span style="color: #66cc66;">,</span> <span style="color: #483d8b;">'status'</span> : <span style="color: #483d8b;">'new'</span><span style="color: #66cc66;">,</span> <span style="color: #483d8b;">'cc'</span> : newcclist<span style="color: black;">&#125;</span><span style="color: black;">&#41;</span>
&nbsp;
<span style="color: #808080; font-style: italic;">#This loop is just for those tickets where they appear on the CC list.</span>
<span style="color: #ff7700;font-weight:bold;">for</span> ticketid <span style="color: #ff7700;font-weight:bold;">in</span> t.<span style="color: black;">ticket</span>.<span style="color: black;">query</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'cc~=jamie&cc~=dave&cc~=brad&status!=closed'</span><span style="color: black;">&#41;</span>:
    ticket <span style="color: #66cc66;">=</span> t.<span style="color: black;">ticket</span>.<span style="color: black;">get</span><span style="color: black;">&#40;</span>ticketid<span style="color: black;">&#41;</span>
    cclist <span style="color: #66cc66;">=</span> ticket<span style="color: black;">&#91;</span><span style="color: #ff4500;">3</span><span style="color: black;">&#93;</span><span style="color: black;">&#91;</span><span style="color: #483d8b;">'cc'</span><span style="color: black;">&#93;</span>
    newcclist <span style="color: #66cc66;">=</span> byere.<span style="color: black;">sub</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">''</span><span style="color: #66cc66;">,</span> cclist<span style="color: black;">&#41;</span>
    t.<span style="color: black;">ticket</span>.<span style="color: black;">update</span><span style="color: black;">&#40;</span>ticketid<span style="color: #66cc66;">,</span> <span style="color: #483d8b;">''</span><span style="color: #66cc66;">,</span> <span style="color: black;">&#123;</span><span style="color: #483d8b;">'cc'</span> : newcclist<span style="color: black;">&#125;</span><span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>

 [1]: http://trac.edgewall.org/
 [2]: http://jamwt.com