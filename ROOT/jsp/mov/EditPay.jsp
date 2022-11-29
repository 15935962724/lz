<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = teasession.getParameter("nexturl");
int membertype=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype= Integer.parseInt(teasession.getParameter("membertype"));
}
int payid =0;
if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
{
  payid =Integer.parseInt(teasession.getParameter("payid"));
}
// MemberType obj = MemberType.find(membertype);
// RegisterInstall riobj = RegisterInstall.find(membertype);

MemberPay pobj = MemberPay.find(payid);
String act = teasession.getParameter("act");
if("PAY".equals(act))
{
  java.math.BigDecimal paymoney = new java.math.BigDecimal(teasession.getParameter("paymoney"));
  int paytime =0;
  if(teasession.getParameter("paytime")!=null && teasession.getParameter("paytime").length()>0)
  {
    paytime = Integer.parseInt(teasession.getParameter("paytime"));
  }
  String paycontent = teasession.getParameter("paycontent");
   if(payid>0)
   {
     pobj.set(paymoney,paytime,paycontent,teasession._rv.toString(),teasession._strCommunity);
   }else
   {
     MemberPay.create(paymoney, paytime,paycontent, teasession._rv.toString(), teasession._strCommunity, membertype);
   }
   out.println("<script>alert('记录添加成功！');window.dialogArguments.main.location.reload();window.close();</script>");

}



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script type="">
 window.name='payname';
 function f_submit()
 {
   if(form1.paymoney.value=='')
   {
     alert("请填写缴费金额！");
     return false;
   }else
   {
     if(isNaN(document.all.form1.paymoney.value))
     {
       alert("您输入的字符无效!");
       return false;
     }
   }
   if(form1.paytime.value=='')
   {
     alert("请填写缴费期限！");
     return false;
   }else
   {
      if(isNaN(document.all.form1.paytime.value))
     {
       alert("您输入的字符无效!");
       return false;
     }
   }
   if(form1.paycontent.value=='')
   {
     alert("请填写缴费说明！");
     return false;
   }
 }
</script>
<h1>缴费添加</h1>
<form action="?" method="POST" name="form1" target="payname" onsubmit="return f_submit(this);" >
<input type="hidden" name="act" value="PAY"/>
<input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl")%>">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="payid" value="<%=payid%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td >缴费金额</td>
    <td><input type="text" name="paymoney" value="<%if(pobj.getPaymoney()!=null )out.print(pobj.getPaymoney());%>" /></td>
  </tr>
 <tr>
    <td>缴费期限</td>
    <td><input type="text" name="paytime" value="<%if(pobj.getPaytime()!=0)out.print(pobj.getPaytime());%>" />年</td>
  </tr>
<tr >
  <td > 缴费说明：</td>
    <td><textarea cols="40" rows="2" name="paycontent"><%if(pobj.getPaycontent()!=null)out.print(pobj.getPaycontent());%></textarea></td>
  </tr>

</table>
<input type="submit" value="提交信息" />&nbsp;&nbsp;&nbsp;
<input type="button" value="关闭"  onClick="javascript:window.close();">
</form>


</body>
</html>
