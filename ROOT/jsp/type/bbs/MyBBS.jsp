<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.*" %><%@page import="javax.servlet.ServletConfig" %><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.ui.*"%><%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="tea.htmlx.*"%><%@page import="tea.html.HtmlElement"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null&&!"login".equals(request.getParameter("act")))
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String member=request.getParameter("member");
if(member==null)
{
  member=teasession._rv._strR;
}

Resource r = new Resource();
r.add("/tea/resource/BBS");

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}

int count=BBS.countByMember(teasession._strCommunity,member);
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<!--1169716387125=我的帖子-->
<h1><%=r.getString(teasession._nLanguage, "1169716387125")+" ( "+count+" ) "%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<br/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
    <td width="1"></td>
      <Td nowrap><%=r.getString(teasession._nLanguage, "Subject")%></Td>
  <!--    <Td nowrap><%=r.getString(teasession._nLanguage, "Click")%></Td>-->
      <Td nowrap><%=r.getString(teasession._nLanguage, "ReplyCount")%></Td>
      <Td nowrap><%=r.getString(teasession._nLanguage, "LastReplyTime")%></Td>
    </TR>
<%
java.util.Enumeration e=BBS.findByMember(teasession._strCommunity,member,pos,25);
for(int i=1;e.hasMoreElements();i++)
{
  int node=((Integer)e.nextElement()).intValue();
  Node obj=Node.find(node);
  BBS b=BBS.find(node, teasession._nLanguage);
  out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\">");
  out.print("<td width=1>"+i);
  out.print("<td><a href='/html/bbs/"+node+"-"+teasession._nLanguage+".htm' target='_blank'>"+obj.getSubject(teasession._nLanguage)+"</a>");
//  out.print("<td>"+obj.getClick());
  out.print("<td>"+b.getReplyCount());
  out.print("<td>&nbsp;");
  if (b.getReplyCount() > 0)
  {
    out.print(b.getReplyMember()+"&nbsp;"+b.getReplyTimeToString());
  }
}
%>
<tr><td colspan="5"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+teasession._strCommunity+"&member="+java.net.URLEncoder.encode(member,"utf-8")+"&pos=",pos,count)%></td></tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
