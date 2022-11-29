<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import=" tea.entity.admin.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String pkorder = teasession.getParameter("pkorder");
PackageOrder pobj = PackageOrder.find(pkorder);
int poid = 0;



String title = "";
if("zx".equals(teasession.getParameter("act")))
{
	title ="选择在线支付途径";
}else if("xx".equals(teasession.getParameter("act")))
{
	title ="线下支付";
}


%>
<html>
<head>
<title><%=title %></title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>
window.name='tar';
function f_yzf()
{ 

	window.returnValue=form1.pkorder.value;
	window.close();
 
}    
//关闭窗口
function f_close() 
{
	window.returnValue=1;
	window.close();
}
</script>
 
<h1><%=title %></h1>
<div id="head6"><img height="6" src="about:blank"></div>
 

<form action="?" name="form1" method="POST"    target="tar" >

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="pkorder" value="<%=pkorder %>"/>
<%
if("zx".equals(teasession.getParameter("act")))
{
	
	//添加支付中转表 
	if(tea.entity.admin.PayOrder.isPoid(teasession._strCommunity,pkorder,3)>0)
	{
		poid = tea.entity.admin.PayOrder.isPoid(teasession._strCommunity,pkorder,3);
	}else
	{ 
		poid = tea.entity.admin.PayOrder.create(pkorder,pobj.getMarketprice(),null,teasession._strCommunity,0,3);
	}
%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>在线支付：在支付完成后，在您的帐号中会自动生成本套餐的使用权限.</td>
    </tr>
    <tr>
      <td nowrap="nowrap">支付过程中请您务必不要关闭浏览器，如果付费成功仍没有使用权限，请及时与管理员联系.</td>
    </tr>
    <tr>
      <td>您可以点击下面任意一种支付方式进行支付:</td>
	</tr>
	<tr>
       
        <td>
             <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <tr>
             		<td align="right">订单号:</td>
             		<td><%=pkorder%></td>
             </tr>
              <tr>
             		<td align="right">订单日期:</td>
             		<td><%=pobj.getOrderstimeToString() %></td>
             </tr>
              <tr>
             		<td align="right">套餐价格:</td>
             		<td>￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
             </tr>
             </table>

		</td>
    </tr>
    <tr>
    	<td>
    	<% 
    	
    	out.print(tea.entity.admin.Payinstall.getPaybutton(teasession._strCommunity,3,poid));
    	
    	%>
    	<span id="paybutton2_id" style="display:none"></span>
    	<!-- <input type=button value="首信易支付" onclick="window.open('/jsp/pay/newspaperbeijing/Send.jsp?community='+form1.community.value+'&pkorder='+form1.pkorder.value,'_blank');" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	 -->
    	</td>
    </tr>
	 

  </table>
  <%}else if("xx".equals(teasession.getParameter("act"))){ %>
       <object  id="WebBrowser"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
      </object>
      
    
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 
    <tr id="printbutton1">
      <td>您可以选择银行转账或邮局汇款的方式购买数字报阅读套餐.</td>
    </tr>
   
    <tr  id="printbutton2">
      <td nowrap="nowrap">建议您点击下方的“打印”按钮，将汇款所需的相关信息打印下来.</td>
    </tr>
   
    <tr>
      
        <td>
             <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <tr>
             		<td align="right">订单号:</td>
             		<td><%=pkorder%></td>
             </tr>
              <tr>
             		<td align="right">订单日期:</td>
             		<td><%=pobj.getOrderstimeToString() %></td>
             </tr>
              <tr>
             		<td align="right">套餐价格:</td>
             		<td>￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
             </tr>
             <%
                  java.util.Enumeration e = Payinstall.find(teasession._strCommunity," AND usetype = 1 AND paytype=2 ",0,Integer.MAX_VALUE);

             while(e.hasMoreElements()){
               int payid = ((Integer)e.nextElement()).intValue();
               Payinstall piobj = Payinstall.find(payid);
             %>
             <tr>
    				<td nowrap align="right"><%=piobj.getPayname()%>:</td>
    				<td><%=piobj.getPaycontent()%></td>
    			</tr>
    			<%
             }
    			%>
    			
    			
    			
    			<tr>
    				<td nowrap align="right">汇款提示:</td>
    				<td>务必在汇款的附言或备注上填写：<br/>1、括号内的订单号（20100503000010）<br/>2、括号内的用户名（admin）</td>
    			</tr>
    			<tr>
    				<td></td>
    				<td>若未注明订单号和用户名，我们将无法及时为您开通权限.</td>
    			</tr>
             </table>
		</td> 
    </tr>
	</table>
	
  <%} %>
  <Br/>
  <input type="button"  id="printbutton3"  value="　关闭窗口　"  onclick="f_close();">&nbsp;<%if("xx".equals(teasession.getParameter("act"))){  %> 
  <input type="button" value="　打印预览　"  id="printbutton"   onClick="window.open('/jsp/general/subscribe/PackageOrder4.jsp?pkorder=<%=pkorder %>','_blank','width=557,height=457,left=200,top=200');" >
   
   
   
   <%} %>

</form>
</body>
</html>
