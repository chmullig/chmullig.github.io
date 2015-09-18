---
title: Lying with graphs
author: chmullig
layout: post
permalink: /2011/04/lying-with-graphs/
categories:
  - Uncategorized
tags:
  - damn lies
  - data
  - graphing
  - lies
  - presentation
  - statistics
---
Someone on twitter shared[ this article][1] about the size of the big 4 ad agencies. Unfortunately it&#8217;s horribly, horribly flawed.

First, the numbers they&#8217;re presenting are wrong. I copied the headline numbers that they linked to into Excel (that file, with my graphs, is: [here][2]). Their top 4 category is right. The four largest do sum to $40.7 billion. However it appears that their &#8220;next 46&#8243; is really numbers 3-50, #3 and #4 are being double counted in both categories. From what I can tell, the real number for the next 46 is $21.5 billion. Perhaps I&#8217;m not understanding something about the way these were computed, but that&#8217;s my understanding.

Finally, that graph is a travesty to data presentation. The y-axis range (starting at 32 instead of 0) obscures the data, and the cones are stupid beyond words.

<div id="attachment_335" style="width: 650px" class="wp-caption alignnone">
  <a href="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holding-Cos.jpeg"><img class="size-full wp-image-335" title="Original Ad Age graph" src="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holding-Cos.jpeg" alt="" width="640" height="382" /></a>
  
  <p class="wp-caption-text">
    Original Ad Age graph. Note the y-axis and stupid cones.
  </p>
</div>

We can easily make that graph more useful by turning it into standard bars with a y-axis that begins at 0. Note that the difference appears much smaller, and more clearly.

<div id="attachment_336" style="width: 650px" class="wp-caption alignnone">
  <a href="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holding-Companies.png"><img class="size-full wp-image-336" title="Chris' first revision" src="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holding-Companies.png" alt="" width="640" height="435" /></a>
  
  <p class="wp-caption-text">
    My first revision - fixing the y-axis and using normal bars
  </p>
</div>

Finally note that that&#8217;s actually a lie, because their summary doesn&#8217;t seem to line up with their data. Here&#8217;s how it would actually look, as far as I can tell.

<div id="attachment_337" style="width: 650px" class="wp-caption alignnone">
  <a href="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holding-chmullig-v2.png"><img class="size-full wp-image-337 " title="Agency Holding chmullig v2" src="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holding-chmullig-v2.png" alt="" width="640" /></a>
  
  <p class="wp-caption-text">
    This is using the totals I came up with based on their report
  </p>
</div>

However ultimately I think this is a poor way of expressing the data. Top 4 is, to me, not that significant. I&#8217;d rather see how that tail actually plays out. Is it the top 10 that are pretty big, and then 11-50 are microscopic? Is it really just the top 1 that&#8217;s huge, and the rest are more even? A graph that shows each company separately would help a lot. So I made each company a bar, ordered them by rank, and highlighted the top 4 in red. To me this graph tells a much richer and more useful story. You can see that WPP and Omnicom are huge. Publicis and Interpublic are pretty large, but only half the first two. Then Dentsu, Aegis, Havas, and Hakuhodo DY are pretty big, around the 2-3 billion mark. Starting with Acxiom is falls off and is pretty consistent. Acxiom is half of Hakuhodo, but every company after is at least 84% of the one before it, with most around 95% of the next highest&#8217;s revenue.

<div id="attachment_338" style="width: 650px" class="wp-caption alignnone">
  <a href="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holdings-Individual-Cos.png"><img class="size-large wp-image-640 " title="Agency Holdings Individual Cos" src="http://chmullig.com/wp-content/uploads/2011/04/Agency-Holdings-Individual-Cos-1024x696.png" alt="" width="640" /></a>
  
  <p class="wp-caption-text">
    Individually graphed agency holding companies. Top 4 highlighted in red. Notice the big changes in the top 9, then pretty consistent numbers.
  </p>
</div>

Again if you&#8217;re interested you can check out the Excel file I slapped these numbers/graphs together in by downloading it [here][2].

<span style="color: #ff0000;">UPDATE: Matt Carmichael at Ad Age updated his post to something very much like my third. Tufte would be pleased.</span>

 [1]: http://adage.com/article/adagestat/stat-day-50-biggest-ad-agencies-stack/227214/
 [2]: http://chmullig.com/wp-content/uploads/2011/04/Ad-Age-firm-size-reconstruction.xlsx