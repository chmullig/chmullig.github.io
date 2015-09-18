---
title: Library Paste
author: chmullig
layout: post
permalink: /2010/05/library-paste/
categories:
  - Nerdery
tags:
  - library paste
  - paste
  - pmxbot
  - python
---
The ever impressive [Jamie][1] wrote a nice little paste bin at work a while back. It was dead simple to use, relatively private (in that it used [UUIDs][2] and didn&#8217;t have an index), and hooked into [pmxbot][3]. Unfortunately like most of the code written internally it used a proprietary web framework that&#8217;s not open source. It&#8217;s like [cherrypy][4] & [cheetah][5], but different.

I decided to modify jamwt&#8217;s pastebin to make it open sourceable. It&#8217;s now up on BitBucket as **[Library Paste][6].** It uses cherrypy with [Routes][7] (*NB: Must use routes <1.12 due to *[#1010][8]), [mako][9] for templating, [simplejson][10] plus flat files for a database, and [pygments][11] for syntax highlighting. One of the great features is that it also allows one click sharing of files, particularly images. How handy is that?

For code &#8211; you specify a Pygments lexer to use and it will highlight it with that when displayed. You can leave it unhighlighted, and always get the plain text original.

For files &#8211; it will take anything. It will read the mime type when you upload it, and set it on output. It will tell your browser to display it inline, but it will also set the filename correctly so if you save it you&#8217;ll get whatever it was uploaded with, rather than the ugly uuid with no file extension.

There are a few minor improvements from the in house original. First, the upload file is on the same page rather than separated from uploading code. Second, it handles file names with spaces better. Third, there is no third.

I&#8217;d really like to get configuration/deployment setup. What&#8217;s considered a good, flexible way to to make it easy for folks to deploy an app like this? Use cherrypy config files, build a little bin script and optionally let folks run it behind wsgi if they want to nginx/apache it?

I&#8217;d also like to try with putting it up on [Google App Engine][12]. Looks like you have to jump through a few hoops to adjust code to use it, and I&#8217;d have to adapt the flat file system to use their DB.

One nifty &#8220;hidden&#8221; feature it has is that you can ask it for the last UUID posting for a given user, if they filled in the nickname. You simple visit http://host/last/user and get back a plain text response with the UUID. pmxbot can use this to provide a link to someone&#8217;s most recent paste. Here&#8217;s the generic pmxbot function we used.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #66cc66;">@</span>command<span style="color: black;">&#40;</span><span style="color: #483d8b;">"paste"</span><span style="color: #66cc66;">,</span> aliases<span style="color: #66cc66;">=</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span><span style="color: #66cc66;">,</span> doc<span style="color: #66cc66;">=</span><span style="color: #483d8b;">"Drop a link to your latest paste on paste"</span><span style="color: black;">&#41;</span>
<span style="color: #ff7700;font-weight:bold;">def</span> paste<span style="color: black;">&#40;</span>client<span style="color: #66cc66;">,</span> event<span style="color: #66cc66;">,</span> channel<span style="color: #66cc66;">,</span> nick<span style="color: #66cc66;">,</span> rest<span style="color: black;">&#41;</span>:
    post_id <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">urllib</span>.<span style="color: black;">urlopen</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">"http://paste./last/%s"</span> % nick<span style="color: black;">&#41;</span>.<span style="color: black;">read</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
    <span style="color: #ff7700;font-weight:bold;">if</span> post_id:
        <span style="color: #ff7700;font-weight:bold;">return</span> <span style="color: #483d8b;">'http://paste/%s'</span> % post_id
    <span style="color: #ff7700;font-weight:bold;">else</span>:
        <span style="color: #ff7700;font-weight:bold;">return</span> <span style="color: #483d8b;">"hmm.. I didn't find a recent paste of yours, %s. Try http://paste to add one."</span> % nick</pre>
      </td>
    </tr>
  </table>
</div>

<div id='gallery-1' class='gallery galleryid-103 gallery-columns-3 gallery-size-thumbnail'>
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://chmullig.com/wp-content/uploads/2010/05/librarypaste_input.png'><img width="150" height="150" src="http://chmullig.com/wp-content/uploads/2010/05/librarypaste_input-150x150.png" class="attachment-thumbnail" alt="The input/home screen for adding a new paste. Earlier users note - file input on the same page." aria-describedby="gallery-1-105" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-1-105'>
      The input/home screen for adding a new paste. Earlier users note &#8211; file input on the same page.
    </dd>
  </dl>
  
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://chmullig.com/wp-content/uploads/2010/05/librarypaste_code.png'><img width="150" height="150" src="http://chmullig.com/wp-content/uploads/2010/05/librarypaste_code-150x150.png" class="attachment-thumbnail" alt="Showing some syntax highlighted code (indeed, Library Paste itself. The pastebin equivalent of boostrapping?)" aria-describedby="gallery-1-107" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-1-107'>
      Showing some syntax highlighted code (indeed, Library Paste itself. The pastebin equivalent of boostrapping?)
    </dd>
  </dl>
  
  <dl class='gallery-item'>
    <dt class='gallery-icon landscape'>
      <a href='http://chmullig.com/wp-content/uploads/2010/05/librarypaste_img.png'><img width="150" height="150" src="http://chmullig.com/wp-content/uploads/2010/05/librarypaste_img-150x150.png" class="attachment-thumbnail" alt="An image being served up by library paste. It automatically sets the mime type and filename based on what was uploaded." aria-describedby="gallery-1-108" /></a>
    </dt>
    
    <dd class='wp-caption-text gallery-caption' id='gallery-1-108'>
      An image being served up by library paste. It automatically sets the mime type and filename based on what was uploaded.
    </dd>
  </dl>
  
  <br style="clear: both" />
</div>

### Update:

I&#8217;ve since made a google app engine compatible version. It&#8217;s publicly hosted and you&#8217;re welcome to use it. <http://librarypastebin.appspot.com> and at [**http://libpa.st**][13]. Yes, I bought a stupid short URL for it!

 [1]: http://jamwt.com "Jamie Turner aka jamwt"
 [2]: http://en.wikipedia.org/wiki/Universally_Unique_Identifier "Universally Unique IDs - really long random letters and numbers"
 [3]: http://bitbucket.org/yougov/pmxbot
 [4]: http://cherrypy.org "CherryPy"
 [5]: http://www.cheetahtemplate.org/ "Cheetah Templates"
 [6]: http://bitbucket.org/chmullig/librarypaste "Library Paste"
 [7]: http://routes.groovie.org/
 [8]: http://www.cherrypy.org/ticket/1010 "Cherrypy ticket #1010: Routes Dispatcher doesn't work with Routes 1.12.1"
 [9]: http://www.makotemplates.org/
 [10]: http://code.google.com/p/simplejson/
 [11]: http://pygments.org/
 [12]: http://code.google.com/appengine/
 [13]: http://libpa.st