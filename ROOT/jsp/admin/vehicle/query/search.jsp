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


int vehicle = 0;//车牌号
if(teasession.getParameter("vehicle")!=null && teasession.getParameter("vehicle").length()>0)
{
	vehicle = Integer.parseInt(teasession.getParameter("vehicle"));
}
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
	type= Integer.parseInt(teasession.getParameter("type"));
String chauffeur = teasession.getParameter("chauffeur");//司机
//申请日期
String time1 = teasession.getParameter("time1");
String time11 = teasession.getParameter("time11");
String man = teasession.getParameter("man");
int unit = 0;
if(teasession.getParameter("unit")!=null && teasession.getParameter("unit").length()>0)
	unit = Integer.parseInt(teasession.getParameter("unit"));
//起始时间
String times1 = teasession.getParameter("times1");
String times11 = teasession.getParameter("times11");
//结束时间
String times2 = teasession.getParameter("times2");
String times22 = teasession.getParameter("times22");

String findingmanid = teasession.getParameter("findingmanid");//申请人
String attemper = teasession.getParameter("attemper");//调度人员
String cause = teasession.getParameter("cause");//事由
String remark = teasession.getParameter("remark");//备注


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
      <td nowrap align="center">用车人</td>
      <td nowrap align="center">事由</td>
      <td nowrap align="center">开始时间</td>
      <td nowrap align="center">结束时间</td>
      <td nowrap align="center">备注</td>
      <td nowrap align="center">操作</td>
    </tr>
    <%
    	String sql ="";
    	

		if(type>0 && type!=2)
		{
			sql =" and  type = "+type+"  and chauffeur like "+db.cite("%"+chauffeur+"%")+"  and "+db.cite(time1)+" <= times and times <="+db.cite(time11)+" and man like "+db.cite("%"+man+"%")+" and ("+db.cite(times1)+" <= times1 and times1<="+db.cite(times11)+") and "+db.cite(times2)+" <=times2 and times2 <="+db.cite(times22)+" and member like "+db.cite("%"+findingmanid+"%")+" and attemper like "+db.cite("%"+attemper+"%")+" and cause like "+db.cite("%"+cause+"%")+" and remark like "+db.cite("%"+remark+"%")+"";
		}
		if(vehicle>0)
		{
			sql ="   and vehicle = "+vehicle+" and chauffeur like "+db.cite("%"+chauffeur+"%")+"  and "+db.cite(time1)+" <= times and times <="+db.cite(time11)+" and man like "+db.cite("%"+man+"%")+"  and ("+db.cite(times1)+" <= times1 and times1<="+db.cite(times11)+") and "+db.cite(times2)+" <=times2 and times2 <="+db.cite(times22)+" and member like "+db.cite("%"+findingmanid+"%")+" and attemper like "+db.cite("%"+attemper+"%")+" and cause like "+db.cite("%"+cause+"%")+" and remark like "+db.cite("%"+remark+"%")+"";
		}
		if(unit>0)
		{
			sql ="  and chauffeur like "+db.cite("%"+chauffeur+"%")+"  and "+db.cite(time1)+" <= times and times <="+db.cite(time11)+" and man like "+db.cite("%"+man+"%")+" and unit = "+unit+" and ("+db.cite(times1)+" <= times1 and times1<="+db.cite(times11)+") and "+db.cite(times2)+" <=times2 and times2 <="+db.cite(times22)+" and member like "+db.cite("%"+findingmanid+"%")+" and attemper like "+db.cite("%"+attemper+"%")+" and cause like "+db.cite("%"+cause+"%")+" and remark like "+db.cite("%"+remark+"%")+"";
		}
		if(type==2)
		{
			sql =" and uses=1 and  type = "+type+"  and chauffeur like "+db.cite("%"+chauffeur+"%")+"  and "+db.cite(time1)+" <= times and times <="+db.cite(time11)+" and man like "+db.cite("%"+man+"%")+" and ("+db.cite(times1)+" <= times1 and times1<="+db.cite(times11)+") and "+db.cite(times2)+" <=times2 and times2 <="+db.cite(times22)+" and member like "+db.cite("%"+findingmanid+"%")+" and attemper like "+db.cite("%"+attemper+"%")+" and cause like "+db.cite("%"+cause+"%")+" and remark like "+db.cite("%"+remark+"%")+"";
		}
    		//if(typ)
    		//{
    			//sql =" and  type = "+type+" and vehicle = "+vehicle+" and chauffeur like "+db.cite("%"+chauffeur+"%")+"  and "+db.cite(time1)+" <= times and times <="+db.cite(time11)+" and man like "+db.cite("%"+man+"%")+" and unit = "+unit+" and ("+db.cite(times1)+" <= times1 and times1<="+db.cite(times11)+") and "+db.cite(times2)+" <=times2 and times2 <="+db.cite(times22)+" and member like "+db.cite("%"+findingmanid+"%")+" and attemper like "+db.cite("%"+attemper+"%")+" and cause like "+db.cite("%"+cause+"%")+" and remark like "+db.cite("%"+remark+"%")+"";
    		//}
    		//sql =" and  type = "+type+" and vehicle = "+vehicle+" and chauffeur like "+db.cite("%"+chauffeur+"%")+"  and "+db.cite(time1)+" <= times and times <="+db.cite(time11)+" and man like "+db.cite("%"+man+"%")+" and unit = "+unit+" and ("+db.cite(times1)+" <= times1 and times1<="+db.cite(times11)+") and "+db.cite(times2)+" <=times2 and times2 <="+db.cite(times22)+" and member like "+db.cite("%"+findingmanid+"%")+" and attemper like "+db.cite("%"+attemper+"%")+" and cause like "+db.cite("%"+cause+"%")+" and remark like "+db.cite("%"+remark+"%")+"";
    		
    	java.util.Enumeration apme = Applys.findByCommunity(teasession._strCommunity,sql);
    	while(apme.hasMoreElements())
    	{
    		int apid = ((Integer)apme.nextElement()).intValue();
    		Applys apobj = Applys.find(apid);
    		
     %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td nowrap align="center">
      	<%
      		Manage maobj = Manage.find(apobj.getVehicle());
      		//out.print(maobj.getVehicle());
      	 %>
      	 <a href="/jsp/admin/vehicle/vehicle_detail.jsp?maid=<%=apobj.getVehicle() %>" target="_blank"><%= maobj.getVehicle()%></a></td>
      <td nowrap align="center"	><%=apobj.getMan() %></td>
      <td nowrap align="center"><%=apobj.getCause() %></td>
      <td nowrap align="center"><%=apobj.getTimes1() %></td>
      <td nowrap align="center"><%=apobj.getTimes2() %></td>
      <td nowrap align="center"><%=apobj.getRemark() %></td>
      <td nowrap align="center">
      <%
      		  String member = teasession._rv.toString();//当前用户

            AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
        
	            if(au_obj.isExists())
	            {
	            	if(au_obj.getUnit()==0)
	            	{
	            		out.print("<a href=\"/jsp/admin/vehicle/us	age_detail.jsp?apid="+apid+"\"  target=\"_blank\"> 详细信息</a>");
	           		}else
	           		{
      
       %>
       
      	 <a href="/jsp/admin/vehicle/usage_detail.jsp?apid=<%=apid %>"  target="_blank"> 详细信息</a>
        <a href="/jsp/admin/vehicle/query/amend.jsp?apid=<%=apid %>">修改</a>
        <a href="/jsp/admin/vehicle/deal.jsp?apid=<%=apid %>&detele=detele">删除</a>
        <%
        
        	}
        	}
        	
         %>

      </td>
    </tr>
    <%
  				  
  			 
    
    	}
     %>
</table>

</body>
</html>



