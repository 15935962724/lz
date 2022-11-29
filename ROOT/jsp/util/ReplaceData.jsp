<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.db.DbAdapter" %><%
request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String community=teasession._strCommunity;

/*
if(!teasession._rv.isOrganizer(community))
{
  //response.sendError(403);
  //return;
}
*/

tea.resource.Resource r=new tea.resource.Resource();



%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%//=r.getString(teasession._nLanguage, "Dynamic")%>内容替换</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="POST" action="/servlet/ReplaceData" onSubmit="return submitText(this.find,'查找的内容不能为空');">
<input type="hidden" name="community" value="<%=community%>">
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td>查找:</td><td><textarea name="find" cols="50" rows="5"></textarea></td></tr>
<tr><td>替换:</td><td><textarea name="replace" cols="50" rows="5"></textarea></td></tr>
<tr><td>选项:</td><td><input name="node" type="checkbox" value="1" checked>节点
<input name="listing" type="checkbox" value="" checked>列举
<input name="section" type="checkbox" value="" checked>段落</td></tr>
</table>
<input type=submit name="replacetext" value=提交>
</form>

<h2>获取远程图片</h2>
<form name="form1" method="POST" action="/servlet/ReplaceData" onSubmit="">
<input type="hidden" name="community" value="<%=community%>">
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td>选项:</td>
<td><input name="node" type="checkbox" value="1" checked>节点
<input name="listing" type="checkbox" value="" checked>列举
<input name="section" type="checkbox" value="" checked>段落</td></tr>
</table>
<input type=submit value=提交>
</form>

<div id="head6"><img height="6" src="about:blank"></div>

<!--
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>"查找"框是正则表式</td></tr>
</table>







<div align="left" style="">


正则表达式是<span class=original_words>JDK 1.4</span>的新功能，但是对sed和awk这样的Unix的标准实用工具，以及Python，Perl之类的语言来讲，它早就已经成为其不可或缺的组成部分了(有人甚至认为，它还是Perl能大获成功的最主要的原因)。单从技术角度来讲，正则表达式只是一种处理字符串的工具(过去<span class=original_words>Java</span>这个任务是交由<span class=original_words>String</span>，<span class=original_words>StringBuffer</span>以及<span class=original_words>StringTokenizer</span>处理的)，但是它常常和I/O一起使用，所以放到这里来讲也不算太离题吧。<a id="ref66" href="#comment66"><sup>[66]</sup></a></p>

<p>正则表达式是一种功能强大但又非常灵活的文本处理工具。它能让你用编程的方式来描述复杂的文本模式，然后在字符串里把它找出来。一旦你找到了这种模式，你就能随心所欲地处理这些文本了。虽然初看起来正则表达式的语法有点让人望而生畏，但它提供了一种精练的动态语言，使我们能用一种通用的方式来解决各种字符串的问题，包括匹配，选择，编辑以及校验。</p>
<h3 id=header56>创建正则表达式</h3>

<p>你可以从比较简单的东西入手学习正则表达式。要想全面地掌握怎样构建正则表达式，可以去看<span class=original_words>JDK</span>文档的<span class=original_words>java.util.regex</span>的<span class=original_words>Pattern</span>类的文档。</p>

<table border=2 cellspacing=0 cellpadding=2 bordercolorlight='black' bordercolordark='black' class=narration>
	<tr>
		<th colspan=2>字符</th>
	</tr>
	<tr>
		<td><span class=original_words>B</span></td>
		<td>字符<span class=original_words>B</span></td>
	</tr>
	<tr>
		<td><span class=original_words>\xhh</span></td>
		<td>16进制值<span class=original_words>0xhh</span>所表示的字符</td>
	</tr>
	<tr>
		<td><span class=original_words>\uhhhh</span></td>
		<td>16进制值<span class=original_words>0xhhhh</span>所表示的Unicode字符</td>
	</tr>
	<tr>
		<td><span class=original_words>\t</span></td>
		<td>Tab</td>
	</tr>
	<tr>
		<td><span class=original_words>\n</span></td>
		<td>换行符</td>
	</tr>
	<tr>
		<td><span class=original_words>\r</span></td>
		<td>回车符</td>
	</tr>
	<tr>
		<td><span class=original_words>\f</span></td>
		<td>换页符</td>
	</tr>
	<tr>
		<td><span class=original_words>\e</span></td>
		<td>Escape</td>
	</tr>
</table>

<p>正则表达式的强大体现在它能定义字符集(character class)。下面是一些最常见的字符集及其定义的方式，此外还有一些预定义的字符集：</p>
<table border=2 cellspacing=0 cellpadding=2 bordercolorlight='black' bordercolordark='black' class=narration>
	<TR vAlign=top>
		<TH colSpan=2>
			<span class=original_words>字符集</span>
		</TH>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top>
			<span class=original_words>.</span>
		</TD>
		<TD vAlign=top>
			表示任意一个字符
		</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>[abc]</span>
		<TD vAlign=top width=311>
			表示字符<span class=original_words>a</span>，<span class=original_words>b</span>，<span class=original_words>c</span>中的任意一个(与<span class=original_words>a|b|c</span>相同)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>[^abc]</span>
		<TD vAlign=top width=311>
			除<span class=original_words>a</span>，<span class=original_words>b</span>，<span class=original_words>c</span>之外的任意一个字符(否定)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>[a-zA-Z]</span>
		<TD vAlign=top width=311>
			从<span class=original_words>a</span>到<span class=original_words>z</span>或<span class=original_words>A</span>到<span class=original_words>Z</span>当中的任意一个字符(范围)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>[abc[hij]]</span>
		<TD vAlign=top width=311>
			<span class=original_words>a,b,c,h,i,j</span>中的任意一个字符(与<span class=original_words>a|b|c|h|i|j</span>相同)(并集)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>[a-z&amp;&amp;[hij]]</span>
		</TD>
		<TD vAlign=top width=311>
			<span class=original_words>h,i,j</span>中的一个(交集)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>\s</span>
		</TD>
		<TD vAlign=top width=311>
			空格字符(空格键, tab, 换行, 换页, 回车)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>\S</span>
		<TD vAlign=top width=311>
			非空格字符(<span class=original_words>[^\s]</span>)
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>\d</span>
		</TD>
		<TD vAlign=top width=311>
			一个数字，也就是<span class=original_words>[0-9]</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>\D</span>
		</TD>
		<TD vAlign=top width=311>
			一个非数字的字符，也就是<span class=original_words>[^0-9]</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>\w</span>
		</TD>
		<TD vAlign=top width=311>
			一个单词字符(word character)，即<span class=original_words>[a-zA-Z_0-9]</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=131>
			<span class=original_words>\W</span>
		<TD vAlign=top width=311>
			一个非单词的字符，<span class=original_words>[^\w]</span>
		</TD>
	</TR>
</table>

<p>如果你用过其它语言的正则表达式，那么你一眼就能看出反斜杠的与众不同。在其它语言里，"<span class=original_words>\\</span>"的意思是"我只是要在正则表达式里插入一个反斜杠。没什么特别的意思。"但是在Java里，"<span class=original_words>\\</span>"的意思是"我要插入一个正则表达式的反斜杠，所以跟在它后面的那个字符的意思就变了。"举例来说，如果你想表示一个或更多的"单词字符"，那么这个正则表达式就应该是"<span class=original_words>\\w+</span>"。如果你要插入一个反斜杠，那就得用"<span class=original_words>\\\\</span>"。不过像换行，跳格之类的还是只用一根反斜杠："\n\t"。</p>

<p>这里只给你讲一个例子；你应该<span class=original_words>JDK</span>文档的<span class=original_words>java.util.regex.Pattern</span>加到收藏夹里，这样就能很容易地找到各种正则表达式的模式了。</p>

<table border=2 cellspacing=0 cellpadding=2 bordercolorlight='black' bordercolordark='black' class=narration>
	<tr>
		<th colspan=2>
			逻辑运算符
		</th>
	</tr>
	<tr>
		<td>XY</td>
		<td>X 后面跟着 Y</td>
	</tr>
	<tr>
		<td>X|Y</td>
		<td>X或Y</td>
	</tr>
	<tr>
		<td>(X)</td>
		<td>一个"要匹配的组(capturing group)". 以后可以用\i来表示第i个被匹配的组。</td>
	</tr>
</table>
<p></p>
<table border=2 cellspacing=0 cellpadding=2 bordercolorlight='black' bordercolordark='black' class=narration>
	<TR vAlign=top>
		<TH vAlign=top width=383 colSpan=2>
			边界匹配符
		</TH>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=143>
			<span class=original_words>^</span>
		</TD>
		<TD vAlign=top width=239>
			一行的开始
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=143>
			<span class=original_words>$</span>
		</TD>
		<TD vAlign=top width=239>
			一行的结尾
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=143>
			<span class=original_words>\b</span>
		</TD>
		<TD vAlign=top width=239>
			一个单词的边界
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=143>
			<span class=original_words>\B</span>
		</TD>
		<TD vAlign=top width=239>
			一个非单词的边界
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=143>
			<span class=original_words>\G</span>
		</TD>
		<TD vAlign=top width=239>
			前一个匹配的结束
		</TD>
	</TR>
</table>

<p>举一个具体一些的例子。下面这些正则表达式都是合法的，而且都能匹配"Rudolph"：</p>
<blockquote><pre>Rudolph
[rR]udolph
[rR][aeiou][a-z]ol.*
R.*</pre></blockquote>
<h3 id=header57>数量表示符</h3>

<p>"数量表示符(quantifier)"的作用是定义模式应该匹配多少个字符。</p>
<ul>
  <li>Greedy(贪婪的)：

除非另有表示，否则数量表示符都是greedy的。Greedy的表达式会一直匹配下去，直到匹配不下去为止。<u>(如果你发现表达式匹配的结果与预期的不符)</u>，很有可能是因为，你以为表达式会只匹配前面几个字符，而实际上它是greedy的，因此会一直匹配下去。</li>
  <li>Reluctant(勉强的)：

用问号表示，它会匹配最少的字符。也称为lazy, minimal matching, non-greedy, 或ungreedy。</li>
  <li>Possessive(占有的)：

目前只有Java支持(其它语言都不支持)。它更加先进，所以你可能还不太会用。用正则表达式匹配字符串的时候会产生很多中间状态，<u>(一般的匹配引擎会保存这种中间状态，)</u>这样匹配失败的时候就能原路返回了。占有型的表达式不保存这种中间状态，因此也就不会回头重来了。它能防止正则表达式的失控，同时也能提高运行的效率。</li>
</ul>
<table border=2 cellspacing=0 cellpadding=2 bordercolorlight='black' bordercolordark='black' class=narration>
	<TR vAlign=top>
		<TH>
			<span class=original_words>Greedy</span>
		</TH>
		<TH>
			<span class=original_words>Reluctant</span>
		</TH>
		<TH>
			<span class=original_words>Possessive</span>
		</TH>
		<TH>
			匹配
		</TH>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=71>
			<span class=original_words>X?</span>
		</TD>
		<TD vAlign=top width=86>
			<span class=original_words>X??</span>
		</TD>
		<TD vAlign=top width=93>
			<span class=original_words>X?+</span>
		</TD>
		<TD vAlign=top width=231>
			匹配一个或零个<span class=original_words>X</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=71>
			<span class=original_words>X*</span>
		</TD>
		<TD vAlign=top width=86>
			<span class=original_words>X*?</span>
		</TD>
		<TD vAlign=top width=93>
			<span class=original_words>X*+</span>
		</TD>
		<TD vAlign=top width=231>
			匹配零或多个<span class=original_words>X</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=71>
			<span class=original_words>X+</span>
		</TD>
		<TD vAlign=top width=86>
			<span class=original_words>X+?</span>
		</TD>
		<TD vAlign=top width=93>
			<span class=original_words>X++</span>
		</TD>
		<TD vAlign=top width=231>
			匹配一个或多个<span class=original_words>X</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=71>
			<span class=original_words>X{n}</span>
		</TD>
		<TD vAlign=top width=86>
			<span class=original_words>X{n}?</span>
		</TD>
		<TD vAlign=top width=93>
			<span class=original_words>X{n}+</span>
		</TD>
		<TD vAlign=top width=231>
			匹配正好n个<span class=original_words>X</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=71>
			<span class=original_words>X{n,}</span>
		</TD>
		<TD vAlign=top width=86>
			<span class=original_words>X{n,}?</span>
		</TD>
		<TD vAlign=top width=93>
			<span class=original_words>X{n,}+</span>
		</TD>
		<TD vAlign=top width=231>
			匹配至少n个<span class=original_words>X</span>
		</TD>
	</TR>
	<TR vAlign=top>
		<TD vAlign=top width=71>
			<span class=original_words>X{n,m}</span>
		</TD>
		<TD vAlign=top width=86>
			<span class=original_words>X{n,m}?</span>
		</TD>
		<TD vAlign=top width=93>
			<span class=original_words>X{n,m}+</span>
		</TD>
		<TD vAlign=top width=231>
			匹配至少n个，至多m个<span class=original_words>X</span>
		</TD>
	</TR>
</table>

<p>再提醒一下，要想让表达式照你的意思去运行，你应该用括号把'X'括起来。比方说：</p>
<blockquote><PRE>abc+</PRE></blockquote>

<p>似乎这个表达式能匹配一个或若干个'abc'，但是如果你真的用它去匹配'abcabcabc'的话，实际上只会找到三个字符。因为这个表达式的意思是'ab'后边跟着一个或多个'c'。要想匹配一个或多个完整的'abc'，你应该这样：</p>
<blockquote><pre>(abc)+</pre></blockquote>

<p>正则表达式能轻而易举地把你给耍了；这是一种建立在<span class=original_words>Java</span>之上的新语言。</p>
<h4 id=header58>CharSequence</h4>

<p>JDK 1.4定义了一个新的接口，叫<span class=original_words>CharSequence</span>。它提供了<span class=original_words>String</span>和<span class=original_words>StringBuffer</span>这两个类的字符序列的抽象：</p>
<blockquote><PRE><FONT color=#0000ff>interface</FONT> CharSequence {
  charAt(<FONT color=#0000ff>int</FONT> i);
  length();
  subSequence(<FONT color=#0000ff>int</FONT> start, <FONT color=#0000ff>int</FONT> end);
  toString();
}</PRE></blockquote>

<p>为了实现这个新的<span class=original_words>CharSequence</span>接口，<span class=original_words>String</span>，<span class=original_words>StringBuffer</span>以及<span class=original_words>CharBuffer</span>都作了修改。很多正则表达式的操作都要拿<span class=original_words>CharSequence</span>作参数。</p>
<h3 id=header59><span class=original_words>Pattern</span>和<span class=original_words>Matcher</span></h3>

<p>先给一个例子。下面这段程序可以测试正则表达式是否匹配字符串。第一个参数是要匹配的字符串，后面是正则表达式。正则表达式可以有多个。在Unix/Linux环境下，命令行下的正则表达式还必须用引号。</p>


<p>当你创建正则表达式时，可以用这个程序来判断它是不是会按照你的要求工作。</p>
<blockquote>
<PRE><FONT color=#009900>//: c12:TestRegularExpression.java</FONT>
<FONT color=#009900>// Allows you to easly try out regular expressions.</FONT>
<FONT color=#009900>// {Args: abcabcabcdefabc "abc+" "(abc)+" "(abc){2,}" }</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> TestRegularExpression {
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    <FONT color=#0000ff>if</FONT>(args.length &lt; 2) {
      System.out.println(<FONT color=#004488>"Usage:\n"</FONT> +
        <FONT color=#004488>"java TestRegularExpression "</FONT> +
        <FONT color=#004488>"characterSequence regularExpression+"</FONT>);
      System.exit(0);
    }
    System.out.println(<FONT color=#004488>"Input: \"</FONT><FONT color=#004488>" + args[0] + "</FONT>\<FONT color=#004488>""</FONT>);
    <FONT color=#0000ff>for</FONT>(<FONT color=#0000ff>int</FONT> i = 1; i &lt; args.length; i++) {
      System.out.println(
        <FONT color=#004488>"Regular expression: \"</FONT><FONT color=#004488>" + args[i] + "</FONT>\<FONT color=#004488>""</FONT>);
      Pattern p = Pattern.compile(args[i]);
      Matcher m = p.matcher(args[0]);
      <FONT color=#0000ff>while</FONT>(m.find()) {
        System.out.println(<FONT color=#004488>"Match \"</FONT>" + m.group() +
          <FONT color=#004488>"\"</FONT> at positions " +
          m.start() + <FONT color=#004488>"-"</FONT> + (m.end() - 1));
      }
    }
  }
} <FONT color=#009900>///:~</FONT></PRE>
</blockquote>

<p><span class=original_words>Java</span>的正则表达式是由<span class=original_words>java.util.regex</span>的<span class=original_words>Pattern</span>和<span class=original_words>Matcher</span>类实现的。<span class=original_words>Pattern</span>对象表示经编译的正则表达式。静态的<span class=original_words>compile( )</span>方法负责将表示正则表达式的字符串编译成<span class=original_words>Pattern</span>对象。正如上述例程所示的，只要给<span class=original_words>Pattern</span>的<span class=original_words>matcher( )</span>方法送一个字符串就能获取一个<span class=original_words>Matcher</span>对象。此外，<span class=original_words>Pattern</span>还有一个能快速判断能否在<span class=original_words>input</span>里面找到<span class=original_words>regex</span>的(注意，原文有误，漏了方法名)</p>
<blockquote><pre><FONT color=#0000ff>static</FONT> <FONT color=#0000ff>boolean</FONT> matches(&nbsp;regex, &nbsp;input)</pre></blockquote>

<p>以及能返回<span class=original_words>String</span>数组的<span class=original_words>split( )</span>方法，它能用<span class=original_words>regex</span>把字符串分割开来。</p>

<p>只要给<span class=original_words>Pattern.matcher( )</span>方法传一个字符串就能获得<span class=original_words>Matcher</span>对象了。接下来就能用<span class=original_words>Matcher</span>的方法来查询匹配的结果了。</p>
<blockquote><PRE><FONT color=#0000ff>boolean</FONT> matches()
<FONT color=#0000ff>boolean</FONT> lookingAt()
<FONT color=#0000ff>boolean</FONT> find()
<FONT color=#0000ff>boolean</FONT> find(<FONT color=#0000ff>int</FONT> start)</PRE></blockquote>

<p><span class=original_words>matches( )</span>的前提是<span class=original_words>Pattern</span>匹配整个字符串，而<span class=original_words>lookingAt( )</span>的意思是<span class=original_words>Pattern</span>匹配字符串的开头。
</p>
<h4 id=header60>find( )</h4>

<p><span class=original_words>Matcher.find( )</span>的功能是发现<span class=original_words>CharSequence</span>里的，与pattern相匹配的多个字符序列。例如：</p>

<blockquote>
<PRE><FONT color=#009900>//: c12:FindDemo.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>import</FONT> java.util.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> FindDemo {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    Matcher m = Pattern.compile(<FONT color=#004488>"\\w+"</FONT>)
      .matcher(<FONT color=#004488>"Evening is full of the linnet's wings"</FONT>);
    <FONT color=#0000ff>while</FONT>(m.find())
      System.out.println(m.group());
    <FONT color=#0000ff>int</FONT> i = 0;
    <FONT color=#0000ff>while</FONT>(m.find(i)) {
      System.out.print(m.group() + <FONT color=#004488>" "</FONT>);
      i++;
    }
    monitor.expect(<FONT color=#0000ff>new</FONT> String[] {
      <FONT color=#004488>"Evening"</FONT>,
      <FONT color=#004488>"is"</FONT>,
      <FONT color=#004488>"full"</FONT>,
      <FONT color=#004488>"of"</FONT>,
      <FONT color=#004488>"the"</FONT>,
      <FONT color=#004488>"linnet"</FONT>,
      <FONT color=#004488>"s"</FONT>,
      <FONT color=#004488>"wings"</FONT>,
      <FONT color=#004488>"Evening vening ening ning ing ng g is is s full "</FONT> +
      <FONT color=#004488>"full ull ll l of of f the the he e linnet linnet "</FONT> +
      <FONT color=#004488>"innet nnet net et t s s wings wings ings ngs gs s "</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
  </blockquote>


<p>"<span class=original_words>\\w+</span>"的意思是"一个或多个单词字符"，因此它会将字符串直接分解成单词。<span class=original_words>find( )</span>像一个迭代器，从头到尾扫描一遍字符串。第二个<span class=original_words>find( )</span>是带<span class=original_words>int</span>参数的，正如你所看到的，它会告诉方法从哪里开始找——即从参数位置开始查找。</p>

<h4 id=header61>Groups</h4>

<p>Group是指里用括号括起来的，能被后面的表达式调用的正则表达式。Group 0 表示整个表达式，group 1表示第一个被括起来的group，以此类推。所以；</p>
<blockquote><PRE>A(B(C))D</PRE></blockquote>
<p>里面有三个group：group 0是<span class=original_words>ABCD</span>， group 1是<span class=original_words>BC</span>，group 2是<span class=original_words>C</span>。</p>

<p>你可以用下述<span class=original_words>Matcher</span>方法来使用group：</p>

<p><span class=original_words>public int groupCount( )</span>返回matcher对象中的group的数目。不包括group0。</p>


<p><span class=original_words>public String group( ) </span>返回上次匹配操作(比方说<span class=original_words>find( )</span>)的group 0(整个匹配)</p>


<p><span class=original_words>public String group(int i)</span>返回上次匹配操作的某个group。如果匹配成功，但是没能找到group，则返回null。</p>


<p><span class=original_words>public int start(int group)</span>返回上次匹配所找到的，group的开始位置。</p>


<p><span class=original_words>public int end(int group)</span>返回上次匹配所找到的，group的结束位置，最后一个字符的下标加一。</p>


<p>下面我们举一些group的例子：</p>
<blockquote>
<PRE><FONT color=#009900>//: c12:Groups.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> Groups {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>final</FONT> String poem =
    <FONT color=#004488>"Twas brillig, and the slithy toves\n"</FONT> +
    <FONT color=#004488>"Did gyre and gimble in the wabe.\n"</FONT> +
    <FONT color=#004488>"All mimsy were the borogoves,\n"</FONT> +
    <FONT color=#004488>"And the mome raths outgrabe.\n\n"</FONT> +
    <FONT color=#004488>"Beware the Jabberwock, my son,\n"</FONT> +
    <FONT color=#004488>"The jaws that bite, the claws that catch.\n"</FONT> +
    <FONT color=#004488>"Beware the Jubjub bird, and shun\n"</FONT> +
    <FONT color=#004488>"The frumious Bandersnatch."</FONT>;
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    Matcher m =
      Pattern.compile(<FONT color=#004488>"(?m)(\\S+)\\s+((\\S+)\\s+(\\S+))$"</FONT>)
        .matcher(poem);
    <FONT color=#0000ff>while</FONT>(m.find()) {
      <FONT color=#0000ff>for</FONT>(<FONT color=#0000ff>int</FONT> j = 0; j &lt;= m.groupCount(); j++)
        System.out.print(<FONT color=#004488>"["</FONT> + m.group(j) + <FONT color=#004488>"]"</FONT>);
      System.out.println();
    }
    monitor.expect(<FONT color=#0000ff>new</FONT> String[]{
      <FONT color=#004488>"[the slithy toves]"</FONT> +
      <FONT color=#004488>"[the][slithy toves][slithy][toves]"</FONT>,
      <FONT color=#004488>"[in the wabe.][in][the wabe.][the][wabe.]"</FONT>,
      <FONT color=#004488>"[were the borogoves,]"</FONT> +
      <FONT color=#004488>"[were][the borogoves,][the][borogoves,]"</FONT>,
      <FONT color=#004488>"[mome raths outgrabe.]"</FONT> +
      <FONT color=#004488>"[mome][raths outgrabe.][raths][outgrabe.]"</FONT>,
      <FONT color=#004488>"[Jabberwock, my son,]"</FONT> +
      <FONT color=#004488>"[Jabberwock,][my son,][my][son,]"</FONT>,
      <FONT color=#004488>"[claws that catch.]"</FONT> +
      <FONT color=#004488>"[claws][that catch.][that][catch.]"</FONT>,
      <FONT color=#004488>"[bird, and shun][bird,][and shun][and][shun]"</FONT>,
      <FONT color=#004488>"[The frumious Bandersnatch.][The]"</FONT> +
      <FONT color=#004488>"[frumious Bandersnatch.][frumious][Bandersnatch.]"</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
  </blockquote>

<p>这首诗是<span class=original_words><cite>Through the Looking Glass</cite></span>的，Lewis Carroll的"Jabberwocky"的第一部分。可以看到这个正则表达式里有很多用括号括起来的group，它是由任意多个连续的非空字符('<span class=original_words>\S+</span>')和任意多个连续的空格字符('<span class=original_words>\s+</span>')所组成的，其最终目的是要捕获每行的最后三个单词；'<span class=original_words>$</span>'表示一行的结尾。但是'<span class=original_words>$</span>'通常表示整个字符串的结尾，所以这里要明确地告诉正则表达式注意换行符。这一点是由'<span class=original_words>(?m)</span>'标志完成的(模式标志会过一会讲解)。</p>
<h4 id=header62>start( )和end( )</h4>

<p>如果匹配成功，<span class=original_words>start( )</span>会返回此次匹配的开始位置，<span class=original_words>end( )</span>会返回此次匹配的结束位置，即最后一个字符的下标加一。如果之前的匹配不成功(或者没匹配)，那么无论是调用<span class=original_words>start( )</span>还是<span class=original_words>end( )</span>，都会引发一个<span class=original_words>IllegalStateException</span>。下面这段程序还演示了<span class=original_words>matches( )</span>和<span class=original_words>lookingAt( )</span>：</p>
<blockquote>
<PRE><FONT color=#009900>//: c12:StartEnd.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> StartEnd {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    String[] input = <FONT color=#0000ff>new</FONT> String[] {
      <FONT color=#004488>"Java has regular expressions in 1.4"</FONT>,
      <FONT color=#004488>"regular expressions now expressing in Java"</FONT>,
      <FONT color=#004488>"Java represses oracular expressions"</FONT>
    };
    Pattern
      p1 = Pattern.compile(<FONT color=#004488>"re\\w*"</FONT>),
      p2 = Pattern.compile(<FONT color=#004488>"Java.*"</FONT>);
    <FONT color=#0000ff>for</FONT>(<FONT color=#0000ff>int</FONT> i = 0; i &lt; input.length; i++) {
      System.out.println(<FONT color=#004488>"input "</FONT> + i + <FONT color=#004488>": "</FONT> + input[i]);
      Matcher
        m1 = p1.matcher(input[i]),
        m2 = p2.matcher(input[i]);
      <FONT color=#0000ff>while</FONT>(m1.find())
        System.out.println(<FONT color=#004488>"m1.find() '"</FONT> + m1.group() +
          <FONT color=#004488>"' start = "</FONT>+ m1.start() + <FONT color=#004488>" end = "</FONT> + m1.end());
      <FONT color=#0000ff>while</FONT>(m2.find())
        System.out.println(<FONT color=#004488>"m2.find() '"</FONT> + m2.group() +
          <FONT color=#004488>"' start = "</FONT>+ m2.start() + <FONT color=#004488>" end = "</FONT> + m2.end());
      <FONT color=#0000ff>if</FONT>(m1.lookingAt()) <FONT color=#009900>// No reset() necessary</FONT>
        System.out.println(<FONT color=#004488>"m1.lookingAt() start = "</FONT>
          + m1.start() + <FONT color=#004488>" end = "</FONT> + m1.end());
      <FONT color=#0000ff>if</FONT>(m2.lookingAt())
        System.out.println(<FONT color=#004488>"m2.lookingAt() start = "</FONT>
          + m2.start() + <FONT color=#004488>" end = "</FONT> + m2.end());
      <FONT color=#0000ff>if</FONT>(m1.matches()) <FONT color=#009900>// No reset() necessary</FONT>
        System.out.println(<FONT color=#004488>"m1.matches() start = "</FONT>
          + m1.start() + <FONT color=#004488>" end = "</FONT> + m1.end());
      <FONT color=#0000ff>if</FONT>(m2.matches())
        System.out.println(<FONT color=#004488>"m2.matches() start = "</FONT>
          + m2.start() + <FONT color=#004488>" end = "</FONT> + m2.end());
    }
    monitor.expect(<FONT color=#0000ff>new</FONT> String[] {
      <FONT color=#004488>"input 0: Java has regular expressions in 1.4"</FONT>,
      <FONT color=#004488>"m1.find() 'regular' start = 9 end = 16"</FONT>,
      <FONT color=#004488>"m1.find() 'ressions' start = 20 end = 28"</FONT>,
      <FONT color=#004488>"m2.find() 'Java has regular expressions in 1.4'"</FONT> +
      <FONT color=#004488>" start = 0 end = 35"</FONT>,
      <FONT color=#004488>"m2.lookingAt() start = 0 end = 35"</FONT>,
      <FONT color=#004488>"m2.matches() start = 0 end = 35"</FONT>,
      <FONT color=#004488>"input 1: regular expressions now "</FONT> +
      <FONT color=#004488>"expressing in Java"</FONT>,
      <FONT color=#004488>"m1.find() 'regular' start = 0 end = 7"</FONT>,
      <FONT color=#004488>"m1.find() 'ressions' start = 11 end = 19"</FONT>,
      <FONT color=#004488>"m1.find() 'ressing' start = 27 end = 34"</FONT>,
      <FONT color=#004488>"m2.find() 'Java' start = 38 end = 42"</FONT>,
      <FONT color=#004488>"m1.lookingAt() start = 0 end = 7"</FONT>,
      <FONT color=#004488>"input 2: Java represses oracular expressions"</FONT>,
      <FONT color=#004488>"m1.find() 'represses' start = 5 end = 14"</FONT>,
      <FONT color=#004488>"m1.find() 'ressions' start = 27 end = 35"</FONT>,
      <FONT color=#004488>"m2.find() 'Java represses oracular expressions' "</FONT> +
      <FONT color=#004488>"start = 0 end = 35"</FONT>,
      <FONT color=#004488>"m2.lookingAt() start = 0 end = 35"</FONT>,
      <FONT color=#004488>"m2.matches() start = 0 end = 35"</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
  </blockquote>

<p>注意，只要字符串里有这个模式，<span class=original_words>find( )</span>就能把它给找出来，但是<span class=original_words>lookingAt( )</span>和<span class=original_words>matches( )</span>，只有在字符串与正则表达式一开始就相匹配的情况下才能返回<span class=original_words>true</span>。<span class=original_words>matches( )</span>成功的前提是正则表达式与字符串完全匹配，而<span class=original_words>lookingAt( )</span><a id="ref67" href="#comment67"><sup>[67]</sup></a>成功的前提是，字符串的开始部分与正则表达式相匹配。</p>
<h4 id=header63>匹配的模式(Pattern flags)</h4>

<p><span class=original_words>compile( )</span>方法还有一个版本，它需要一个控制正则表达式的匹配行为的参数：</p>
<blockquote><pre>Pattern Pattern.compile(String regex, <FONT color=#0000ff>int</FONT> flag)</pre></blockquote>

<span class=original_words>flag</span>的取值范围如下：
<table border=2 cellspacing=0 cellpadding=2 bordercolorlight='black' bordercolordark='black' class=narration>
	<tr>
		<th>
			<span class=original_words>编译标志</span>
		</th>
		<th>
			<span class=original_words>效果</span>
		</th>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.CANON_EQ</span>
		</td>
		<td>当且仅当两个字符的"正规分解(canonical decomposition)"都完全相同的情况下，才认定匹配。比如用了这个标志之后，表达式"a\u030A"会匹配"?"。默认情况下，不考虑"规范相等性(canonical equivalence)"。
		</td>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.CASE_INSENSITIVE<br>(?i)</span>
		</td>
		<td>

默认情况下，大小写不明感的匹配只适用于US-ASCII字符集。这个标志能让表达式忽略大小写进行匹配。要想对Unicode字符进行大小不明感的匹配，只要将<span class=original_words>UNICODE_CASE</span>与这个标志合起来就行了。
		</td>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.COMMENTS<br>(?x)</span>
		</td>
		<td>

在这种模式下，匹配时会忽略(正则表达式里的)空格字符(译者注：不是指表达式里的"\\s"，而是指表达式里的空格，tab，回车之类)。注释从#开始，一直到这行结束。可以通过嵌入式的标志来启用Unix行模式。
		</td>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.DOTALL<br>(?s)</span>
		</td>
		<td>

在这种模式下，表达式'.'可以匹配任意字符，包括表示一行的结束符。默认情况下，表达式'.'不匹配行的结束符。
		</td>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.MULTILINE<br>(?m)</span>
		</td>
		<td>

在这种模式下，'^'和'$'分别匹配一行的开始和结束。此外，'^'仍然匹配字符串的开始，'$'也匹配字符串的结束。默认情况下，这两个表达式仅仅匹配字符串的开始和结束。
		</td>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.UNICODE_CASE<br>(?u)</span>
		</td>
		<td>

在这个模式下，如果你还启用了<span class=original_words>CASE_INSENSITIVE</span>标志，那么它会对Unicode字符进行大小写不明感的匹配。默认情况下，大小写不明感的匹配只适用于US-ASCII字符集。
		</td>
	</tr>
	<tr>
		<td>
			<span class=original_words>Pattern.UNIX_LINES<br>(?d)</span>
		</td>
		<td>

在这个模式下，只有'\n'才被认作一行的中止，并且与'.'，'^'，以及'$'进行匹配。
		</td>
	</tr>
</table>

<p>在这些标志里面，<span class=original_words>Pattern.CASE_INSENSITIVE</span>，<span class=original_words>Pattern.MULTILINE</span>，以及<span class=original_words>Pattern.COMMENTS</span>是最有用的(其中<span class=original_words>Pattern.COMMENTS</span>还能帮我们把思路理清楚，并且/或者做文档)。注意，你可以用在表达式里插记号的方式来启用绝大多数的模式。这些记号就在上面那张表的各个标志的下面。你希望模式从哪里开始启动，就在哪里插记号。</p>

<p>可以用"OR" ('|')运算符把这些标志合使用：</p>
<blockquote>
<PRE><FONT color=#009900>//: c12:ReFlags.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> ReFlags {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    Pattern p =  Pattern.compile(<FONT color=#004488>"^java"</FONT>,
      Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
    Matcher m = p.matcher(
      <FONT color=#004488>"java has regex\nJava has regex\n"</FONT> +
      <FONT color=#004488>"JAVA has pretty good regular expressions\n"</FONT> +
      <FONT color=#004488>"Regular expressions are in Java"</FONT>);
    <FONT color=#0000ff>while</FONT>(m.find())
      System.out.println(m.group());
    monitor.expect(<FONT color=#0000ff>new</FONT> String[] {
      <FONT color=#004488>"java"</FONT>,
      <FONT color=#004488>"Java"</FONT>,
      <FONT color=#004488>"JAVA"</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
  </blockquote>

<p>这样创建出来的正则表达式就能匹配以"java"，"Java"，"JAVA"...开头的字符串了。此外，如果字符串分好几行，那它还会对每一行做匹配(匹配始于字符序列的开始，终于字符序列当中的行结束符)。注意，<span class=original_words>group( )</span>方法仅返回匹配的部分。</p>
<h3 id=header64>split( )</h3>

<p>所谓分割是指将以正则表达式为界，将字符串分割成<span class=original_words>String</span>数组。</p>
<blockquote><pre>String[] split(CharSequence charseq)
String[] split(CharSequence charseq, <FONT color=#0000ff>int</FONT> limit)</pre></blockquote>

<p>这是一种既快又方便地将文本根据一些常见的边界标志分割开来的方法。</p>
<table class=code><td>
<PRE><FONT color=#009900>//: c12:SplitDemo.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>import</FONT> java.util.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> SplitDemo {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    String input =
      <FONT color=#004488>"This!!unusual use!!of exclamation!!points"</FONT>;
    System.out.println(Arrays.asList(
      Pattern.compile(<FONT color=#004488>"!!"</FONT>).split(input)));
    <FONT color=#009900>// Only do the first three:</FONT>
    System.out.println(Arrays.asList(
      Pattern.compile(<FONT color=#004488>"!!"</FONT>).split(input, 3)));
    System.out.println(Arrays.asList(
      <FONT color=#004488>"Aha! String has a split() built in!"</FONT>.split(<FONT color=#004488>" "</FONT>)));
    monitor.expect(<FONT color=#0000ff>new</FONT> String[] {
      <FONT color=#004488>"[This, unusual use, of exclamation, points]"</FONT>,
      <FONT color=#004488>"[This, unusual use, of exclamation!!points]"</FONT>,
      <FONT color=#004488>"[Aha!, String, has, a, split(), built, in!]"</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
</td></table>

<p>第二个<span class=original_words>split( )</span>会限定分割的次数。</p>

<p>正则表达式是如此重要，以至于有些功能被加进了<span class=original_words>String</span>类，其中包括<span class=original_words>split( )</span>(已经看到了)，<span class=original_words>matches( )</span>，<span class=original_words>replaceFirst( )</span>以及<span class=original_words>replaceAll( )</span>。这些方法的功能同<span class=original_words>Pattern</span>和<span class=original_words>Matcher</span>的相同。 </p>

<h3 id=header65>替换操作</h3>

<p>正则表达式在替换文本方面特别在行。下面就是一些方法：</p>
<p><span class=original_words>replaceFirst(String replacement)</span>将字符串里，第一个与模式相匹配的子串替换成<span class=original_words>replacement</span>。 </p>
<p><span class=original_words>replaceAll(String replacement)</span>，将输入字符串里所有与模式相匹配的子串全部替换成<span class=original_words>replacement</span>。</p>

<p><span class=original_words>appendReplacement(StringBuffer sbuf, String replacement)</span>对<span class=original_words>sbuf</span>进行逐次替换，而不是像<span class=original_words>replaceFirst( )</span>或<span class=original_words>replaceAll( )</span>那样，只替换第一个或全部子串。这是个非常重要的方法，因为它可以调用方法来生成<span class=original_words>replacement</span>(<span class=original_words>replaceFirst( )</span>和<span class=original_words>replaceAll( )</span>只允许用固定的字符串来充当<span class=original_words>replacement</span>)。有了这个方法，你就可以编程区分group，从而实现更强大的替换功能。</p>

<p>调用完<span class=original_words>appendReplacement( )</span>之后，为了把剩余的字符串拷贝回去，必须调用<span class=original_words>appendTail(StringBuffer sbuf, String replacement)</span>。

<p>下面我们来演示一下怎样使用这些替换方法。说明一下，这段程序所处理的字符串是它自己开头部分的注释，是用正则表达式提取出来并加以处理之后再传给替换方法的。</p>
<blockquote>
<PRE><FONT color=#009900>//: c12:TheReplacements.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> java.io.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.util.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#009900>/*! Here's a block of text to use as input to
    the regular expression matcher. Note that we'll
    first extract the block of text by looking for
    the special delimiters, then process the
    extracted block. !*/</FONT>
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> TheReplacements {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) <FONT color=#0000ff>throws</FONT> Exception {
    String s = TextFile.read(<FONT color=#004488>"TheReplacements.java"</FONT>);
    <FONT color=#009900>// Match the specially-commented block of text above:</FONT>
    Matcher mInput =
      Pattern.compile(<FONT color=#004488>"</FONT><FONT color=#004488>/\\*!(.*)!\\*</FONT><FONT color=#004488>/"</FONT>, Pattern.DOTALL)
        .matcher(s);
    <FONT color=#0000ff>if</FONT>(mInput.find())
      s = mInput.group(1); <FONT color=#009900>// Captured by parentheses</FONT>
    <FONT color=#009900>// Replace two or more spaces with a single space:</FONT>
    s = s.replaceAll(<FONT color=#004488>" {2,}"</FONT>, <FONT color=#004488>" "</FONT>);
    <FONT color=#009900>// Replace one or more spaces at the beginning of each</FONT>
    <FONT color=#009900>// line with no spaces. Must enable MULTILINE mode:</FONT>
    s = s.replaceAll(<FONT color=#004488>"(?m)^ +"</FONT>, <FONT color=#004488>""</FONT>);
    System.out.println(s);
    s = s.replaceFirst(<FONT color=#004488>"[aeiou]"</FONT>, <FONT color=#004488>"(VOWEL1)"</FONT>);
    StringBuffer sbuf = <FONT color=#0000ff>new</FONT> StringBuffer();
    Pattern p = Pattern.compile(<FONT color=#004488>"[aeiou]"</FONT>);
    Matcher m = p.matcher(s);
    <FONT color=#009900>// Process the find information as you</FONT>
    <FONT color=#009900>// perform the replacements:</FONT>
    <FONT color=#0000ff>while</FONT>(m.find())
      m.appendReplacement(sbuf, m.group().toUpperCase());
    <FONT color=#009900>// Put in the remainder of the text:</FONT>
    m.appendTail(sbuf);
    System.out.println(sbuf);
    monitor.expect(<FONT color=#0000ff>new</FONT> String[]{
      <FONT color=#004488>"Here's a block of text to use as input to"</FONT>,
      <FONT color=#004488>"the regular expression matcher. Note that we'll"</FONT>,
      <FONT color=#004488>"first extract the block of text by looking for"</FONT>,
      <FONT color=#004488>"the special delimiters, then process the"</FONT>,
      <FONT color=#004488>"extracted block. "</FONT>,
      <FONT color=#004488>"H(VOWEL1)rE's A blOck Of tExt tO UsE As InpUt tO"</FONT>,
      <FONT color=#004488>"thE rEgUlAr ExprEssIOn mAtchEr. NOtE thAt wE'll"</FONT>,
      <FONT color=#004488>"fIrst ExtrAct thE blOck Of tExt by lOOkIng fOr"</FONT>,
      <FONT color=#004488>"thE spEcIAl dElImItErs, thEn prOcEss thE"</FONT>,
      <FONT color=#004488>"ExtrActEd blOck. "</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
  </blockquote>

<p>我们用前面介绍的<span class=original_words>TextFile.read( )</span>方法来打开和读取文件。<span class=original_words>mInput</span>的功能是匹配'<span class=original_words>/*!</span>' 和 '<span class=original_words>!*/</span>' 之间的文本(注意一下分组用的括号)。接下来，我们将所有两个以上的连续空格全都替换成一个，并且将各行开头的空格全都去掉(为了让这个正则表达式能对所有的行，而不仅仅是第一行起作用，必须启用多行模式)。这两个操作都用了<span class=original_words>String</span>的<span class=original_words>replaceAll( )</span>(这里用它更方便)。注意，由于每个替换只做一次，因此除了预编译<span class=original_words>Pattern</span>之外，程序没有额外的开销。</p>

<p><span class=original_words>replaceFirst( )</span>只替换第一个子串。此外，<span class=original_words>replaceFirst( )</span>和<span class=original_words>replaceAll( )</span>只能用常量(literal)来替换，所以如果你每次替换的时候还要进行一些操作的话，它们是无能为力的。碰到这种情况，你得用<span class=original_words>appendReplacement( )</span>，它能让你在进行替换的时候想写多少代码就写多少。在上面那段程序里，创建<span class=original_words>sbuf</span>的过程就是选group做处理，也就是用正则表达式把元音字母找出来，然后换成大写的过程。通常你得在完成全部的替换之后才调用<span class=original_words>appendTail( )</span>，但是如果要模仿<span class=original_words>replaceFirst( )</span>(或"replace n")的效果，你也可以只替换一次就调用<span class=original_words>appendTail( )</span>。它会把剩下的东西全都放进<span class=original_words>sbuf</span>。</p>

<p>你还可以在<span class=original_words>appendReplacement( )</span>的<span class=original_words>replacement</span>参数里用"$g"引用已捕获的group，其中'g' 表示group的号码。不过这是为一些比较简单的操作准备的，因而其效果无法与上述程序相比。</p>
<h3 id=header66>reset( )</h3>

<p>此外，还可以用<span class=original_words>reset( )</span>方法给现有的<span class=original_words>Matcher</span>对象配上个新的<span class=original_words>CharSequence</span>。</p>
<table class=code><td>
<PRE><FONT color=#009900>//: c12:Resetting.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> java.io.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> Resetting {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) <FONT color=#0000ff>throws</FONT> Exception {
    Matcher m = Pattern.compile(<FONT color=#004488>"[frb][aiu][gx]"</FONT>)
      .matcher(<FONT color=#004488>"fix the rug with bags"</FONT>);
    <FONT color=#0000ff>while</FONT>(m.find())
      System.out.println(m.group());
    m.reset(<FONT color=#004488>"fix the rig with rags"</FONT>);
    <FONT color=#0000ff>while</FONT>(m.find())
      System.out.println(m.group());
    monitor.expect(<FONT color=#0000ff>new</FONT> String[]{
      <FONT color=#004488>"fix"</FONT>,
      <FONT color=#004488>"rug"</FONT>,
      <FONT color=#004488>"bag"</FONT>,
      <FONT color=#004488>"fix"</FONT>,
      <FONT color=#004488>"rig"</FONT>,
      <FONT color=#004488>"rag"</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
</td></table>

<p>如果不给参数，<span class=original_words>reset( )</span>会把<span class=original_words>Matcher</span>设到当前字符串的开始处。</p>

<h3 id=header67>正则表达式与Java I/O</h3>

<p>到目前为止，你看到的都是用正则表达式处理静态字符串的例子。下面我们来演示一下怎样用正则表达式扫描文件并且找出匹配的字符串。受Unix的grep启发，我写了个<span class=original_words>JGrep.java</span>，它需要两个参数：文件名，以及匹配字符串用的正则表达式。它会把匹配这个正则表达式那部分内容及其所属行的行号打印出来。</p>
<table class=code><td>
<PRE><FONT color=#009900>//: c12:JGrep.java</FONT>
<FONT color=#009900>// A very simple version of the "grep" program.</FONT>
<FONT color=#009900>// {Args: JGrep.java "\\b[Ssct]\\w+"}</FONT>
<FONT color=#0000ff>import</FONT> java.io.*;
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> java.util.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.util.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> JGrep {
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) <FONT color=#0000ff>throws</FONT> Exception {
    <FONT color=#0000ff>if</FONT>(args.length &lt; 2) {
      System.out.println(<FONT color=#004488>"Usage: java JGrep file regex"</FONT>);
      System.exit(0);
    }
    Pattern p = Pattern.compile(args[1]);
    <FONT color=#009900>// Iterate through the lines of the input file:</FONT>
    ListIterator it = <FONT color=#0000ff>new</FONT> TextFile(args[0]).listIterator();
    <FONT color=#0000ff>while</FONT>(it.hasNext()) {
      Matcher m = p.matcher((String)it.next());
      <FONT color=#0000ff>while</FONT>(m.find())
        System.out.println(it.nextIndex() + <FONT color=#004488>": "</FONT> +
          m.group() + <FONT color=#004488>": "</FONT> + m.start());
    }
  }
} <FONT color=#009900>///:~</FONT></PRE>
</td></table>

<p>文件是用<span class=original_words>TextFile</span>打开的(本章的前半部分讲的)。由于<span class=original_words>TextFile</span>会把文件的各行放在<span class=original_words>ArrayList</span>里面，而我们又提取了一个<span class=original_words>ListIterator</span>，因此我们可以在文件的各行当中自由移动(既能向前也可以向后)。 </p>


<p>每行都会有一个<span class=original_words>Matcher</span>，然后用<span class=original_words>find( )</span>扫描。注意，我们用<span class=original_words>ListIterator.nextIndex( )</span>跟踪行号。 </p>


<p>测试参数是<span class=original_words>JGrep.java</span>和以<span class=original_words>[Ssct]</span>开头的单词。</p>
<h3 id=header68>还需要StringTokenizer吗?</h3>

<p>看到正则表达式能提供这么强大的功能，你可能会怀疑，是不是还需要原先的<span class=original_words>StringTokenizer</span>。JDK 1.4以前，要想分割字符串，只有用<span class=original_words>StringTokenizer</span>。但现在，有了正则表达式之后，它就能做得更干净利索了。</p>
<blockquote>
<PRE><FONT color=#009900>//: c12:ReplacingStringTokenizer.java</FONT>
<FONT color=#0000ff>import</FONT> java.util.regex.*;
<FONT color=#0000ff>import</FONT> com.bruceeckel.simpletest.*;
<FONT color=#0000ff>import</FONT> java.util.*;
<FONT color=#0000ff>public</FONT> <FONT color=#0000ff>class</FONT> ReplacingStringTokenizer {
  <FONT color=#0000ff>private</FONT> <FONT color=#0000ff>static</FONT> Test monitor = <FONT color=#0000ff>new</FONT> Test();
  <FONT color=#0000ff>public</FONT> <FONT color=#0000ff>static</FONT> <FONT color=#0000ff>void</FONT> main(String[] args) {
    String input = <FONT color=#004488>"But I'm not dead yet! I feel happy!"</FONT>;
    StringTokenizer stoke = <FONT color=#0000ff>new</FONT> StringTokenizer(input);
    <FONT color=#0000ff>while</FONT>(stoke.hasMoreElements())
      System.out.println(stoke.nextToken());
    System.out.println(Arrays.asList(input.split(<FONT color=#004488>" "</FONT>)));
    monitor.expect(<FONT color=#0000ff>new</FONT> String[] {
      <FONT color=#004488>"But"</FONT>,
      <FONT color=#004488>"I'm"</FONT>,
      <FONT color=#004488>"not"</FONT>,
      <FONT color=#004488>"dead"</FONT>,
      <FONT color=#004488>"yet!"</FONT>,
      <FONT color=#004488>"I"</FONT>,
      <FONT color=#004488>"feel"</FONT>,
      <FONT color=#004488>"happy!"</FONT>,
      <FONT color=#004488>"[But, I'm, not, dead, yet!, I, feel, happy!]"</FONT>
    });
  }
} <FONT color=#009900>///:~</FONT></PRE>
  </blockquote>

<p>有了正则表达式，你就能用更复杂的模式将字符串分割开来——要是交给<span class=original_words>StringTokenizer</span>的话，事情会麻烦得多。我可以很有把握地说，正则表达式可以取代<span class=original_words>StringTokenizer</span>。 </p>

</div>
-->











<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

