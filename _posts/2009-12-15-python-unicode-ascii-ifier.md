---
title: Python Unicode ASCII-ifier
author: chmullig
layout: post
permalink: /2009/12/python-unicode-ascii-ifier/
categories:
  - Nerdery
tags:
  - ascii
  - python
  - unicode
---
At work we maintain a [SDA Archive][1] for analyzing our panels and data. It&#8217;s nice, but unfortunately doesn&#8217;t support unicode, particularly in the dataset. We translate unicode characters in the metadata to [XML character reference entities][2], which works well for displaying that (v3.4 supports UTF-8 for metadata). This is done simply by using the built in <span style="font-family: fixed-width;">u&#8217;Some Unicode String&#8217;.encode(&#8216;ascii&#8217;, &#8216;xmlcharrefreplace)</span> as described [here][3].

The data is a flat ASCII text file, and it has massive issues with multibyte unicode characters in the text. The resulting field shifts meant I needed to get the best ASCII equivalent of a unicode string I could. There are a few semi-acceptable solutions, but none really preserved as much data was I wanted. I ended up making an improved version of [effbot&#8217;s unaccent.py][4]. I was primarily concerned with German, Danish, Norwegian, Finnish and Swedish, but hopefully it&#8217;s generally the most complete around.

The usage is pretty simple, just import unaccent.py and call unaccent.asciify(thing). You&#8217;ll get back an ascii str, regardless of what you stick in. In rare cases it may raise an exception if it&#8217;s a non-unicode object that can&#8217;t be asciified, but it works for my needs.

<div class="wp_syntax">
  <table>
    <tr>
      <td class="code">
        <pre class="python" style="font-family:monospace;"><span style="color: #808080; font-style: italic;"># -*- coding: utf-8 -*-</span>
<span style="color: #808080; font-style: italic;"># use a dynamically populated translation dictionary to remove accents</span>
<span style="color: #808080; font-style: italic;"># from a string</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">import</span> <span style="color: #dc143c;">unicodedata</span><span style="color: #66cc66;">,</span> <span style="color: #dc143c;">sys</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">class</span> unaccented_map<span style="color: black;">&#40;</span><span style="color: #008000;">dict</span><span style="color: black;">&#41;</span>:
<span style="color: #808080; font-style: italic;"># Translation dictionary.  Translation entries are added to this dictionary as needed.</span>
    CHAR_REPLACEMENT <span style="color: #66cc66;">=</span> <span style="color: black;">&#123;</span>
        <span style="color: #ff4500;">0xc6</span>: u<span style="color: #483d8b;">"AE"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Æ LATIN CAPITAL LETTER AE</span>
        <span style="color: #ff4500;">0xd0</span>: u<span style="color: #483d8b;">"D"</span><span style="color: #66cc66;">,</span>  <span style="color: #808080; font-style: italic;"># Ð LATIN CAPITAL LETTER ETH</span>
        <span style="color: #ff4500;">0xd8</span>: u<span style="color: #483d8b;">"OE"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ø LATIN CAPITAL LETTER O WITH STROKE</span>
        <span style="color: #ff4500;">0xde</span>: u<span style="color: #483d8b;">"Th"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Þ LATIN CAPITAL LETTER THORN</span>
        <span style="color: #ff4500;">0xc4</span>: u<span style="color: #483d8b;">'Ae'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ä LATIN CAPITAL LETTER A WITH DIAERESIS</span>
        <span style="color: #ff4500;">0xd6</span>: u<span style="color: #483d8b;">'Oe'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ö LATIN CAPITAL LETTER O WITH DIAERESIS</span>
        <span style="color: #ff4500;">0xdc</span>: u<span style="color: #483d8b;">'Ue'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ü LATIN CAPITAL LETTER U WITH DIAERESIS</span>
&nbsp;
        <span style="color: #ff4500;">0xc0</span>: u<span style="color: #483d8b;">"A"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># À LATIN CAPITAL LETTER A WITH GRAVE</span>
        <span style="color: #ff4500;">0xc1</span>: u<span style="color: #483d8b;">"A"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Á LATIN CAPITAL LETTER A WITH ACUTE</span>
        <span style="color: #ff4500;">0xc3</span>: u<span style="color: #483d8b;">"A"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ã LATIN CAPITAL LETTER A WITH TILDE</span>
        <span style="color: #ff4500;">0xc7</span>: u<span style="color: #483d8b;">"C"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ç LATIN CAPITAL LETTER C WITH CEDILLA</span>
        <span style="color: #ff4500;">0xc8</span>: u<span style="color: #483d8b;">"E"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># È LATIN CAPITAL LETTER E WITH GRAVE</span>
        <span style="color: #ff4500;">0xc9</span>: u<span style="color: #483d8b;">"E"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># É LATIN CAPITAL LETTER E WITH ACUTE</span>
        <span style="color: #ff4500;">0xca</span>: u<span style="color: #483d8b;">"E"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ê LATIN CAPITAL LETTER E WITH CIRCUMFLEX</span>
        <span style="color: #ff4500;">0xcc</span>: u<span style="color: #483d8b;">"I"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ì LATIN CAPITAL LETTER I WITH GRAVE</span>
        <span style="color: #ff4500;">0xcd</span>: u<span style="color: #483d8b;">"I"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Í LATIN CAPITAL LETTER I WITH ACUTE</span>
        <span style="color: #ff4500;">0xd2</span>: u<span style="color: #483d8b;">"O"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ò LATIN CAPITAL LETTER O WITH GRAVE</span>
        <span style="color: #ff4500;">0xd3</span>: u<span style="color: #483d8b;">"O"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ó LATIN CAPITAL LETTER O WITH ACUTE</span>
        <span style="color: #ff4500;">0xd5</span>: u<span style="color: #483d8b;">"O"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Õ LATIN CAPITAL LETTER O WITH TILDE</span>
        <span style="color: #ff4500;">0xd9</span>: u<span style="color: #483d8b;">"U"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ù LATIN CAPITAL LETTER U WITH GRAVE</span>
        <span style="color: #ff4500;">0xda</span>: u<span style="color: #483d8b;">"U"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># Ú LATIN CAPITAL LETTER U WITH ACUTE</span>
&nbsp;
        <span style="color: #ff4500;">0xdf</span>: u<span style="color: #483d8b;">"ss"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ß LATIN SMALL LETTER SHARP S</span>
        <span style="color: #ff4500;">0xe6</span>: u<span style="color: #483d8b;">"ae"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># æ LATIN SMALL LETTER AE</span>
        <span style="color: #ff4500;">0xf0</span>: u<span style="color: #483d8b;">"d"</span><span style="color: #66cc66;">,</span>  <span style="color: #808080; font-style: italic;"># ð LATIN SMALL LETTER ETH</span>
        <span style="color: #ff4500;">0xf8</span>: u<span style="color: #483d8b;">"oe"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ø LATIN SMALL LETTER O WITH STROKE</span>
        <span style="color: #ff4500;">0xfe</span>: u<span style="color: #483d8b;">"th"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># þ LATIN SMALL LETTER THORN,</span>
        <span style="color: #ff4500;">0xe4</span>: u<span style="color: #483d8b;">'ae'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ä LATIN SMALL LETTER A WITH DIAERESIS</span>
        <span style="color: #ff4500;">0xf6</span>: u<span style="color: #483d8b;">'oe'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ö LATIN SMALL LETTER O WITH DIAERESIS</span>
        <span style="color: #ff4500;">0xfc</span>: u<span style="color: #483d8b;">'ue'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ü LATIN SMALL LETTER U WITH DIAERESIS</span>
&nbsp;
        <span style="color: #ff4500;">0xe0</span>: u<span style="color: #483d8b;">"a"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># à LATIN SMALL LETTER A WITH GRAVE</span>
        <span style="color: #ff4500;">0xe1</span>: u<span style="color: #483d8b;">"a"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># á LATIN SMALL LETTER A WITH ACUTE</span>
        <span style="color: #ff4500;">0xe3</span>: u<span style="color: #483d8b;">"a"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ã LATIN SMALL LETTER A WITH TILDE</span>
        <span style="color: #ff4500;">0xe7</span>: u<span style="color: #483d8b;">"c"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ç LATIN SMALL LETTER C WITH CEDILLA</span>
        <span style="color: #ff4500;">0xe8</span>: u<span style="color: #483d8b;">"e"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># è LATIN SMALL LETTER E WITH GRAVE</span>
        <span style="color: #ff4500;">0xe9</span>: u<span style="color: #483d8b;">"e"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># é LATIN SMALL LETTER E WITH ACUTE</span>
        <span style="color: #ff4500;">0xea</span>: u<span style="color: #483d8b;">"e"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ê LATIN SMALL LETTER E WITH CIRCUMFLEX</span>
        <span style="color: #ff4500;">0xec</span>: u<span style="color: #483d8b;">"i"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ì LATIN SMALL LETTER I WITH GRAVE</span>
        <span style="color: #ff4500;">0xed</span>: u<span style="color: #483d8b;">"i"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># í LATIN SMALL LETTER I WITH ACUTE</span>
        <span style="color: #ff4500;">0xf2</span>: u<span style="color: #483d8b;">"o"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ò LATIN SMALL LETTER O WITH GRAVE</span>
        <span style="color: #ff4500;">0xf3</span>: u<span style="color: #483d8b;">"o"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ó LATIN SMALL LETTER O WITH ACUTE</span>
        <span style="color: #ff4500;">0xf5</span>: u<span style="color: #483d8b;">"o"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># õ LATIN SMALL LETTER O WITH TILDE</span>
        <span style="color: #ff4500;">0xf9</span>: u<span style="color: #483d8b;">"u"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ù LATIN SMALL LETTER U WITH GRAVE</span>
        <span style="color: #ff4500;">0xfa</span>: u<span style="color: #483d8b;">"u"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ú LATIN SMALL LETTER U WITH ACUTE</span>
&nbsp;
        <span style="color: #ff4500;">0x2018</span>: u<span style="color: #483d8b;">"'"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ‘ LEFT SINGLE QUOTATION MARK</span>
        <span style="color: #ff4500;">0x2019</span>: u<span style="color: #483d8b;">"'"</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ’ RIGHT SINGLE QUOTATION MARK</span>
        <span style="color: #ff4500;">0x201c</span>: u<span style="color: #483d8b;">'"'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># “ LEFT DOUBLE QUOTATION MARK</span>
        <span style="color: #ff4500;">0x201d</span>: u<span style="color: #483d8b;">'"'</span><span style="color: #66cc66;">,</span> <span style="color: #808080; font-style: italic;"># ” RIGHT DOUBLE QUOTATION MARK</span>
&nbsp;
        <span style="color: black;">&#125;</span>
&nbsp;
    <span style="color: #808080; font-style: italic;"># Maps a unicode character code (the key) to a replacement code</span>
    <span style="color: #808080; font-style: italic;"># (either a character code or a unicode string).</span>
    <span style="color: #ff7700;font-weight:bold;">def</span> mapchar<span style="color: black;">&#40;</span><span style="color: #008000;">self</span><span style="color: #66cc66;">,</span> key<span style="color: black;">&#41;</span>:
        ch <span style="color: #66cc66;">=</span> <span style="color: #008000;">self</span>.<span style="color: black;">get</span><span style="color: black;">&#40;</span>key<span style="color: black;">&#41;</span>
        <span style="color: #ff7700;font-weight:bold;">if</span> ch <span style="color: #ff7700;font-weight:bold;">is</span> <span style="color: #ff7700;font-weight:bold;">not</span> <span style="color: #008000;">None</span>:
            <span style="color: #ff7700;font-weight:bold;">return</span> ch
        <span style="color: #ff7700;font-weight:bold;">try</span>:
            de <span style="color: #66cc66;">=</span> <span style="color: #dc143c;">unicodedata</span>.<span style="color: black;">decomposition</span><span style="color: black;">&#40;</span><span style="color: #008000;">unichr</span><span style="color: black;">&#40;</span>key<span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>
            p1<span style="color: #66cc66;">,</span> p2 <span style="color: #66cc66;">=</span> <span style="color: black;">&#91;</span><span style="color: #008000;">int</span><span style="color: black;">&#40;</span>x<span style="color: #66cc66;">,</span> <span style="color: #ff4500;">16</span><span style="color: black;">&#41;</span> <span style="color: #ff7700;font-weight:bold;">for</span> x <span style="color: #ff7700;font-weight:bold;">in</span> de.<span style="color: black;">split</span><span style="color: black;">&#40;</span><span style="color: #008000;">None</span><span style="color: #66cc66;">,</span> <span style="color: #ff4500;">1</span><span style="color: black;">&#41;</span><span style="color: black;">&#93;</span>
            <span style="color: #ff7700;font-weight:bold;">if</span> p2 <span style="color: #66cc66;">==</span> <span style="color: #ff4500;">0x308</span>:
		ch <span style="color: #66cc66;">=</span> <span style="color: #008000;">self</span>.<span style="color: black;">CHAR_REPLACEMENT</span>.<span style="color: black;">get</span><span style="color: black;">&#40;</span>key<span style="color: black;">&#41;</span>
            <span style="color: #ff7700;font-weight:bold;">else</span>:
                ch <span style="color: #66cc66;">=</span> <span style="color: #008000;">int</span><span style="color: black;">&#40;</span>p1<span style="color: black;">&#41;</span>
&nbsp;
        <span style="color: #ff7700;font-weight:bold;">except</span> <span style="color: black;">&#40;</span><span style="color: #008000;">IndexError</span><span style="color: #66cc66;">,</span> <span style="color: #008000;">ValueError</span><span style="color: black;">&#41;</span>:
            ch <span style="color: #66cc66;">=</span> <span style="color: #008000;">self</span>.<span style="color: black;">CHAR_REPLACEMENT</span>.<span style="color: black;">get</span><span style="color: black;">&#40;</span>key<span style="color: #66cc66;">,</span> key<span style="color: black;">&#41;</span>
        <span style="color: #008000;">self</span><span style="color: black;">&#91;</span>key<span style="color: black;">&#93;</span> <span style="color: #66cc66;">=</span> ch
        <span style="color: #ff7700;font-weight:bold;">return</span> ch
&nbsp;
    <span style="color: #ff7700;font-weight:bold;">if</span> <span style="color: #dc143c;">sys</span>.<span style="color: black;">version</span> &gt<span style="color: #66cc66;">;=</span> <span style="color: #483d8b;">"2.5"</span>:
        <span style="color: #808080; font-style: italic;"># use __missing__ where available</span>
        __missing__ <span style="color: #66cc66;">=</span> mapchar
    <span style="color: #ff7700;font-weight:bold;">else</span>:
        <span style="color: #808080; font-style: italic;"># otherwise, use standard __getitem__ hook (this is slower,</span>
        <span style="color: #808080; font-style: italic;"># since it's called for each character)</span>
        <span style="color: #0000cd;">__getitem__</span> <span style="color: #66cc66;">=</span> mapchar
&nbsp;
<span style="color: #008000;">map</span> <span style="color: #66cc66;">=</span> unaccented_map<span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">def</span> asciify<span style="color: black;">&#40;</span><span style="color: #008000;">input</span><span style="color: black;">&#41;</span>:
	<span style="color: #ff7700;font-weight:bold;">try</span>:
		<span style="color: #ff7700;font-weight:bold;">return</span> <span style="color: #008000;">input</span>.<span style="color: black;">encode</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'ascii'</span><span style="color: black;">&#41;</span>
	<span style="color: #ff7700;font-weight:bold;">except</span> <span style="color: #008000;">AttributeError</span>:
		<span style="color: #ff7700;font-weight:bold;">return</span> <span style="color: #008000;">str</span><span style="color: black;">&#40;</span><span style="color: #008000;">input</span><span style="color: black;">&#41;</span>.<span style="color: black;">encode</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'ascii'</span><span style="color: black;">&#41;</span>
	<span style="color: #ff7700;font-weight:bold;">except</span> <span style="color: #008000;">UnicodeEncodeError</span>:
	        <span style="color: #ff7700;font-weight:bold;">return</span> <span style="color: #dc143c;">unicodedata</span>.<span style="color: black;">normalize</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'NFKD'</span><span style="color: #66cc66;">,</span> <span style="color: #008000;">input</span>.<span style="color: black;">translate</span><span style="color: black;">&#40;</span><span style="color: #008000;">map</span><span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>.<span style="color: black;">encode</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'ascii'</span><span style="color: #66cc66;">,</span> <span style="color: #483d8b;">'replace'</span><span style="color: black;">&#41;</span>
&nbsp;
text <span style="color: #66cc66;">=</span> u<span style="color: #483d8b;">"""
&nbsp;
##Norwegian
"Jo, når'n da ha gått ett stôck te, så kommer'n te e å,
å i åa ä e ö."
"Vasa", sa'n.
"Å i åa ä e ö", sa ja.
"Men va i all ti ä dä ni säjer, a, o?", sa'n.
"D'ä e å, vett ja", skrek ja, för ja ble rasen, "å i åa
ä e ö, hörer han lite, d'ä e å, å i åa ä e ö."
"A, o, ö", sa'n å dämmä geck'en.
Jo, den va nôe te dum den.
&nbsp;
(taken from the short story "Dumt fôlk" in Gustaf Fröding's
"Räggler å paschaser på våra mål tå en bonne" (1895).
&nbsp;
##Danish
&nbsp;
Nu bliver Mølleren sikkert sur, og dog, han er stadig den største på verdensplan.
&nbsp;
Userneeds A/S er en dansk virksomhed, der udfører statistiske undersøgelser på internettet. Den blev etableret i 2001 som et anpartsselskab af David Jensen og Henrik Vincentz.
Frem til 2004 var det primære fokus på at forbedre hjemmesiderne for andre virksomheder. Herefter blev fokus omlagt, så man også beskæftigede sig med statistiske målinger. Ledelsen vurderede, at dette marked ville vokse betragteligt i de kommende år, hvilket man ønskede at udnytte.
Siden omlægningen er der blevet fokuseret på at etablere meget store forbrugerpaneler. Således udgjorde det danske panel i 2005 65.000 personer og omfatter per 2008 100.000 personer.
I 2007 blev Userneeds ApS konverteret til aktieselskabet Userneeds A/S
Efterhånden er aktiviteterne blevet udvidet til de nordiske lande (med undtagelse af Island) og besidder i 2009 et forbrugerpanel med i alt mere end 250.000 personer bosat i de fire store nordiske lande.
Selskabet tegnes udadtil af en direktion på tre personer, der foruden Henrik Vincentz tæller Palle Viby Morgen og Simon Andersen.
De primære konkurrenter er andre analysebureauer som AC Nielsen, Analysedanmark, Gallup, Norstat, Synnovate og Zapera.
&nbsp;
##Finnish
Titus Aurelius Fulvus Boionius Arrius Antoninus eli Antoninus Pius (19. syyskuuta 86 – 7. maaliskuuta 161) oli Rooman keisari vuosina 138–161. Antoninus sai lisänimensä Pius (suom. velvollisuudentuntoinen) noustuaan valtaan vuonna 138. Hän kuului Nerva–Antoninusten hallitsijasukuun ja oli suosittu ja kunnioitettu keisari, joka tunnettiin lempeydestään ja oikeamielisyydestään. Hänen valtakauttaan on usein sanottu Rooman valtakunnan kultakaudeksi, jolloin talous kukoisti, poliittinen tilanne oli vakaa ja armeija vahva. Hän hallitsi pitempään kuin yksikään Rooman keisari Augustuksen jälkeen, ja hänen kautensa tunnetaan erityisen rauhallisena, joskaan ei sodattomana. Antoninus adoptoi Marcus Aureliuksen ja Lucius Veruksen vallanperijöikseen. Hän kuoli vuonna 161.
&nbsp;
#German
So heißt ein altes Märchen: "Der Ehre Dornenpfad", und es handelt von einem Schützen mit Namen Bryde, der wohl zu großen Ehren und Würden kam, aber nicht ohne lange und vielfältige Widerwärtigkeiten und Fährnisse des Lebens durchzumachen. Manch einer von uns hat es gewiß als Kind gehört oder es vielleicht später gelesen und dabei an seinen eigenen stillen Dornenweg und die vielen Widerwärtigkeiten gedacht. Märchen und Wirklichkeit liegen einander so nahe, aber das Märchen hat seine harmonische Lösung hier auf Erden, während die Wirklichkeit sie meist aus dem Erdenleben hinaus in Zeit und Ewigkeit verlegt. 
&nbsp;
12<span style="color: #000099; font-weight: bold;">\x</span>bd inch
"""</span>
&nbsp;
<span style="color: #ff7700;font-weight:bold;">if</span> __name__ <span style="color: #66cc66;">==</span> <span style="color: #483d8b;">"__main__"</span>:
    <span style="color: #ff7700;font-weight:bold;">for</span> i<span style="color: #66cc66;">,</span> line <span style="color: #ff7700;font-weight:bold;">in</span> <span style="color: #008000;">enumerate</span><span style="color: black;">&#40;</span>text.<span style="color: black;">splitlines</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span><span style="color: black;">&#41;</span>:
        line <span style="color: #66cc66;">=</span> line.<span style="color: black;">strip</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span>
        <span style="color: #ff7700;font-weight:bold;">print</span> line
        <span style="color: #ff7700;font-weight:bold;">if</span> line <span style="color: #ff7700;font-weight:bold;">and</span> <span style="color: #ff7700;font-weight:bold;">not</span> line.<span style="color: black;">startswith</span><span style="color: black;">&#40;</span><span style="color: #483d8b;">'#'</span><span style="color: black;">&#41;</span>:
            <span style="color: #ff7700;font-weight:bold;">print</span> <span style="color: #483d8b;">'<span style="color: #000099; font-weight: bold;">\t</span>Trans: '</span><span style="color: #66cc66;">,</span> asciify<span style="color: black;">&#40;</span>line<span style="color: black;">&#41;</span>.<span style="color: black;">strip</span><span style="color: black;">&#40;</span><span style="color: black;">&#41;</span></pre>
      </td>
    </tr>
  </table>
</div>

 [1]: http://sda.berkeley.edu/
 [2]: http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references "Wikipedia: List of HTML character entity references"
 [3]: http://docs.python.org/howto/unicode.html#the-unicode-type
 [4]: http://effbot.python-hosting.com/file/stuff/sandbox/text/unaccent.py