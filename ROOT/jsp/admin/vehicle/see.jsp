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
DbAdapter db = new DbAdapter();

int vehicle =0;
if(teasession.getParameter("vehicle")!=null && teasession.getParameter("vehicle").length()>0)
	vehicle = Integer.parseInt(teasession.getParameter("vehicle"));

String timek = teasession.getParameter("timek");
String timej = teasession.getParameter("timej");
int vtype =0;
if(teasession.getParameter("vtype")!=null && teasession.getParameter("vtype").length()>0)
	vtype = Integer.parseInt(teasession.getParameter("vtype"));
String cause = teasession.getParameter("cause");
String man = teasession.getParameter("man");
float charge1=0,charge2=0;
if(teasession.getParameter("charge1")!=null && teasession.getParameter("charge1").length()>0)
	charge1 = Integer.parseInt(teasession.getParameter("charge1"));
if(teasession.getParameter("charge2")!=null && teasession.getParameter("charge2").length()>0)
	charge2 = Integer.parseInt(teasession.getParameter("charge2"));
	
String remark = teasession.getParameter("remark");
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
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	 <tr id="tableonetr">
      <td nowrap align="center">车牌号</td>
      <td nowrap align="center">维护日期：</td>
      <td nowrap align="center">维护类型</td>
      <td nowrap align="center">维护原因</td>
      <td nowrap align="center">经 办 人</td>
      <td nowrap align="center">维护费用</td>
      <td nowrap align="center">备　　注</td>
      <td nowrap align="center">操    作</td>
    </tr>
      <%
      		String sql ="";
      		if(vehicle>0 && vtype>0)
      		{
      			sql = " and vehicle = "+vehicle+"  and "+db.cite(timek)+"<=times and times <"+db.cite(timej)+" and vtype ="+vtype+" and cause like "+db.cite("%"+cause+"%")+" and man like "+db.cite("%"+man+"%")+" and "+charge1+"<=charge and charge<="+charge2+"  and remark like "+db.cite("%"+remark+"%")+" ";
      		
      		}
      		if(vehicle>0)
      		{
      			sql = " and vehicle = "+vehicle+"  and "+db.cite(timek)+"<=times and times <"+db.cite(timej)+"  and cause like "+db.cite("%"+cause+"%")+" and man like "+db.cite("%"+man+"%")+" and "+charge1+"<=charge and charge<="+charge2+" and remark like "+db.cite("%"+remark+"%")+" ";
      		}
      		if(vtype>0)
      		{
      			sql = "  and "+db.cite(timek)+"<=times and times <"+db.cite(timej)+" and vtype ="+vtype+" and cause like "+db.cite("%"+cause+"%")+" and man like "+db.cite("%"+man+"%")+" and "+charge1+"<=charge and charge<="+charge2+"  and remark like "+db.cite("%"+remark+"%")+" ";
      		}
      		java.util.Enumeration mame = Maintenance.findByCommunity(teasession._strCommunity,sql);
      		while(mame.hasMoreElements()){
      			int maid = ((Integer)mame.nextElement()).intValue();
      			Maintenance maobj = Maintenance.find(maid);
      			Manage maobj1 = Manage.find(maobj.getVehicle());//车辆的信息
      	 %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td nowrap align="center">
 
      	 <a href="/jsp/admin/vehicle/vehicle_detail.jsp?maid=<%=maobj.getVehicle() %>" target="_blank"><%=maobj1.getVehicle() %></a></td>
	      <td nowrap align="center"	><%=maobj.getTimes().toString().substring(0,10) %></td>
	      <td nowrap align="center"><%
	      	if(maobj.getVtype()==1){out.print("维修");}
	      	if(maobj.getVtype()==2){out.print("加油");}
	      	if(maobj.getVtype()==3){out.print("洗车");}
	      	if(maobj.getVtype()==4){out.print("年检");}
	      	if(maobj.getVtype()==5){out.print("其它");}
	      %></td>
	      <td nowrap align="center"><%=maobj.getCause() %></td>
	      <td nowrap align="center"><%=maobj.getMan() %></td>
	      <td nowrap align="center"><%=maobj.getCharge() %></td>
          <td nowrap align="center"><%=maobj.getRemark() %></td>
     	 <td nowrap align="center">
     
        <a href="/jsp/admin/vehicle/query2.jsp?maid=<%=maid %>">修改</a>
        <a href="/jsp/admin/vehicle/deal.jsp?maid=<%=maid %>&madetele=madetele">删除</a>

      </td>
    </tr>
    <%
    	}
     %>
</table>

</body>
</html>



