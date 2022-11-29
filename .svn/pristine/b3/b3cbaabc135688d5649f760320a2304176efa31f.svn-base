<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);

//显示红方还是蓝方
String act = teasession.getParameter("act");// s,o
int snode = 0;//红方
if(teasession.getParameter("snode")!=null){
	snode = Integer.parseInt(teasession.getParameter("snode"));
} 

int onode = 0;//蓝方
if(teasession.getParameter("onode")!=null){
	onode = Integer.parseInt(teasession.getParameter("onode"));
}

//红方统计数字
int scount = NodePoll_2.count(snode);
//蓝方统计数字
int ocount = NodePoll_2.count(onode);

//总票数
int count = scount+ocount;

//System.out.println(scount+"--"+ocount+"--"+count);
 
%>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
	function f_np(igd)
	{

	 sendx("/jsp/type/poll/PollAJAX.jsp?act=EDITPOLLNODE2&node="+igd,
			 function(data)
			 {   
			   if(data!=''&&data.trim().length>0&&data.trim()!='')//如果有这个用户  则写入Cookie
			   {
				if(data.trim()=='false'){
					alert("每天只能投5次");
				
				}else if(data.trim()=='true'){
					 alert("提交成功!"); 
					// document.getElementById("showPOLLNODE").innerHTML='提交成功';
					 window.location.reload(); 
				 }
			   }
			 } 
			 );

	}
</script>

<%
StringBuffer sb = new StringBuffer();
if("s".equals(act)){//红方显示
	int s = (int) (100f * (((float) scount) / ((float) count))); 
	sb.append("<span id=sid>红方：</span>");
	sb.append("<span id=stid><div style=\"width:"+s+"%;background:red;\"></div></span>");
	sb.append("<div class=scid><span id=scid>投票数：").append(scount).append("</span>");
	sb.append("<span id=sfid>支持率：</span>");

	float sp = (float) scount / count;
	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
	nf.setMinimumFractionDigits(0); // 小数点后保留几位
	String str = nf.format(sp); // 要转化的数

	if(sp > 0)
	{
	    sb.append("<SPAN ID=sTast>" + str + "</SPAN></div>");
	} else
	{
	    sb.append("<SPAN ID=sTast>0%</SPAN></div>");
	}
	sb.append("<span id=sbutton class=sbutton>");
	sb.append("<input id=sbuttonname class=sbuttonname type=button value=我投一票 onclick=f_np('"+snode+"');>");
	sb.append("</span>");
	
}else if("o".equals(act)){//蓝方
	
	int o = (int) (100f * (((float) ocount) / ((float) count)));
	

	sb.append("<span id=oid>蓝方：</span>");

	sb.append("<span id=otid><div style=\"width:"+o+"%;background:#1874CD;\"></div></span>");
	
	sb.append("<div class=scid><span id=ocid>投票数：").append(ocount).append("</span>");
	sb.append("<span id=osfid>支持率：</span>");

	float op = (float) ocount / count;
	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
	nf.setMinimumFractionDigits(0); // 小数点后保留几位
	String str = nf.format(op); // 要转化的数

	if(op > 0)
	{
	    sb.append("<SPAN ID=sTast>" + str + "</SPAN></div>");
	} else
	{
	    sb.append("<SPAN ID=sTast>0%</SPAN></div>");
	}
	sb.append("<span id=sbutton class=osbutton>");
	sb.append("<input class=osbuttonname id=sbuttonname type=button value=我投一票 onclick=f_np('"+onode+"');>");
	sb.append("</span>");
	
}

out.println(sb.toString());

%>
