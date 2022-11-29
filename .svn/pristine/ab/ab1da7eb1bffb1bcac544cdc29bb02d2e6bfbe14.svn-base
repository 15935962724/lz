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

int psid = Integer.parseInt(teasession.getParameter("psid"));
PerformStreak psobj = PerformStreak.find(psid);


Seat sobj = Seat.find(psobj.getVenues());

  //列数
  int row = sobj.getRow();
  int linage=sobj.getLinage();

if(row==0)
{
  row = 10;
}
if(linage == 0)
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
<body id="bodynone2" >
<div id="load" >
<img src="/tea/image/public/load.gif" align="top">正在加载...
</div>
<script>

function f_td(igd)
{
	var td= document.getElementById("tdid" + igd);//.style.backgroundColor = "red";
	if(td.x!="1")//选中以后
	{
	    td.x="1";
		td.style.backgroundColor="red";

		var nstr=form1.number_str.value+"/";
		if(igd>0)
		{
			form1.number_str.value=nstr+igd;
		}
	}else
	{
		td.x="0";
		td.style.backgroundColor="";
		var asc = form1.number_str.value;
		form1.number_str.value = asc.replace("/"+igd,"");
	}
	 window.open("/jsp/type/perform/right_price.jsp?psid=<%=psid%>&numbers="+form1.number_str.value,"MenuFrameyu");
}
function f_tdover(igd)
{

	 document.getElementById("tdid" + igd).style.backgroundColor = "";
}
</script>
<form name="form1">
<input type="hidden" name="number_str" value="">
  <table border="0" cellpadding="0" cellspacing="1" id="tableSeats2">

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

    SeatEditor seobj = SeatEditor.find(i,psobj.getVenues());//显示场馆设置好的分布图
    PriceDistrict pdobj = PriceDistrict.find(i,psid);//分区价格显示图
    if(i%row==1){
      out.print("<tr>");
      out.print("<td>"+jj+"</td>");
    }

    out.print("<td id=tdid"+i+"  ");
    if(seobj.isExists())//
    {
      out.print(" onclick=f_td('"+i+"');  style=\"cursor:pointer\"  bgcolor=\"#CCCCCC\" ");
    }
    if(pdobj.isExist())//如果有座位图
    {
    	out.print(" title=");
    	out.print("楼层:"+seobj.getRegion()+"&#10;");
    	out.print("排号:"+seobj.getLinagenumber()+"&#10;");
    	out.print("座号:"+seobj.getSeatnumber());

    }
    out.print(">");

    if(pdobj.isExist())//如果有座位图 显示图片
    {
        PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid());
        SeatPic spobj = SeatPic.find(psobj2.getPicturepath());
    	out.print("<img src = "+spobj.getPicpath()+" >");
    }
    out.print("</td>");

    if(i%row==0){
      out.print("</tr>");
      jj++;
    }

  }



  %>
  </table>
</form>
  <script>
var load=document.getElementById('load');
load.style.display='none';
</script>
</body>
</html>
