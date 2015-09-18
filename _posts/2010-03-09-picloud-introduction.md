---
title: PiCloud introduction
author: chmullig
layout: post
permalink: /2010/03/picloud-introduction/
categories:
  - Nerdery
tags:
  - distributed
  - picloud
  - pyro
  - python
---
A couple weeks ago my [coworker][1] [mentioned][2] [PiCloud][3]. It claims to be &#8220;Cloud Computing. Simplified.&#8221; for python programming. Indeed, their trivial examples are too good to be true, basically. I pointed out how the way it was packaging up code to send over the wire was a lot like [Pyro][4]&#8216;s [Mobile Code][5] feature. We actually use Pyro mobile code quite a bit at work, within the context of our own distributed system running across machines we maintain.

After getting beta access I decided to check it out today. I spent about 15 minutes playing around with it, and decided to do a short writeup because there&#8217;s so little info out there. The short version is that technically it&#8217;s quite impressive. Simple, but more complicated than <tt>square(x)</tt> cases are as easy as they say. Information about PiCloud is in pretty short supply, so here&#8217;s my playing around reproduced for all to see.

### Installing/first using

This is pretty easy. I&#8217;m using a virtualenv because I was skeptical, but it&#8217;s neat how easy it is even with that. So I&#8217;m going to setup a virtualenv, install ipython to the virtualenv, then install the cloud egg. At the end I&#8217;ll add my api key to the ~/.picloud/cloudconf.py file so I don&#8217;t need to type it repeatedly. The file is created when you first import cloud, and is very straightforward.

<pre>chmullig@gore:~$ virtualenv picloud
New python executable in picloud/bin/python
Installing setuptools............done.
chmullig@gore:~$ source picloud/bin/activate
(picloud)chmullig@gore:~$ easy_install -U ipython
Searching for ipython
#snip
Processing ipython-0.10-py2.6.egg
creating /home/chmullig/picloud/lib/python2.6/site-packages/ipython-0.10-py2.6.egg
Extracting ipython-0.10-py2.6.egg to /home/chmullig/picloud/lib/python2.6/site-packages
Adding ipython 0.10 to easy-install.pth file
Installing iptest script to /home/chmullig/picloud/bin
Installing ipythonx script to /home/chmullig/picloud/bin
Installing ipcluster script to /home/chmullig/picloud/bin
Installing ipython script to /home/chmullig/picloud/bin
Installing pycolor script to /home/chmullig/picloud/bin
Installing ipcontroller script to /home/chmullig/picloud/bin
Installing ipengine script to /home/chmullig/picloud/bin

Installed /home/chmullig/picloud/lib/python2.6/site-packages/ipython-0.10-py2.6.egg
Processing dependencies for ipython
Finished processing dependencies for ipython
(picloud)chmullig@gore:~$ easy_install http://server/cloud-1.8.2-py2.6.egg
Downloading http://server/cloud-1.8.2-py2.6.egg
Processing cloud-1.8.2-py2.6.egg
creating /home/chmullig/picloud/lib/python2.6/site-packages/cloud-1.8.2-py2.6.egg
Extracting cloud-1.8.2-py2.6.egg to /home/chmullig/picloud/lib/python2.6/site-packages
Adding cloud 1.8.2 to easy-install.pth file

Installed /home/chmullig/picloud/lib/python2.6/site-packages/cloud-1.8.2-py2.6.egg
Processing dependencies for cloud==1.8.2
Finished processing dependencies for cloud==1.8.2
(picloud)chmullig@gore:~$ python -c 'import cloud' #to create the ~/.picloud directory
(picloud)chmullig@gore:~$ vim .picloud/cloudconf.py #to add api_key and api_secretkey
</pre>

### Trivial Examples

This is their trivial example, just to prove it&#8217;s as easy for me as it was for them.

<pre>In [1]: def square(x):
 ...:     return x**2
 ...:
In [2]: import cloud
In [3]: cid = cloud.call(square, 10)
In [4]: cloud.result(cid)
Out[4]: 100
</pre>

BAM! That&#8217;s just stupidly easy. Let&#8217;s try a module or two.

<pre>In [5]: import random
In [6]: def shuffler(x):
 ...:     xl = list(x)
 ...:     random.shuffle(xl)
 ...:     return ''.join(xl)
 ...:
In [8]: cid = cloud.call(shuffler, 'Welcome to chmullig.com')
In [9]: cloud.result(cid)
Out[9]: ' etcmmhmoeWll.cgcl uioo'
</pre>

### Less-Trivial Example & Packages

So that&#8217;s neat, but what about something I wrote, or something that&#8217;s off [pypi][6] that they don&#8217;t already have installed? Also quite easy. I&#8217;m going to be using  [Levenshtein edit distance][7] for this, because it&#8217;s simple but non-standard. For our purposes we&#8217;ll begin with a [pure python implementation][8], borrowed from [Magnus Lie][9]. Then we&#8217;ll switch to a C extension version, originally written by David Necas (Yeti), which I&#8217;ve [rehosted][10] on Google Code.

<pre>(picloud)chmullig@gore:~$ wget -O hetlev.py http://hetland.org/coding/python/levenshtein.py
#snip
2010-03-09 12:13:04 (79.2 KB/s) - `hetlev.py' saved [707/707]
(picloud)chmullig@gore:~$ easy_install http://pylevenshtein.googlecode.com/files/python-Levenshtein-0.10.1.tar.bz2
Downloading http://pylevenshtein.googlecode.com/files/python-Levenshtein-0.10.1.tar.bz2
Processing python-Levenshtein-0.10.1.tar.bz2
Running python-Levenshtein-0.10.1/setup.py -q bdist_egg --dist-dir /tmp/easy_install-mqtK2d/python-Levenshtein-0.10.1/egg-dist-tmp-igxMyM
zip_safe flag not set; analyzing archive contents...
Adding python-Levenshtein 0.10.1 to easy-install.pth file

Installed /home/chmullig/picloud/lib/python2.6/site-packages/python_Levenshtein-0.10.1-py2.6-linux-x86_64.egg
Processing dependencies for python-Levenshtein==0.10.1
Finished processing dependencies for python-Levenshtein==0.10.1
(picloud)chmullig@gore:~$
</pre>

Now both are installed locally and built. Beautiful. Let&#8217;s go ahead and test out the hetlev version.

<pre>In [18]: def distances(word, comparisonWords):
 ....:     results = []
 ....:     for otherWord in comparisonWords:
 ....:         results.append(hetlev.levenshtein(word, otherWord))
 ....:     return results
In [24]: zip(words, distances(word, words))
Out[24]:
[('kitten', 0),
 ('sitten', 1),
 ('sittin', 2),
 ('sitting', 3),
 ('cat', 5),
 ('kitty', 2),
 ('smitten', 2)]
</pre>

Now let&#8217;s put that up on PiCloud! It&#8217;s, uh, trivial. And fast.

<pre>In [25]: cid = cloud.call(distances, word, words)
In [26]: zip(words, cloud.result(cid))
Out[26]:
[('kitten', 0),
 ('sitten', 1),
 ('sittin', 2),
 ('sitting', 3),
 ('cat', 5),
 ('kitty', 2),
 ('smitten', 2)]
</pre>

Now let&#8217;s switch it to use the **C extension version** of edit distance from the PyLevenshtein package, and try to use it with PiCloud.

<pre>In [32]: import Levenshtein
In [33]: def cdistances(word, comparisonWords):
 results = []
 for otherword in comparisonWords:
 results.append(Levenshtein.distance(word, otherword))
 return results
 ....:
In [38]: zip(words, cdistances(word, words))
Out[38]:
[('kitten', 0),
 ('sitten', 1),
 ('sittin', 2),
 ('sitting', 3),
 ('cat', 5),
 ('kitty', 2),
 ('smitten', 2)]

In [39]: cid = cloud.call(cdistances, word, words)
In [40]: cloud.result(cid)
ERROR: An unexpected error occurred while tokenizing input
The following traceback may be corrupted or invalid
The error message is: ('EOF in multi-line statement', (30, 0))

ERROR: An unexpected error occurred while tokenizing input
The following traceback may be corrupted or invalid
The error message is: ('EOF in multi-line statement', (37, 0))
---------------------------------------------------------------------------
CloudException                            Traceback (most recent call last)
CloudException: Job 14:
 Could not depickle job
Traceback (most recent call last):
 File "/root/.local/lib/python2.6/site-packages/cloudserver/workers/employee/child.py", line 202, in run
 File "/usr/local/lib/python2.6/dist-packages/cloud/serialization/cloudpickle.py", line 501, in subimport
 __import__(name)
ImportError: ('No module named Levenshtein', &lt;function subimport at 0x2290ed8&gt;, ('Levenshtein',))
</pre>

### Installing C-Extension via web

[<img class="alignright size-medium wp-image-74" title="picloud repo" src="http://chmullig.com/wp-content/uploads/2010/03/picloud-repo-300x175.png" alt="" width="300" height="175" />][11]Not too surprisingly that didn&#8217;t work &#8211; Levenshtein is a C extension I built on my local machine. PiCloud doesn&#8217;t really make it obvious, but you can add C-Extensions via their [web interface][12]. Amazingly you can point it to an SVN repo and it will let you refresh it. It seems to download and call setup.py install, but it&#8217;s a little unclear. The fact is it just worked, so I didn&#8217;t care. I clicked on &#8220;Add Repository&#8221; and pasted in the URL from google code,  <tt>http://pylevenshtein.googlecode.com/svn/trunk</tt>. It built it and installed it, you can see the output on the right. I then just reran the exact same command and it works.

<pre style="clear: both;">In [41]: cid = cloud.call(cdistances, word, words)

In [42]: cloud.result(cid)
Out[42]: [0, 1, 2, 3, 5, 2, 2]

In [43]: zip(words, cloud.result(cid))
Out[43]:
[('kitten', 0),
 ('sitten', 1),
 ('sittin', 2),
 ('sitting', 3),
 ('cat', 5),
 ('kitty', 2),
 ('smitten', 2)]
</pre>

### Slightly more complicated

I&#8217;ve written a slightly more complicated script that fetches the [qwantzle][13] [corpus][14] and uses [jaro][15] distance to find the n closest words in the corpus to a given word. It&#8217;s pretty trivial and dumb, but definitely more complicated than the above examples. Below is closestwords.py

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #ff7700;font-weight:bold;">import</span> Levenshtein
<span style="color: #ff7700;font-weight:bold;">import</span> <span style="color: #dc143c;">urllib</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">class</span> Corpusinator<span style="color: black;">&#40;</span><span style="color: #008000;">object</span><span style="color: black;">&#41;</span>:
        <span style="color: #483d8b;">'''
        Finds the closest words to the word you specified.
        '''</span>
        <span style="color: #ff7700;font-weight:bold;">def</span> <span style="color: #0000cd;">__init__</span><span style="color: black;">&#40;</span><span style="color: #008000;">self</span><span style="color: #66cc66;">,</span> corpus<span style="color: #66cc66;">=</span><span style="color: #483d8b;">'http://cs.brown.edu/~jadrian/docs/etc/qwantzcorpus'</span><span style="color: black;">&#41;</span>:
                <span style="color: #483d8b;">'''Setup the corpus for later use. By default it uses
                http://cs.brown.edu/~jadrian/docs/etc/qwantzcorpus, but can by overridden
                by specifying an alternate URL that has one word per line. A number, a space, then the word.
                '''</span>
                raw <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">urllib</span>.<span style="color: black;">urlopen</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'http://cs.brown.edu/~jadrian/docs/etc/qwantzcorpus'</span><span style="color: black;">&#41;</span>.<span style="color: black;">readlines</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
                <span style="color: #008000;">self</span>.<span style="color: black;">corpus</span> <span style="color: #66cc66;">=</span> <span style="color: #008000;">set</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
                <span style="color: #ff7700;font-weight:bold;">for</span> line <span style="color: #ff7700;font-weight:bold;">in</span> raw:
                        <span style="color: #ff7700;font-weight:bold;">try</span>:
                                <span style="color: #008000;">self</span>.<span style="color: black;">corpus</span>.<span style="color: black;">add</span><span style="color: black;">&#40;</span>line.<span style="color: black;">split</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span><span style="color: black;">&#91;</span><span style="color: #ff4500;">1</span><span style="color: black;">&#93;</span><span style="color: black;">&#41;</span>
                        <span style="color: #ff7700;font-weight:bold;">except</span> <span style="color: #008000;">IndexError</span>:
                                <span style="color: #ff7700;font-weight:bold;">pass</span>
&nbsp;
        <span style="color: #ff7700;font-weight:bold;">def</span> findClosestWords<span style="color: black;">&#40;</span><span style="color: #008000;">self</span><span style="color: #66cc66;">,</span> words<span style="color: #66cc66;">,</span> n<span style="color: #66cc66;">=</span><span style="color: #ff4500;">10</span><span style="color: black;">&#41;</span>:
                <span style="color: #483d8b;">'''
                Return the n (default 10) closest words from the corpus.
                '''</span>
                results <span style="color: #66cc66;">=</span> <span style="color: black;">&#123;</span><span style="color: black;">&#125;</span>
                <span style="color: #ff7700;font-weight:bold;">for</span> word <span style="color: #ff7700;font-weight:bold;">in</span> words:
                        tempresults <span style="color: #66cc66;">=</span> <span style="color: black;">&#91;</span><span style="color: black;">&#93;</span>
                        <span style="color: #ff7700;font-weight:bold;">for</span> refword <span style="color: #ff7700;font-weight:bold;">in</span> <span style="color: #008000;">self</span>.<span style="color: black;">corpus</span>:
                                dist <span style="color: #66cc66;">=</span> Levenshtein.<span style="color: black;">jaro</span><span style="color: black;">&#40;</span>word<span style="color: #66cc66;">,</span> refword<span style="color: black;">&#41;</span>
                                tempresults.<span style="color: black;">append</span><span style="color: black;">&#40;</span><span style="color: black;">&#40;</span>dist<span style="color: #66cc66;">,</span> refword<span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>
                        tempresults <span style="color: #66cc66;">=</span> <span style="color: #008000;">sorted</span><span style="color: black;">&#40;</span>tempresults<span style="color: #66cc66;">,</span> reverse<span style="color: #66cc66;">=</span><span style="color: #008000;">True</span><span style="color: black;">&#41;</span>
                        results<span style="color: black;">&#91;</span>word<span style="color: black;">&#93;</span> <span style="color: #66cc66;">=</span> tempresults<span style="color: black;">&#91;</span>:n<span style="color: black;">&#93;</span>
                <span style="color: #ff7700;font-weight:bold;">return</span> results</pre>
      </td>
    </tr>
  </table>
</div>

Very simple. Let&#8217;s try &#8216;er out. First locally, then over the cloud.

<pre>In [1]: import closestwords

In [2]: c = closestwords.Corpusinator()

In [3]: c.findClosestWords(['bagel', 'cheese'], 5)
Out[3]:
{'bagel': [(0.8666666666666667, 'barge'),
           (0.8666666666666667, 'bag'),
           (0.8666666666666667, 'badge'),
           (0.8666666666666667, 'angel'),
           (0.8666666666666667, 'age')],
 'cheese': [(1.0, 'cheese'),
            (0.95238095238095244, 'cheesed'),
            (0.88888888888888895, 'cheers'),
            (0.88888888888888895, 'cheeks'),
            (0.8666666666666667, 'cheeseball')]}
</pre>

Unfortunately it just doesn&#8217;t want to work happily with PiCloud & ipython when you&#8217;re running <tt>import closestwords</tt>. The most obvious won&#8217;t work, cloud.call(c.findClosestWords, [&#8216;bagel&#8217;]). Neither will creating a tiny wrapper function and calling that within ipython:

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #ff7700;font-weight:bold;">def</span> caller<span style="color: black;">&#40;</span>words<span style="color: #66cc66;">,</span> n<span style="color: #66cc66;">=</span><span style="color: #ff4500;">10</span><span style="color: black;">&#41;</span>:
    c <span style="color: #66cc66;">=</span> closestwords.<span style="color: black;">Corpusinator</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
    <span style="color: #ff7700;font-weight:bold;">return</span> c.<span style="color: black;">findClosestWords</span><span style="color: black;">&#40;</span>words<span style="color: #66cc66;">,</span> n<span style="color: black;">&#41;</span>
cloud.<span style="color: black;">call</span><span style="color: black;">&#40;</span>caller<span style="color: #66cc66;">,</span> <span style="color: black;">&#91;</span><span style="color: #483d8b;">'bagel'</span><span style="color: black;">&#93;</span><span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>

I created a stupidly simple wrapper python file, wrap.py:

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #ff7700;font-weight:bold;">import</span> closestwords
<span style="color: #ff7700;font-weight:bold;">import</span> cloud
cid <span style="color: #66cc66;">=</span> cloud.<span style="color: black;">call</span><span style="color: black;">&#40;</span>closestwords.<span style="color: black;">caller</span><span style="color: #66cc66;">,</span> <span style="color: black;">&#91;</span><span style="color: #483d8b;">'bagel'</span><span style="color: #66cc66;">,</span><span style="color: black;">&#93;</span><span style="color: black;">&#41;</span>
<span style="color: #ff7700;font-weight:bold;">print</span> cloud.<span style="color: black;">result</span><span style="color: black;">&#40;</span>cid<span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>

That gives an import error. Even putting that caller wrapper above at the bottom of the closestwords.py and calling it in the \_\_main\_\_ section (as I do below with c.findClosestWords) didn&#8217;t work.

However if I stick it directly in closestwords.py, initialize the instance, then run it from there, everything is fine. I&#8217;m not sure what this means, if it&#8217;s supposed to happen, or what. But it seems like it could be a pain in the butt just to get  it calling the right function in the right context.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #ff7700;font-weight:bold;">if</span> __name__ <span style="color: #66cc66;">==</span> <span style="color: #483d8b;">'__main__'</span>:
        <span style="color: #ff7700;font-weight:bold;">import</span> cloud
        c <span style="color: #66cc66;">=</span> Corpusinator<span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
        cid <span style="color: #66cc66;">=</span> cloud.<span style="color: black;">call</span><span style="color: black;">&#40;</span>c.<span style="color: black;">findClosestWords</span><span style="color: #66cc66;">,</span> <span style="color: black;">&#91;</span><span style="color: #483d8b;">'bagel'</span><span style="color: #66cc66;">,</span><span style="color: black;">&#93;</span><span style="color: black;">&#41;</span>
        <span style="color: #ff7700;font-weight:bold;">print</span> cloud.<span style="color: black;">result</span><span style="color: black;">&#40;</span>cid<span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>

### What passes for a conclusion

I had a good time playing with PiCloud. I&#8217;m going to look at adapting real code to use it. If I get carried away AND feel like blogging I&#8217;ll be sure to post &#8216;er up. They have pretty good first tier support for the map part of map/reduce, which would be useful. Two links I found useful when working with PiCloud:

  * [PiCloud Documentation][16]
  * [The list of installed packages][17]
  * [PiCloud Forums][18]
  * The [Web Scraper ][19]example in their docs

* * *

### Update 3/11

Aaron Staley of PiCloud wrote me a nice email about this post. He says my problem with the closestwords example was due to a server side bug they&#8217;ve fixed. In playing around, it does seem a bit better. A few ways I tried to call it failed, but many of them worked. I had trouble passing in closestwords.caller, either in ipython or the wrapper script. However re-defining caller in ipython worked, as did creating an instance and passing in the instance&#8217;s findClosestWords function. A+ for communication, guys.

<pre>In [3]: cid = cloud.call(closestwords.caller, ['bagel'])

In [4]: cloud.result(cid)
ERROR: An unexpected error occurred while tokenizing input
The following traceback may be corrupted or invalid
The error message is: ('EOF in multi-line statement', (30, 0))

ERROR: An unexpected error occurred while tokenizing input
The following traceback may be corrupted or invalid
The error message is: ('EOF in multi-line statement', (37, 0))
---------------------------------------------------------------------------CloudException: Job 36: Could not depickle job
Traceback (most recent call last):
 File "/root/.local/lib/python2.6/site-packages/cloudserver/workers/employee/child.py", line 202, in run
AttributeError: 'module' object has no attribute 'caller'

In [8]: c = closestwords.Corpusinator()
In [9]: cid = cloud.call(c.findClosestWords, ['bagel', 'cheese'], 5)
In [10]: cloud.result(cid)
Out[10]:
{'bagel': [(0.8666666666666667, 'barge'),
 (0.8666666666666667, 'bag'),
 (0.8666666666666667, 'badge'),
 (0.8666666666666667, 'angel'),
 (0.8666666666666667, 'age')],
 'cheese': [(1.0, 'cheese'),
 (0.95238095238095244, 'cheesed'),
 (0.88888888888888895, 'cheers'),
 (0.88888888888888895, 'cheeks'),
 (0.8666666666666667, 'cheeseball')]}

In [11]: def caller(words, n=10):
 ....:     c = closestwords.Corpusinator()
 ....:     return c.findClosestWords(words, n)
 ....:
In [12]: cid = cloud.call(caller, ['bagel'])
In [13]: reload(closestword)
KeyboardInterrupt
In [13]: cloud.result(cid)
Out[13]:
{'bagel': [(0.8666666666666667, 'barge'),
 (0.8666666666666667, 'bag'),
 (0.8666666666666667, 'badge'),
 (0.8666666666666667, 'angel'),
 (0.8666666666666667, 'age'),
 (0.8222222222222223, 'barrel'),
 (0.8222222222222223, 'barely'),
 (0.81111111111111123, 'gamble'),
 (0.79047619047619044, 'vaguely'),
 (0.79047619047619044, 'largely')]}
</pre>

### Update 3/12

I did some more experimentation with PiCloud, [posted separately][20].

 [1]: http://ionrock.org/ "ionrock/Eric Larson"
 [2]: http://twitter.com/ionrock/status/9695304551 "@ionrock: Interesting distributed processing library "
 [3]: http://www.picloud.com/ "PiCloud | Cloud Computing. Simplified."
 [4]: http://pyro.sourceforge.net/ "Pyro - PYthon Remote Objects"
 [5]: http://pyro.sourceforge.net/manual/7-features.html#mobile
 [6]: http://pypi.python.org/pypi
 [7]: http://en.wikipedia.org/wiki/Levenshtein_distance "Levenshtein distance - Wikipedia"
 [8]: http://hetland.org/coding/python/levenshtein.py
 [9]: http://hetland.org/coding/
 [10]: http://code.google.com/p/pylevenshtein/
 [11]: http://chmullig.com/wp-content/uploads/2010/03/picloud-repo.png
 [12]: http://www.picloud.com/accounts/packages/
 [13]: http://www.qwantz.com/index.php?comic=1665
 [14]: http://cs.brown.edu/~jadrian/docs/etc/qwantzcorpus
 [15]: http://en.wikipedia.org/wiki/Jaro-Winkler_distance "Jaro-Winkler distance"
 [16]: http://docs.picloud.com/index.html
 [17]: http://www.picloud.com/pyapi/packages/weblist/python/
 [18]: http://support.picloud.com/forums
 [19]: http://docs.picloud.com/basic_examples.html
 [20]: /2010/03/picloud-followup-bumpy-road/ "PiCloud - Following the bumpy road"