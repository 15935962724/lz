<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Seat sobj = Seat.find(teasession._nNode);

  //列数
  int row = sobj.getRow();

  //行
  int linage=sobj.getLinage();

if(row==0)
{
  row = 10;
}
if(linage==0)
{
  linage = 10;
}
 
   
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>场馆信息管理</title>
</head>
<body id="bodynone2"  >
<div id="load" >
<img src="/tea/image/public/load.gif" align="top">正在加载...
</div>
<script>
//选择标点
var idd = 0;
	function f_td(igd)
	{
		var td= document.getElementById("tdid" + igd);//.style.backgroundColor = "red";
		if(td.x!="1")//选中以后
		{
		    td.x="1"; 
			td.style.backgroundColor="red";
			window.open("/jsp/type/venues/right_seat.jsp?seid="+igd+"&node="+form1.node.value+"&community="+form1.community.value,"MenuFrameyu");
		}
		else
		{ 
			td.x="0";
			td.style.backgroundColor="";
			window.open("/jsp/type/venues/right_seat.jsp?node="+form1.node.value+"&community="+form1.community.value,"MenuFrameyu");
		}

	}
</script>
<form name="form1">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
  <table border="0" cellpadding="0" cellspacing="0" id="tableSeats">
  <%
out.print("<tr>");
out.print("<td>&nbsp;</td>");

for(int j =1;j<=row;j++)
{
	out.print("<td>");
	out.print(j);
	out.print("</td>");
}
out.print("</tr>");

  int jj =1;
  for(int i=1;i<=linage*row;i++)
  {
    if(i%row==1){
      out.print("<tr>");
      out.print("<td>"+jj+"</td>");
    }
    SeatEditor seobj = SeatEditor.find(i,teasession._nNode);
    out.print("<td id = tdid"+i);
    out.print(" style=\"cursor:pointer\"  onclick=f_td('"+i+"'); ");

    if(seobj.isExists())
    {
    	out.print("  bgcolor=\"#CCCCCC\" ");
    }
  
    out.print(" title=  ");
    if(seobj.isExists())
    {
    	out.print("编号:"+i+"&#10;");
    	out.print("楼层:"+seobj.getRegion()+"&#10;");
    	out.print("排号:"+seobj.getLinagenumber()+"&#10;");
    	out.print("座号:"+seobj.getSeatnumber());
    }else
    {
    	out.print("请点击设置座位");
    }
    
    //点击设置座位
    out.print(">");
    
    if(seobj.getRegion()!=null && seobj.getRegion().length()>0)
    {
    	out.print("#");
    }
    
    if(i%row==0){
      out.print("</tr>");
      jj++;
    }
    
  }
  %>
  </table>
  <script>
var load=document.getElementById('load');
load.style.display='none';
</script>
</body>
</html>
