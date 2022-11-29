<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(session.getAttribute("tea.RV")==null)
{
  response.sendRedirect("/jsp/registration/login.jsp?node=2221");
}
Community community = Community.find(teasession._strCommunity);
int pos =0,pos1=0,size=20;
StringBuffer sql = new StringBuffer();
StringBuffer sql2 = new StringBuffer();
sql.append("AND  node in(select node from Node where node in(select node from NodeLayer where father=2221 and hidden=1))");
sql2.append("AND node in(select node from Node where node in(select node from NodeLayer where father=2221 and hidden=0))");
java.util.Enumeration  e1 = Hostel.find(sql.toString(),pos,size);
java.util.Enumeration e2 = Hostel.find(sql2.toString(),pos1,size);
%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>audits</title>
</head>
<body>
<script language="javascript" type="">
function winconfirm(){
	question = confirm("你确认拒绝此申请吗?")
	if (question != "0"){
		window.open("http://www.webgee.com")
	}
}
</script>
<h1>酒店申请</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>待批准的申请( <%//=count1%> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>申请人</td><td>酒店名称</td><td>申请人类型</td><td>操作</td>
</tr>
 <%
while(e1.hasMoreElements())
{
Hostel hostel = (Hostel)e1.nextElement();
int node = hostel.getNode();
Node objno = Node.find(node);//创建的新的酒店的节
String member = objno.getCreator()._strV;//得到登陆的ID（创建者的ID）
Hotel_application hos = Hotel_application.find(member);
Profile obj = Profile.find(member);
%>
<tr>
<td><a href=""><%=obj.getMember()%></a>
<td><a href=""><%=objno.getSubject(teasession._nLanguage) %></a>
</td>
<%
String managertype="";

if(hos.getManage_type()==1)
{
  managertype = "酒店直营";
}
else if(hos.getManage_type()==2)
{
  managertype="代理商";
}
else
{
  managertype="不是有效管理者";
}
%>
<td><%=managertype%></td>
<td><a href="/jsp/registration/audithostel.jsp?node=<%=node%>"> 审批 </a>&nbsp;&nbsp;&nbsp;
  <a href="/jsp/registration/deletehostel.jsp?node=<%=node%>" onclick="winconfirm()">拒绝</a></td>
</tr>
<%
}
 %>
<tr><td colspan="5" align="left">
  <%//=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos1=",pos1,count1,size)%></td></tr>
</table>
<h2>已批准的申请( <%//=count2%> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>申请人</td><td>酒店名称</td><td>申请类型</td>
</tr>
<%
 while(e2.hasMoreElements())
 {
 Hostel hos = (Hostel)e2.nextElement();
 int node1 = hos.getNode();
 Node no = Node.find(node1);
 String member = no.getCreator()._strV;//得到登陆的ID（创建者的ID）
 Hotel_application obj = Hotel_application.find(member);
 %>
 <tr>
   <td><a href=""><%=obj.getMember()%></a></td>
   <td><a href=""><%=no.getSubject(teasession._nLanguage)%></a></td>
   <%
  int type = obj.getManage_type();
  String managertype="";
  if(obj.getManage_type()==1)
  {
     managertype = "酒店直营";
  }
  else if(obj.getManage_type()==2)
  {
     managertype="代理商";
  }
  else
  {
     managertype="不是有效管理者";
  }
   %>
   <td><%=managertype%></td>
 </tr>
 <%} %>
<tr><td colspan="5" align="left">
  <%//=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos2=",pos2,count2,size)%></td>
</tr>
</table>
</body>
</html>
