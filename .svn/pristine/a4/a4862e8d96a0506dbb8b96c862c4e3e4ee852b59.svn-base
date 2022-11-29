<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>

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

String numbers = teasession.getParameter("numbers");
String vote =teasession.getParameter("vote");
int voteint = Integer.parseInt(vote.split(",")[1]);
int psid = 0;
if(teasession.getParameter("psid")!=null && teasession.getParameter("psid").length()>0)
{
	psid = Integer.parseInt(teasession.getParameter("psid"));	
}

 

%>
 
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/jsp/type/perform/eme.js" type="text/javascript"></script>

<title>打印预览</title>
</head>
<body id="bodynoneVotes"  topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script>
window.name='tar';   
function f_submit()
{
	 if(confirm('确认出票?')) 
     {    
	       var printApplet = document.getElementById("printApplet");              
	       var n = form1.numbers.value;
	       var v = form1.vote.value;
	       var p = form1.psid.value; 
	       var ip =form1.ip.value;
	       var sp = '?act=AdminOnlineReservations&numbers='+n+'&vote='+v+'&psid='+p;
	       openNewDiv('newDiv');
	       
	       printApplet.openPrintApplet(ip,sp);
	       f_close('newDiv'); 
	       
	       window.returnValue=1;
	       window.close(); 
	}
	
}   
  
</script>
<div class="content"> 

<object    
     classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"    
     codebase = "http://ntcc.redcome.com/print/jre-6u17-windows-i586-iftw-rv.exe#Version=1,6,0,0"    
     WIDTH = 1 HEIGHT = 1 NAME = "printApplet" >    
     <PARAM NAME = CODE VALUE = "PrintApplet.class" >
     <PARAM NAME = ID VALUE = "printApplet" >    	  
     <PARAM NAME = CODEBASE VALUE = "." >    
     <PARAM NAME = ARCHIVE VALUE = "printApplet.jar" >    
     <PARAM NAME = NAME VALUE = "printApplet" >    
     <param name = "type" value = "application/x-java-applet;version=1.6">    
     <param name = "scriptable" value = "true">    
 </object> 
<form name="form1" action="?" method="get" target="tar">

<input type="hidden" name="numbers" value="<%=numbers %>"/>
<input type="hidden" name="vote" value="<%=vote %>"/>
<input type="hidden" name="psid" value="<%=psid %>"/>
<input type="hidden" name="ip" value="<%out.print(request.getServerName()+":"+request.getServerPort()); %>">

  
<%
PerformStreak psobj = PerformStreak.find(psid);
//演出名称
Node nobj1= Node.find(psobj.getNode());
//演出场馆
Node nobj2 = Node.find(psobj.getVenues());

	for(int i=1;i<numbers.split("/").length;i++)
	{ 
		int number_id = Integer.parseInt(numbers.split("/")[i]);//座位的id号   
		SeatEditor seobj = SeatEditor.find(number_id,psobj.getVenues());//显示场馆设置好的分布图
		PriceDistrict pdobj = PriceDistrict.find(number_id,psid);//分区价格显示图
		PriceSubarea psobj2 = PriceSubarea.find(pdobj.getPricesubareaid()); 
		BigDecimal bp = new BigDecimal("0");
		String piaozhong = "";
		  if(voteint>0)//说明有票种
 		    {  
 		    	bp = Vote.getVotePrice(voteint,pdobj.getPricesubareaid());
 		    	Vote vobj = Vote.find(voteint);
 		    	piaozhong= vobj.getVotename();
 		    }else 
 		    { 
 		    	bp = psobj2.getPrice();
 		    }		  
%>  
  
<div class="VotesLike">
	<div class="left"><img src="/res/REDCOME/0911/09119918.jpg"/></div>
	<div class="right">
    	<div class="title"><%=nobj1.getSubject(teasession._nLanguage) %></div>
    	<div class="con">
        <table border="0" cellpadding="0" cellspacing="0">
	        <tr><td class="td01">时间&nbsp;DATE：</td><td><%=PerformStreak.sdf(psobj.getPftime()) %></td></tr>
	        <tr><td class="td01">地点&nbsp;ADD：</td><td><%=nobj2.getSubject(teasession._nLanguage) %></td></tr>
	        <tr><td class="td01">座位&nbsp;SEAT：</td><td><%out.print(seobj.getRegion()+seobj.getLinagenumber()+"排"+seobj.getSeatnumber()+"号"); %></td></tr>
	        <tr><td class="td01">票价&nbsp;PRICE：</td><td><%=bp %>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;<%=piaozhong %></td></tr>
        </table> 
        </div> 
        <div class="bottom">
        <div class="no">NO：0</div>
        <div class="Tips">提示信息：<span>敬请演出前20分钟入场</span></div>
        </div>
    </div>
      <div class="Vice">
      <div><%=PerformStreak.sdf(psobj.getPftime()) %><br/><%=nobj2.getSubject(teasession._nLanguage) %></div>NO：0
      </div>
      </div> 
<%} %> 
   
<input class="IdentifiedVotes" type="button" value="" onClick="f_submit();">　　<input class="ClosePreview" type="button" value="" onClick="window.close();">
</form>
</div>
</body>

</html>   
