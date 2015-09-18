---
title: SQL on Rails
author: chmullig
layout: post
permalink: /2006/04/sql-on-rails/
categories:
  - Nerdery
---
<p style="text-align: center;">
  <img class="size-medium wp-image-31 aligncenter" title="SQL on Rails" src="http://chmullig.com/wp-content/uploads/2006/04/Picture-3-1-300x152.png" alt="SQL on Rails" width="300" height="152" />
</p>

[Jamie][1], [Dave][2] and I managed to get our [stupid little idea][3] onto [/. today][4]. We were first on the page from about 1pm to 2pm eastern, slowly sliding down throughout the day. A big thanks goes to Dan/mcgreen for submitting the story that finally did it. We were also spotted on [digg][5] ([twice][6] [thrice][7]), [reddit][8], [waxy][9] (his conclusion? We were one of two that made him laugh) and others.

So I figured I would take a moment to share about how this all came to be. Back in December I was talking with the programmers at the office. Making fun of various web frameworks and other suitably dorky things. Apparently a few minutes before December 7, 2005 12:38:56 PST I made a joke similar to &#8220;Well, if ruby is better on rails why not any language? Like SQL.&#8221; and we all proceeded to laugh. Then I went back to my desk and paid a whole $8 to register the domain. Hey, it&#8217;s pretty funny, right? We all thought it would be great fun to set it up for an April Fool&#8217;s joke or something.

Insert here 4 months worth of nothing happening except an occasional mention. In March it may have escalated to &#8220;Hey, we should do that soon.&#8221;

Then finally on the 29th Jamie decides to kick into gear. We formulate a plan. I redirect the DNS to Jamie&#8217;s dedicated servers and we become a mirror of the Ruby on Rails site. Jamie does some quick changes, including the logo and mast, and a few other little things. Everyone works (the for pay kind). We agree that the next evening we&#8217;ll all get together at Jamie&#8217;s place and, after celebrating Dave&#8217;s birthday, produce a screencast and finish the site.

The 30th was crazy at work. We leave and finally get started sometime close to 10. I&#8217;m on my MacBook Pro, Dave is on his iBook and Jamie on his G5. Macs are in these days. Jamie is working on the site, primarily doing the photoshop work. Dave and I are working together on the screencast &#8211; he&#8217;s doing the pages, I&#8217;m doing the backend side like sore\_init, sor\_import and setting up textmate. I turn on the built in apache and give dave SSH + admin, so he can log in over SSH from his computer and make the magic happen. Our approach is to record the video while narrating for practice. Then we will record a voice over separately.

At 2:21 AM and about eight attempts later this proved successful. We had a 6.4GB uncompressed .mov (and 16MB compressed one) with only one big mistake &#8211; garage band crashed in the middle. Luckily nothing was happening on screen so we decide to fix it in post. Dave proceeds to take a nap while I play with the video. The MBP&#8217;s hard drive isn&#8217;t quite fast enough to play the massive uncompressed video, so I transfer it to Jamie&#8217;s G5. Our approach here is simple &#8211; the video will play on the screen and dave and I will provide commentary to be recorded in Logic. It goes well and we do pretty good on the first (and only) take. With a little editing magic jamie makes us sound practically good. Audio is then (4:45AM by now) exported to a wav file and copied to my MBP. We then sleep.

Next day, things are crazy at work for me but very quiet for the programmers. The other nerds in the company love it. Jamie and Dave make some improvements to the site though out the day. I formulate a plan to get a usable version of the screencast (remember audio and video still aren&#8217;t in one file, and there are still two mistakes). We can hopefully make a perfect version on my iBook, but if there are issues I want to at least get something. There&#8217;s an apple store one block from the office. I&#8217;m quite handy with final cut pro. The files are very small. Add these together and you get some shacking (thanks to Mike for shopping + hacking = shacking).

The three of us traipse in there with a USB drive containing all the files we need and go up to a dual G5 towards the end. I quickly copy the files into the home directory, set up a new profile in FCP and import the files. We then have to render the video, a 10 minute process. Jamie stays at the computer surfing the web, while Dave and I go over and look at the iPods. After rendering, I come back to sync up the audio and video (difficult with only a very quiet left channel), loop some video on the front and end, and chop out the garage band crash (it happens after we jump to line 54321, just before we do the sor_page snippet). I then quickly export and walk away for the 3 minutes that takes. We copy the files to the USB drive, plug it into another computer to test, and leave.

I work on work stuff while Jamie and Dave intersperse a little more website tweaking, including the remaining example projects. Jamie has about 2 hours more work on the site to do, Dave needs to create the tarball for people to download, and I plan on redoing the editing on the screencast.

At home my trusty iBook (yay for PPC) launches FCP HD just fine and, running off a respectable external drive, isn&#8217;t even that slow. I redo what we did at the apple store but a little cleaner (and using the uncompressed original file, not the compressed version). Then I add the title and end slates with the background fade. Then I start to get fancy. You see the one major problem we had with the screencast was the 404 page. It says Apache on it, ruining the whole illusion. I put white matte covering the two sections where it appears, then carefully overlaid a text with a proper &#8220;SQL/Development&#8221; identifier. Declaring it complete I exported a two versions of differing quality, at about 22MB and 48MB each. These get sent to Jamie, and I relax.

After returning from a Warriors game at sometime close to midnight Jamie puts in a heroic effort getting the screencast and download pages working, as well as the little Ajaxy pop ups for the links and a few other configuration things. Dave and I are already in bed. I&#8217;ve contacted a bunch of east coasters and asked them to promote the site in the morning, and Dave is planning on getting up at 7.

I slept in on Saturday. I hadn&#8217;t gotten a good nights sleep in 5 days, so I didn&#8217;t really wake up until 10AM. My cell phone was ringing. I didn&#8217;t answer, but saw it was Dave. I got a glass of water and called him back. &#8220;Have you seen slashdot?&#8221; &#8220;Uh, no.&#8221; I answer. I pretend I&#8217;m not thinking what I&#8217;m actually thinking, &#8220;Holy crap we made the front page.&#8221; My MBP slowly comes back from &#8220;deep sleep&#8221; and I load up slashdot. There, in bright pink letters:

It turns out a guy who goes to my high school (and does many of the same activities I do, as well as a friend of my brother back in middle school) posted, and cowboy neal posted it. Amazing. At that point it had just hit after a couple of Dave&#8217;s rejected posts, with only a few comments. You can see that traffic, shall we say, spiked. Within a few hours we had over 20 THOUSAND visitors. The site was still up, although the hosting facility was a bit bogged down, so pages loads were slow.

We continued to try to pimp the page throughout the day. I sent an email to DHH, the creator of Ruby on Rails, and he responded that it was, &#8220;Very funny. Great April&#8217;s 1st joke!&#8221; Most of the comments were entirely positive, except a few generally insulting all April 1st jokes. Some of my favorites are the Ruby on Rail&#8217;s list and the /. comments that noticed a bunch of our details (especially Jamie&#8217;s hacked server response. That&#8217;s dedication.). Anyone know if Guido found it? Below is a list of references I found, including a bunch in Korean. Ok&#8230;. If you find any more shoot an email.

Referrers and other found links.

  * [SQL On Rails Revolutionized Web Application Development (reddit.com)][8]
  * [Slashdot | SQL on Rails Launched][10]
  * [www.ruby-forum.com—60435][11] original ruby forums
  * [www.ruby-forum.com—60515][12] new ruby forums
  * Digg (4 stories) 
      * [SQL on Rails released!][13]
      * [SQL on Rails Launched][5]
      * [OMG Ruby on Rails is SOO last week SQL On Rails just released!][6]
      * [SQL on Rails &#8211; Creating a search engine in eight minutes.][7]
  * [gmane.editors.textmate.general][14] TextMate editor discussion board
  * [Waxy.org: Daily Log: Internet Jackass Day 2006][9] -&#8220;Conclusion: Eh. The only two that made me laugh were the Flickr cats and SQL on Rails.&#8221;
  * [Urgo&#8217;s 2006 list of April Fool&#8217;s Jokes on Websites][15] &#8211; We didn&#8217;t get selected as a favorite
  * Wikipedia &#8211; sadly we fell to [April 1, 2006 (Complete List)][16] and repeated attempts to stick us on the main one have failed.
  * [Python Software Foundation News: Python 2.5 Licensing Change][17] &#8211; someone joked that the licensing was because the quote on SoR&#8217; site about Guido giving up
  * [Duke Nukem Forever review &#8211; Topic Ars OpenForum][18] My comment in the Ars Ruby on Rails/AJAX Duke Nukem Forever review
  * [Just a Theory][19]
  * [Brainside Out | Sundries from April 2006][20]
  * [blog.raydenuni.com][21]
  * [badgertronics.com—blog][22]
  * [mockhaug » CREATE VIEW. DROP jaw.][23]
  * [Wendong’s Smart Phone Weblog » Blog Archive » Winner of this April’s Day: Ruby on Rails][24]
  * [Ross’ ex-Blog » Blog Archive »][25] &#8211; Apparently this guy deleted his blog on april 2nd. According to newsgator it used to say: I sort of suspected that this video might be an April Fools joke, and I wasn’t disappointed. Eight minutes long, but shows the true power of SQL on Rails &#8211; An Internet search engine in 8 minutes. I look forward however to the forthcoming O’Reilly book ’Fragile Web Development with SQL on Rails’.
  * [Anarchaia: A tumblelog by Christian Neukirchen][26]
  * [this is april | k4ml.com][27]
  * [Pig Pen &#8211; Web Standards Compliant Web Design Blog » Blog Archive » SQL On Rails 4.1][28]
  * [Lorem Ipsum: Slashdot, cuteness, etc.][29]
  * [Tailrank &#8211; They Come in Peace&#8230;and for the BBQ][30]
  * [has many :though SQL on Rails][31]
  * [Intrepid Blog » Blog Archive » SQL on rails][32]
  * [jania902 &#8211; SQL on Rails][33] &#8211; korean, I believe. Translated, roughly: SQL on Rails 4.1 versions came out. As the plan where the book will publish at once from O&#8217;Reilly does. The screen cast specially is the best. There is a possibility of making the Internet search engine at only 8 minutes &#8211;;
  * [Tracs en vruc &#8211; Prendre un Café][34] Translation: SQL one rails will upset your way of conceiving the Web by removing the parts V and C of the reason for design MVC. Model Seen Controlleur.
  * [Resumen de daños: 2006 April Fools Day en idealabs][35] &#8211; spanish. Translation: SQL on Rails version 4.1 is released. This new version, promises to revolutionize the development Web. One parodia of Ruby on Rails.
  * [20060402網摘 &#8211; 愚人節快樂 &#8211; 網絡暴民 Jacky’s Blog][36] &#8211; korean
  * [rubyist.or.kr » SQL on Rails][37] &#8211; korean. Crap translation: It was announced yesterday. It buys case understanding which is late one day; ; The bedspread which is until demonstration;

 [1]: http://jamwt.com/
 [2]: http://mrshoe.org/
 [3]: http://sqlonrails.org/
 [4]: http://developers.slashdot.org/story/06/04/01/1547251/SQL-on-Rails-Launched?art_pos=1
 [5]: http://digg.com/programming/SQL_on_Rails_Launched
 [6]: http://digg.com/programming/OMG_Ruby_on_Rails_is_SOO_last_week_SQL_On_Rails_just_released_
 [7]: http://digg.com/programming/SQL_on_Rails_-_Creating_a_search_engine_in_eight_minutes.
 [8]: http://reddit.com/info%253Fid%253D3s5w
 [9]: http://www.waxy.org/archive/2006/03/31/internet.shtml
 [10]: http://developers.slashdot.org/article.pl%253Fsid%253D06/04/01/1547251
 [11]: http://www.ruby-forum.com/topic/60435%2523new
 [12]: http://www.ruby-forum.com/topic/60515%2523new
 [13]: http://digg.com/technology/SQL_on_Rails_released_
 [14]: http://comments.gmane.org/gmane.editors.textmate.general/9352
 [15]: http://aprilfools.urgo.org/2006.html
 [16]: http://en.wikipedia.org/wiki/April_1%25252C_2006_%252528Complete_List%252529
 [17]: http://pyfound.blogspot.com/2006/04/python-25-licensing-change.html
 [18]: http://episteme.arstechnica.com/groupee/forums/a/tpc/f/174096756/m/195003548731/p/2
 [19]: http://www.justatheory.com/computers/databases/sqlonrails_macosx.html
 [20]: http://www.brainsideout.com/sundries/archives/2006/04/%2523001458
 [21]: http://blog.raydenuni.com/articles/2006/04/01/sql-on-rails
 [22]: http://badgertronics.com/blog/
 [23]: http://houseofhaug.net/blog/archives/2006/04/01/create-view-drop-jaw/
 [24]: http://wendong.ngphone.com/%253Fp%253D248
 [25]: http://www.teeko.org/blog/%253Fp%253D235
 [26]: http://anarchaia.org/archive/2006/04/02.html
 [27]: http://www.k4ml.com/node/177
 [28]: http://pigpen.info/2006/04/02/sql-on-rails-41/
 [29]: http://www.kith.org/journals/jed/2006/04/01/3466.html
 [30]: http://tailrank.com/posts/562949953542306/They_Come_in_Peace...and_for_the_BBQ
 [31]: http://blog.hasmanythrough.com/articles/2006/04/01/sql-on-rails
 [32]: http://blog.w-nz.com/archives/2006/04/01/sql-on-rails/
 [33]: http://www.allblog.net/GoPage/795275.html
 [34]: http://www.prendreuncafe.com/blog/2006/04/02/427-tracs-en-vruc
 [35]: http://idealabs.tk/archivos/2006/04/02/resumen-de-danos-2006-april-fools-day/
 [36]: http://jacky.seezone.net/2006/04/02/1599/
 [37]: http://rubyist.or.kr/blog/%253Fp%253D166