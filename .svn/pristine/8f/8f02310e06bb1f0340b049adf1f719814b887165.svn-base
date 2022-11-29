<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<SCRIPT LANGUAGE=JavaScript>
<!-- //hide from non-javascript browsers
function goback(DID)
{
window.location="com_info.asp?did=" + DID;
}
function view(JID,D)
{	var winRouteLetter = window.open("click.asp?jid=" + JID +"&d=" + D, "");
	winRouteLetter.focus();
}
// stop hiding -->
</SCRIPT>
<META CONTENT="text/html; charset=UTF-8" HTTP-EQUIV=Content-Type>
<STYLE TYPE="text/css">
<!--
TD {	FONT-SIZE: 12px; LINE-HEIGHT: 130%}
.comanyname {	BACKGROUND-COLOR: #FFFFFF; COLOR: #CC0000; FONT-SIZE: 14px; FONT-WEIGHT: bold}
.jobtit {	COLOR: #CC0000}
A:link {	TEXT-DECORATION: none}
A:visited {	COLOR: #0000FF; TEXT-DECORATION: none}
A:hover {	COLOR: #FF0000; TEXT-DECORATION: underline}
A:active {	TEXT-DECORATION: none}
A.topmenu:link     {text-decoration:none; color:#000000}
A.topmenu:visited  {text-decoration:none; color:#000000}
A.topmenu:active   {text-decoration:underline; color:#CC0000}
A.topmenu:hover    {text-decoration:underline; color:#CC0000}
.tblbg {	background-color: #FAFAFA;padding-left: 20px;padding-right: 20px;}
.introbg{	background-color: #FAFAFA;border-top-color: #CC0000;border-bottom-color: #FAFAFA;border-top-width: 1px;border-bottom-width: 1px;border-top-style: solid;border-bottom-style: solid;padding: 20px;}
.titlebg {border-top-color: ##868686;border-top-width: 1px;bborder-top-style: solid;border-top-style: solid;background-color: #E7E7E7;padding-right: 20px;padding-left: 20px;}
-->
</STYLE>
</head>
<BODY>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
  <TR>
    <TD><A HREF="http://www.chinahr.com" TARGET="_blank" CLASS="topmenu">首页</A>
      <SPAN CLASS="jobtit">|</SPAN> <A HREF="http://searchjob.chinahr.com" TARGET="_blank" CLASS="topmenu">找工作</A>
      <SPAN CLASS="jobtit">|</SPAN> <A HREF="http://my.chinahr.com/resume/" TARGET="_blank" CLASS="topmenu">登录简历</A>
      <SPAN CLASS="jobtit">|</SPAN> <A HREF="http://my.chinahr.com/" TARGET="_blank" CLASS="topmenu">我的网</A>
    </TD>
  </TR>
</TABLE>
<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 id="tablecenter">
  <TR>
    <TD><SPAN CLASS=comanyname>&nbsp;<STRONG><%=node.getSubject(teasession._nLanguage)%></STRONG></SPAN>
      　　<FONT COLOR="#000099">【</FONT><A href="/servlet/Node?node=<%=teasession._nNode%>">公司简介</A><FONT COLOR="#000099">】</FONT>&nbsp;<FONT COLOR="#000099">【</FONT><A HREF="#">招聘职位</A><FONT COLOR="#000099">】</FONT></TD>
  </TR>
  <TR>
    <TD></TD>
  </TR>
</TABLE>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <TR>
    <TD><STRONG>招聘职位</STRONG></TD>
  </TR>
  <%
java.util.Enumeration enumeration=  Job.findByOrg(teasession._nNode);
int nodecode;
while(enumeration.hasMoreElements()){
    nodecode=((Integer)enumeration.nextElement()).intValue();
    Job job=Job.find(nodecode,teasession._nLanguage);
    node=Node.find(nodecode);
  %>
  <TR>
    <TD>
<TR><TD></TD><P><%=(new java.text.SimpleDateFormat("yyyy-MM-dd")).format(node.getTime())%>  <A href="/servlet/Job?node=<%=nodecode%>"><%=job.getName()%></A>&nbsp;</P></TD></TR>
<%}%>
  </TD>
  </TR>
  <TR>
    <TD >&nbsp</TD>
  </TR>
  <TR>
    <TD></TD>
  </TR>

</TABLE>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tableCENTER">
  <TR>
    <TD>
      <br/>
        Copyright &copy; ChinaHR.com Corporation. All rights reserved. 招聘网&#174;
        版权所有<br/>
        本网所有资讯内容、广告信息，未经书面同意，不得转载。<br/>
      中国权威<A HREF="http://www.chinahr.com"><B>招聘</B></A>、<A HREF="http://www.chinahr.com"><B>求职</B></A>网站——招聘网&#174;
    </TD>
  </TR>
</TABLE>
<br/>
</BODY></html>

