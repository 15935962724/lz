<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
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
String nexturl =request.getParameter("nexturl");

int pay =0;
if(teasession.getParameter("pay")!=null && teasession.getParameter("pay").length()>0)
{
  pay = Integer.parseInt(teasession.getParameter("pay"));
}

int paytype =0;
if(teasession.getParameter("paytype")!=null && teasession.getParameter("paytype").length()>0)
{
  paytype = Integer.parseInt(teasession.getParameter("paytype"));
}
 int payid =0;

String  payname=Payinstall.PAYNAME[pay],merchant=null,safety=null,payeail=null,paycontent=null,payurl=null,processurl=null,returnurl=null,usename=null;
if(paytype==1)//线上的编辑
{
  Payinstall piobj = Payinstall.findpay(pay);
  if(Payinstall.isPay(pay))
  {
    payname=Payinstall.PAYNAME[pay];
    merchant=piobj.getMerchant();
    safety=piobj.getSafety();
    payeail=piobj.getPayeail();
    paycontent=piobj.getPaycontent();
    payurl=piobj.getPayurl();
    processurl=piobj.getProcessurl();
    returnurl=piobj.getReturnurl();
    usename=piobj.getUsename();
  }
}else if(paytype==2)//线下
{

    if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
    {
      payid = Integer.parseInt(teasession.getParameter("payid"));
    }
    if(payid>0)
    {
      Payinstall piobj = Payinstall.find(payid);
      payname=piobj.getPayname();
      paycontent=piobj.getPaycontent();
      usename = piobj.getUsename();
    }
}

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff">
<h1>支付方式添加</h1>
<form action="/servlet/EditPay" name="form1" method="POST">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="pay" value="<%=pay%>"/>
<input type="hidden" name="paytype" value="<%=paytype%>"/>
<input type="hidden" name="act" value="EditPay"/>
<input type="hidden" name="payid" value="<%=payid%>"/>
<div class='radiusBox'>
<table cellspacing="0" class='newTable' id='tdbor'>
<tr>
    <td class='textRight' width='150' style='border-top:none'>支付方式：</td>
    <td style='border-top:none'><input type="text" name="payname" value="<%if(payname!=null && payname.length()>0)out.print(payname);%>"  <%if(paytype==1)out.print("disabled=\"disabled\"   ");%>  size="50" /></td><%--style=\"background:345566;\" --%>
  </tr>
   <tr>
    <td class='textRight'>使用类型：</td>
    <td>
    <%
    	for(int i =1;i<Payinstall.USE_NAME.length;i++)
    	{
    		out.print("<input type=checkbox name=usename value="+i );
    		if(usename!=null && usename.length()>0&&usename.indexOf("/"+i+"/")!=-1)
    		{
    			out.println(" checked ");
    		}
    		out.print(">&nbsp;"+Payinstall.USE_NAME[i]+"　");
    		
    	}
    %>
    
    </td><%--style=\"background:345566;\" --%>
  </tr>
  
  
  <%if(paytype==2)out.print("<tbody id=\"paymentid\" style=\"display:none\">"); %>
   <tr>
    <td class='textRight'>商户号ID：</td>
    <td><input type="text" name="merchant" value="<%if(merchant!=null && merchant.length()>0)out.print(merchant);%>" size="50"/></td>
  </tr>
  <tr>
    <td class='textRight'>安全校验码：</td>
    <td><input type="text" name="safety" value="<%if(safety!=null && safety.length()>0)out.print(safety);%>" size="50"/></td>
  </tr>
  <tr>
    <td class='textRight'>支付信箱：</td>
    <td><input type="text" name="payeail" value="<%if(payeail!=null && payeail.length()>0)out.print(payeail);%>" size="50"/></td>
  </tr>
   <tr>
    <td class='textRight'>支付跳转路径：</td>
    <td><input type="text" name="payurl" value="<%if(payurl!=null && payurl.length()>0)out.print(payurl);%>" size="50"/></td>
  </tr>
  <tr>
  <td class='textRight'>自动处理信息的URL：</td>
   <td><input type="text" name="processurl" value="<%if(processurl!=null && processurl.length()>0)out.print(processurl);%>" size="50"/></td>
  </tr>
  <tr>
    <td class='textRight'>支付完成后跳转返回的URL：</td>
    <td><input type="text" name="returnurl" value="<%if(returnurl!=null && returnurl.length()>0)out.print(returnurl);%>" size="50"/></td>
  </tr>

   <%if(paytype==2)out.print("</tbody>"); %>
  <tr>
  <td class='textRight'>支付方式说明：</td>
   <td><textarea cols="50" rows="2" name="paycontent"><%if(paycontent!=null && paycontent.length()>0)out.print(paycontent);%></textarea></td>
  </tr>
  </table>
</div>
<div class='mt15'><input type="submit" class='btn btn-primary' value="提交"/>&nbsp;&nbsp;&nbsp; <input type=button value="返回" onClick="javascript:history.back()" class='btn btn-primary' />
    </div>


</form>


</body>
</html>

