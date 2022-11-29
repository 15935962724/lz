<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Community community=Community.find(teasession._strCommunity);
String name=request.getParameter("name");

StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

String choose = request.getParameter("choose");
param.append("?choose=").append(Http.enc(choose));

if(choose.equals("1"))
{
  sql.append(" and member in (select member from profilelayer where  firstname="+DbAdapter.cite(name)+" )");
}else
if(choose.equals("2"))
{
  sql.append(" and member in (select member from profilelayer where  telephone="+DbAdapter.cite(name)+" )");
}else if(choose.equals("3"))
{
  sql.append(" and member in (select member from profile where  email="+DbAdapter.cite(name)+" )");
}else if(choose.equals("4"))
{
  int num = Integer.parseInt(teasession.getParameter("num"));
  sql.append(" and member in (select member from profilelayer where  city="+DbAdapter.cite(Volunteer.CITYS[num])+" )");
   param.append("&num=").append(num);
}else
{
   sql.append(" and 1=1 ");
}

param.append("&pos=");

int count=0;
count=Volunteer.count(teasession._strCommunity,sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<body bgcolor="#ffffff">

<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<script type="text/javascript">
if(top.location==self.location)
{
  jspbefore.style.display='';
}
</script>
<form name="form1" action="/jsp/volunteer/Volunteersearch.jsp" method="POST">
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter007" align="center">
  <tr id="xingming001"><td>姓名</td><td>性别</td><td>职业</td><td>城市</td>
    <td>状态</td>
</tr>
<%
java.util.Enumeration eu = Volunteer.findByCommunity(teasession._strCommunity,sql.toString(),pos,30);
if(!eu.hasMoreElements())
{
  out.print("<tr><td colspan=4>暂时没有信息</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
  String member = String.valueOf(eu.nextElement());
  Volunteer vt  =  Volunteer.find(member);
  Profile pro = Profile.find(member);
  %>
  <tr>
    <td><%=pro.getName(teasession._nLanguage)%></td>
    <td><%if(pro.isSex()){out.print("男");}else{out.print("女");}%></td>
    <td><%if(vt.getZhiye()!=null)out.print(vt.getZhiye());%>　</td>
    <td><%=pro.getCity(teasession._nLanguage)%></td>
    <td><%if(vt.getType()==1){out.print("审核通过");}else{out.print("未审核");}%></td>
  </tr>
  <%
  }
  %>
  <tr id="page_001"><td colspan="5"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,30)%></td></tr>

  </table>
</form>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script type="text/javascript">
if(top.location==self.location)
{
  jspafter.style.display='';
}
</script>
</body>
</html>
