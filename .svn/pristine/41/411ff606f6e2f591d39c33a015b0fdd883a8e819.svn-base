<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
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

String nexturl = teasession.getParameter("nexturl");//request.getRequestURI()+"?"+request.getContextPath();
String memberorder = teasession.getParameter("memberorder");
MemberOrder moobj = MemberOrder.find(memberorder);
MemberType mtobj = MemberType.find(moobj.getMembertype());
MemberPay mpobj = MemberPay.find(moobj.getPayid());
RegisterInstall riobj = RegisterInstall.find(moobj.getMembertype());

if("MemberDecide".equals(teasession.getParameter("act")))//审核通过
{
  java.math.BigDecimal paymoney =new java.math.BigDecimal(0);
  if(teasession.getParameter("paymoney")!=null && teasession.getParameter("paymoney").length()>0)
  {
    paymoney = new java.math.BigDecimal(teasession.getParameter("paymoney"));
  }
  Date becometime = null;
  if(teasession.getParameter("becometime")!=null && teasession.getParameter("becometime").length()>0)
  {
    becometime = MemberOrder.sdf.parse(teasession.getParameter("becometime"));
  }
  String roles[]=null;
    StringBuffer sp = new StringBuffer();
if(teasession.getParameter("role")!=null && teasession.getParameter("role").length()>0){
   roles =teasession.getParameterValues("role");
  if(roles.length>0)
  {
    sp.append("/");

    for(int i = 0;i<roles.length;i++)
    {
      sp.append(roles[i]+"/");
    }
  }
}


//判断是否要缴费，如果要 才添加
if(teasession.getParameter("md2")!=null && teasession.getParameter("md2").length()>0)
{}else{
  AuditingOrder.create(memberorder,paymoney,teasession._rv.toString(),teasession._strCommunity);
}
String str =null;
  if(roles!=null && roles.length>0)
  {
    sp.append(mtobj.getRole()).append("/");
    str=sp.toString();
  }else
  {
    str = "/"+mtobj.getRole()+"/";
  }

  AdminUsrRole.create(teasession._strCommunity,moobj.getMember(),str,"/",0,"/",null);

  //添加到期日期
  moobj.setBecometime(becometime);
  moobj.setVerifg(1);
  //添加角色
  moobj.setRole(sp.toString());
//发送邮件

Profile p = Profile.find(moobj.getMember());
Community c = Community.find(teasession._strCommunity);

tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
if(p.getEmail()!=null && p.getEmail().length()>0){

  se.sendEmail(p.getEmail(), c.getName(teasession._nLanguage)+"审核会员邮件通知", "恭喜您在 "+c.getName(teasession._nLanguage)+" 上的注册已经通过审核，欢迎您成为 "+c.getName(teasession._nLanguage)+" 的商家，现在您可以立即登录： "+c.getWebName()+" 网站发布您公司的产品与信息。<br></br>&nbsp;&nbsp;&nbsp;顺祝<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商祺！"); // p.getMobile()
}

  response.sendRedirect(nexturl);
  return;
}
if("No".equals(teasession.getParameter("act")))//审核没有通过
{
  moobj.setVerifg(2);
  response.sendRedirect(nexturl);
  return;
}
//彻底删除
if("delete".equals(teasession.getParameter("act")))
{
  Profile.find(moobj.getMember()).delete(teasession._strCommunity,teasession._nLanguage);
  Node nobj = Node.find(Node.getNC(teasession._strCommunity,moobj.getMember()));
  nobj.delete(teasession._nLanguage);
  Company  cobj = Company.find(Node.getNC(teasession._strCommunity,moobj.getMember()));
  cobj.delete(teasession._nLanguage);
  moobj.delete();//订单表
  response.sendRedirect(nexturl);
  return;
}
//启动和暂停服务
if("servicetype".equals(teasession.getParameter("act")))
{
  int servicetype =0;
  if(teasession.getParameter("servicetype")!=null && teasession.getParameter("servicetype").length()>0)
  {
    servicetype = Integer.parseInt(teasession.getParameter("servicetype"));
  }
  int st=0;
  if(servicetype==0)
  {
    st=1;
  }else if(servicetype==1)
  {
    st=0;
  }
  moobj.setServicetype(st);
  response.sendRedirect(nexturl);
  return;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body bgcolor="#ffffff">
<script>

 function f_submitYes()
 {
    form1.act.value='MemberDecide';
    form1.action='?';
    form1.submit();
 }
 function f_submitNo()
 {
    form1.act.value='No';
    form1.action='?';
    form1.submit();
 }
</script>
<h1>会员审核</h1>
<form method="POST" action="?" name="form1" >
<input type="hidden" name="nexturl" value="<%=nexturl%>" />
<input type="hidden" name="act" value="" />
<input type="hidden" name="memberorder" value="<%=memberorder%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
   <td>用户名:</td>
   <td><%=moobj.getMember() %></td>
  </tr>
  <tr >
     <td>申请会员类型:</td>
     <td><%=mtobj.getMembername()%></td>
  </tr>

  <%
     if(mtobj.getRoleType()==1)
     {
       out.print("<tr>");
       out.print("<td>角色权限</td>");
         out.print("<td>");

       java.util.Enumeration are = AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
       while(are.hasMoreElements())
       {
         int arid = ((Integer)are.nextElement()).intValue();
         AdminRole arobj = AdminRole.find(arid);
        if(Integer.parseInt(mtobj.getRole())!=arid){
          out.print("<input type=checkbox name=role value="+arid+" >&nbsp;&nbsp;");
          out.print(arobj.getName()+"&nbsp;&nbsp;");
        }
       }
           out.print("</td>");
       out.print("</tr>");
     }
  %>
 <%
  if(riobj.getRelated()==1){
    out.print("  <tr><td>关联其他信息</td>");
    if(riobj.getRelatednews()==21)
    {
      Node n =Node.find(Node.getNC(teasession._strCommunity,moobj.getMember()));
    //  out.print("<td><a href=/jsp/mov/CompanyShow.jsp?companyid="+Node.getNC(teasession._strCommunity,moobj.getMember())+">"+n.getSubject(teasession._nLanguage)+"</a></td>");
      out.print("<td><a href=\"javascript:window.showModalDialog('/jsp/mov/CompanyShow.jsp?community="+teasession._strCommunity+"&node="+Node.getNC(teasession._strCommunity,moobj.getMember())+"',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:800px;dialogHeight:500px;scroll=1;');\">"+n.getSubject(teasession._nLanguage)+"</a></td>");
    }else{
      Dynamic d = Dynamic.find(riobj.getRelatednews());
      out.print("<td>"+d.getName(teasession._nLanguage)+"</td>");
    }
    out.print("</tr>");
  }
    %>

  <tr>
    <td>支付方式:</td>
    <td><%if(moobj.getPaymode()==1)out.print("网银在线");else if(moobj.getPaymode()==2)out.print("支付宝"); else out.print("银行转账"); %></td>
  </tr>
  <tr>
  <td>到期期限</td>
  <td>会员年限是&nbsp;<b><%=mpobj.getPaytime() %></b>&nbsp;年，到期日期是
    <input type="text" name="becometime" value="<%=mpobj.getTimeLimit(mpobj.getPaytime()) %>" size="10">&nbsp;
  <A href="###"><img onclick="showCalendar('form1.becometime');" src="/tea/image/public/Calendar2.gif" align="top"/>
  </td>
  </tr>
<tr>
<td>实际支付金额:</td>
<td><input type="text" name="paymoney" value="<%if(mpobj.getPaymoney()!=null)out.print(mpobj.getPaymoney());%>" size="10"/>&nbsp;元</td>
</tr>
<tr>
<td colspan="2">
<input type="button" value="审核通过" onclick="f_submitYes();" />
&nbsp;
<input type="button" value="审核不通过" onclick="f_submitNo();" />
<input type=button value="返回" onClick="javascript:history.back()">
</td>
</tr>
</table>

</form>

</body>
</html>
