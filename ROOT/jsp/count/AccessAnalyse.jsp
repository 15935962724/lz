<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<html>
  <head>

<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
  </head>
<body>
<h1>访问分析</h1>
   <div id="head6"><img height="6" src="about:blank"></div>
     <br>
     当前工作目录:<%=application.getRealPath("/")%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


<tr id="tableonetr">
  <td width="1"></td>
  <td>社区</td>
  <td>URL</td>
  <td>节点数</td>
  <td>会员数</td>
<!--  <td>速度</td>-->
</tr>
<%
java.util.Enumeration enumer=tea.entity.site.Organizer.findOrganizing(teasession._rv);
int index=0;
while(enumer.hasMoreElements())
{
String community=(String)  enumer.nextElement();
tea.entity.site.Community obj=tea.entity.site.Community.find(community);
int rootnode=obj.getNode();
java.util.Enumeration dns_enumer=tea.entity.site.DNS.findByCommunity(community,teasession._nStatus);
String url;
if(dns_enumer.hasMoreElements())
{
  url="http://"+(String)dns_enumer.nextElement();
}else
{
  url=obj.getWebName();
}
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
  <td width="1"><%=++index%></td>
  <td><A href="/jsp/count/index.jsp?community=<%=community%>&node=<%=rootnode%>"><%=obj.getName(teasession._nLanguage)%></A></td>
 <td><A target="_blank" href="<%=url%>"><%=url%></A></td>
  <td><%=tea.entity.site.Community.countByCommunity(community)%></td>
  <td><%=tea.entity.member.Profile.countByCommunity(community)%></td>
<!--  <td><iframe src="/jsp/count/Pace.jsp?url=<%=obj.getWebName()%>&node=<%=rootnode%>" frameborder="0" width="50" height="15" scrolling="no"></iframe></td> -->
</tr>
<%
}
%>
</table>
<pre>
<%--
java.io.File file=new java.io.File(application.getRealPath("/"));
java.lang.Runtime r=java.lang.Runtime.getRuntime();
java.lang.Process p=r.exec("cmd /c dir "+file.getAbsolutePath()+" /s");
java.io.InputStream is=p.getInputStream();
byte by[]=new byte[1024];
int len=0;
StringBuffer sb=new StringBuffer(200);
while((len=is.read(by))>0)
{
  if(len>200)
  {
    if(sb.length()>0)
    sb.delete(0,sb.length());
    sb.append(new String(by,len-200,200,"GBK"));
  }else
  {
    sb.append(new String(by,0,len,"GBK"));
  }
}
is.close();
sb.delete(0,sb.indexOf("     列出所有文件:\r\n")+14);

out.println(sb.toString());

--%></pre>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


