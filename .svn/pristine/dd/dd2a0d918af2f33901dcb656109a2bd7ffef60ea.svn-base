<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>

<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
int apid = 0;
if(teasession.getParameter("apid")!=null && teasession.getParameter("apid").length()>0)
	apid=Integer.parseInt(teasession.getParameter("apid"));

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>


<body>
<%
String str = teasession.getParameter("str");
    	String sql ="";
    	if(str.equals("add"))
    	{
    		 sql = " and vehicle="+apid;
    		
    	}
    	if(str.equals("more"))
    	{
    		sql ="";
    	}
	
 %>
<h1>  车辆预定情况 <%if(str.equals("add")){ Manage obj = Manage.find(apid);out.print(" -"+obj.getVehicle());} %></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr id="tableonetr">
      <td nowrap align="center">状态</td>
      <td nowrap align="center">用车人</td>
      <td align="center">事由</td>
      <td nowrap align="center">开始时间</td>
      <td nowrap align="center">结束时间</td>
      <td align="center">备注</td>
      <td nowrap align="center">操作</td>
    </tr>
    <%
    	
    	java.util.Enumeration apme = Applys.findByCommunity(teasession._strCommunity,sql);
    	while(apme.hasMoreElements())
    	{
    		int apids = ((Integer)apme.nextElement()).intValue();
    		Applys apobj = Applys.find(apids);
     %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td nowrap align="center"><%
      		if(apobj.getUses()==1 ){out.print("使用中");}
      		if(apobj.getType()==1 && apobj.getUses()==0){out.print("正等待管理员批准");}
      		if(apobj.getType()==0 ){out.print("未使用 ");}
      		if(apobj.getType()==-1){out.print("未批准");}
       %></td>
      <td nowrap align="center"><%=apobj.getMan() %></td>
      <td align="center"><%=apobj.getCause() %></td>
      <td nowrap align="center"><%=apobj.getTimes1() %></td>
      <td nowrap align="center"><%=apobj.getTimes2() %></td>
      <td align="center"><%=apobj.getRemark() %></td>
      <td nowrap align="center">
      <a href="/jsp/admin/vehicle/usage_detail.jsp?apid=<%=apids %>"  target="_blank">详细信息</a>
      </td>
    </tr>
    <%}%>
</TABLE>



</body>
</html>



