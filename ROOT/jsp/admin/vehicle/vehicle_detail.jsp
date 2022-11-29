<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

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
int maid = 0;

String vehicle=null,factory=null,engine=null,chauffeur=null,pic=null,remark=null;
int genre=0,fettle=0, maplen = 0;
float price =0;
Date times =null;
if(teasession.getParameter("maid")!=null && teasession.getParameter("maid").length()>0)
	maid = Integer.parseInt(teasession.getParameter("maid"));

Manage maobj = Manage.find(maid);
if(maid>0)
{
	vehicle = maobj.getVehicle();
	factory = maobj.getFactory();
	engine = maobj.getEngine();
	genre = maobj.getGenre();
	chauffeur= maobj.getChauffeur();
	price = maobj.getPrice();
	pic = maobj.getPic();
	times = maobj.getTimes();
	fettle = maobj.getFettle();
	remark = maobj.getRemark();
}
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
<h1>车辆详细信息</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	 <tr >
      <td nowrap >厂牌型号：</td>
      <td nowrap ><%= factory%></td>
       <td  nowrap rowspan="6" ><center><%if(pic!=null && pic.length()>0){ %>
	      <img src='<%=pic %>' width='100' border=1 alt="">
	      <%}else{out.print("暂无照片");} %>

	      </center></td>
  </tr>
  <tr >
      <td nowrap >车牌号：</td>
      <td nowrap ><%= vehicle%></td>
  </tr>
  <tr >
      <td nowrap >司机：</td>
      <td nowrap ><%= chauffeur%></td>
  </tr>
  <tr >
      <td nowrap >车辆类型：</td>
      <td nowrap >
      	<%
      		Cargenre caobj = Cargenre.find(genre);
      		out.print(caobj.getCargenrename());
      	 %>
      </td>
  </tr>
  <tr >
      <td nowrap >购置日期：</td>
      <td nowrap ><%=times.toString().substring(0,10) %></td>
  </tr>
  <tr >
      <td nowrap >购买价格：</td>
      <td nowrap ><%=price %></td>
  </tr>
  <tr >
      <td nowrap >发动机号码：</td>
      <td nowrap ><%=engine %></td>
  </tr>
  <tr >
      <td nowrap >预定情况：</td>
      <td nowrap  colspan="2">共 <a href="/jsp/admin/vehicle/order_detail.jsp?apid=<%=maid %>&str=add" target="_blank"><%

	     		out.print(Applys.getCount(teasession._strCommunity,maid));
	      %>条预定信息</a>
  </tr>
  <tr >
      <td nowrap >当前状态：</td>
      <td nowrap ><font color="#00AA00"><b>
 		<%if(fettle==1)out.print("可用"); %>
 		<%if(fettle==2)out.print("损坏"); %>
 		<%if(fettle==3)out.print("维修中"); %>
 		<%if(fettle==4)out.print("报废"); %>

</b></font></td>
  </tr>
  <tr >
      <td nowrap >备注：</td>
      <td nowrap colspan="2"><%=remark %></td>
  </tr>
  <tr >
      <td nowrap colspan="3">
        <input type="button" value="打印" class="BigButton" onclick="document.execCommand('Print');" title="直接打印表格页面">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="关闭" class="BigButton" onClick="window.close();" title="关闭窗口">
      </td>
  </tr>

</TABLE>



</body>
</html>



