---
title: Births by Day of Year
author: chmullig
layout: post
permalink: /2012/06/births-by-day-of-year/
categories:
  - Nerdery
  - School
tags:
  - birthday
  - programming
  - r
  - statistics
---
Andrew Gelman has [posted][1] [twice][2] about certains days being more or less common for births, and lamented the lack of a good, simple visualization showing all 366 days.

Well, I heard his call! My goal was simply a line graph that showed

Finding a decent public dataset proved surprisingly hard &#8211; very few people with large datasets seem willing to release full date of birth (at least for recent data). I considered voter files, but I think the data quality issues would be severe, and might present unknown bias. There&#8217;s some data from the CDC&#8217;s National Vital Statistics System, but it either only contains year and month, or isn&#8217;t available in an especially easy to use format. There&#8217;s some older data that seemed like the best bet, and which others have used before.

A bit more searching revealed that Google&#8217;s [BigQuery][3] coincidentally loads the NVSS data as one of their [sample datasets][4]. A quick query in their browser tool and export to [CSV][5] and I had the data I wanted. NVSS/google seems to include only the day of the month for 1/1/1969 through 12/31/1988. More recent data just includes year and month.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="sql" style="font-family:monospace;"><span style="color: #993333; font-weight: bold;">SELECT</span> <span style="color: #993333; font-weight: bold;">MONTH</span><span style="color: #66cc66;">,</span> <span style="color: #993333; font-weight: bold;">DAY</span><span style="color: #66cc66;">,</span> <span style="color: #993333; font-weight: bold;">SUM</span><span style="color: #66cc66;">&#40;</span>record_weight<span style="color: #66cc66;">&#41;</span>
<span style="color: #993333; font-weight: bold;">FROM</span> <span style="color: #66cc66;">&#91;</span>publicdata:samples<span style="color: #66cc66;">.</span>natality<span style="color: #66cc66;">&#93;</span>
<span style="color: #993333; font-weight: bold;">WHERE</span> <span style="color: #993333; font-weight: bold;">DAY</span> <span style="color: #66cc66;">&gt;=</span> <span style="color: #cc66cc;">1</span> <span style="color: #993333; font-weight: bold;">AND</span> <span style="color: #993333; font-weight: bold;">DAY</span> <span style="color: #66cc66;">&lt;=</span> <span style="color: #cc66cc;">31</span>
<span style="color: #993333; font-weight: bold;">GROUP</span> <span style="color: #993333; font-weight: bold;">BY</span> <span style="color: #993333; font-weight: bold;">MONTH</span><span style="color: #66cc66;">,</span> <span style="color: #993333; font-weight: bold;">DAY</span>
<span style="color: #993333; font-weight: bold;">ORDER</span> <span style="color: #993333; font-weight: bold;">BY</span> <span style="color: #993333; font-weight: bold;">MONTH</span><span style="color: #66cc66;">,</span> <span style="color: #993333; font-weight: bold;">DAY</span></pre>
      </td>
    </tr>
  </table>
</div>

Some basic manipulation (including multiplying 2/29 by 4 per Gelman&#8217;s suggestion) and a bit of time to remember all of R&#8217;s fancy graphing features yielded [this script][6] and this graph:

*See update at bottom!*  
[<img class="alignnone  wp-image-456" title="Births by day" src="http://chmullig.com/wp-content/uploads/2012/06/birthdays.png" alt="" width="250px" />][7]

I&#8217;ve labeled outliers > 2.3 standard deviations from the loess curve (which unfortunately I should really predict &#8220;wrapping&#8221; around New Years&#8230;), as well as Valentine&#8217;s and Halloween. You can see by far the largest peaks and valleys are July 4th, Christmas, and just before/after New Years while Valentine&#8217;s and Halloween barely register as blips.

It&#8217;s possible there data collection issues causing some of this &#8211; perhaps births that occurred on July 4th were recorded over the following few days? The whole thing is surprisingly less uniform than I expected.

### Simulating Birthday Problem

I also wanted to simulate the birthday problem using these real values, instead of the basic assumption of 1/365th per day. In particular I DON&#8217;T multiply Feb 29th by 4, so it accurately reflects the distribution in a random population. This is data for 1969 to 1988, but I haven&#8217;t investigated whether there&#8217;s a day of week skew by selecting this specific interval as opposed to others, this is just the maximal range.

I did a [basic simulation][8] of 30,000 trials for each group size from 0 to 75. It works out very close to the synthetic/theoretical, as you can see in this graph (red is theoretical, black is real data). Of note, the real data seems to average about 0.15% more likely than the synthetic for groups of size 10-30 (the actual slope).

[<img class="alignnone  wp-image-480" title="Birthday Problem - Real vs Synthetic" src="http://chmullig.com/wp-content/uploads/2012/06/bday_problem.png" alt="Birthday Problem - Real vs Synthetic" width="100%" />][9]

I&#8217;ve also uploaded a graph of the P(Match using Real) &#8211; P(Match using Synthetic).

[<img class="alignnone  wp-image-481" title="Birthday Problem - Real minus Synthetic" src="http://chmullig.com/wp-content/uploads/2012/06/bday_difference.png" alt="" width="100%" />][10]

If you&#8217;re curious about the [raw results][11], here&#8217;s the most exciting part:

<table>
  <td style="text-align: right; padding-left: 1em;">
    <strong>n</strong>
  </td>
  
  <td style="text-align: right; padding-left: 1em;">
    <strong>real</strong>
  </td>
  
  <td style="text-align: right; padding-left: 1em;">
    <strong>synthetic</strong>
  </td>
  
  <td style="text-align: right; padding-left: 1em;">
    <strong>diff</strong>
  </td></tr> 
  
  <tr>
    <td style="text-align: right; padding-left: 2em;">
      10
    </td>
    
    <td style="text-align: right; padding-left: 30px;">
      11.59%
    </td>
    
    <td style="text-align: right; padding-left: 30px;">
      11.41%
    </td>
    
    <td style="text-align: right; padding-left: 30px;">
      0.18%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      11
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      14.08%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      14.10%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.02%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      12
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      16.84%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      16.77%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.08%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      13
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      19.77%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      19.56%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.21%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      14
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      22.01%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      22.06%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.05%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      15
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      25.74%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      25.17%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.57%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      16
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      28.24%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      27.99%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.25%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      17
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      31.81%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      31.71%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.10%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      18
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      34.75%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      33.76%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.98%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      19
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      37.89%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      37.90%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.01%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      20
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      40.82%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      40.82%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.00%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      21
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      44.48%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      44.57%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.09%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      22
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      47.92%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      47.45%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.47%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      23
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      50.94%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      50.80%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.14%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      24
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      53.89%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      53.79%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.10%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      25
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      57.07%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      56.76%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.31%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      26
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      59.74%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      59.75%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.01%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      27
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      62.61%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      63.00%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.40%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      28
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      65.88%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      65.26%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.63%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      29
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      68.18%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      67.85%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.32%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      30
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      70.32%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      70.49%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.18%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      31
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      73.00%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      72.73%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.27%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      32
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      75.37%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      75.65%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.28%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      33
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      77.59%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      77.63%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.04%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      34
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      79.67%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      78.86%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.81%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      35
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      81.44%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      81.24%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.19%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      36
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      83.53%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      82.79%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.74%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      37
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      84.92%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      84.52%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.41%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      38
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      86.67%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      86.62%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.05%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      39
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      87.70%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      88.09%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      -0.39%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right; padding-left: 1em;">
      40
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      89.07%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      88.88%
    </td>
    
    <td style="text-align: right; padding-left: 1em;">
      0.19%
    </td>
  </tr>
  
  <tr>
    <td style="text-align: right;">
      41
    </td>
    
    <td style="text-align: right;">
      90.16%
    </td>
    
    <td style="text-align: right;">
      90.48%
    </td>
    
    <td style="text-align: right; padding-left: 30px;">
      -0.32%
    </td>
  </tr></tbody>
</table>

### Update

Gelman [commented][12] on the graph and had some constructive feedback. I made a few cosmetic changes in response: rescaled so it&#8217;s relative to the mean, removing the trend line, and switching it to 14 months (tacking December onto the beginning, and January onto the end). Updated graph:  
[<img class="alignnone  wp-image-456" title="Births by day" src="http://chmullig.com/wp-content/uploads/2012/06/birthdays_revised.png" alt="" width="100%" />][13]

 [1]: http://andrewgelman.com/2012/02/more-babies-on-valentines-day-and-less-babies-on-halloween/ "Extra babies on Valentine’s Day, fewer on Halloween?"
 [2]: http://andrewgelman.com/2012/06/halloweenvalentines-update/ "Halloween/Valentine’s update "
 [3]: https://developers.google.com/bigquery/
 [4]: https://developers.google.com/bigquery/docs/dataset-natality
 [5]: http://chmullig.com/wp-content/uploads/2012/06/births.csv "birth data attached"
 [6]: http://chmullig.com/wp-content/uploads/2012/06/births-by-days.R.txt "Sorry, it's .txt because WP didn't want me to upload a .R"
 [7]: http://chmullig.com/wp-content/uploads/2012/06/birthdays.png
 [8]: http://chmullig.com/wp-content/uploads/2012/06/bday-problem.R.txt
 [9]: http://chmullig.com/wp-content/uploads/2012/06/bday_problem.png
 [10]: http://chmullig.com/wp-content/uploads/2012/06/bday_difference.png
 [11]: http://chmullig.com/wp-content/uploads/2012/06/bday_problem.csv "CSV of simulations results"
 [12]: http://andrewgelman.com/2012/06/simple-graph-win-the-example-of-birthday-frequencies/ "Simple graph WIN: the example of birthday frequencies<br />
"
 [13]: http://chmullig.com/wp-content/uploads/2012/06/birthdays_revised.png