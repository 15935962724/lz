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


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl =null;

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<%
//out.print(MemberPay.getSql(teasession._strCommunity));
StringBuffer sql = new StringBuffer();
StringBuffer sp = new StringBuffer();
//out.print(MemberPay.getMemberType(teasession._strCommunity));

//java.util.Enumeration moe = MemberOrder.find(teasession._strCommunity," AND (verifg = 0 or verifg=3) AND member ="+DbAdapter.cite(teasession._rv.toString())+" AND "+MemberPay.getMemberType(teasession._strCommunity),0,Integer.MAX_VALUE);// AND verifg!=2
java.util.Enumeration moe = MemberOrder.find(teasession._strCommunity," AND (verifg = 0 or verifg=3) AND member ="+DbAdapter.cite(teasession._rv.toString()),0,Integer.MAX_VALUE);// AND verifg!=2

if(moe.hasMoreElements())
{
  out.print("<form action=\"/jsp/mov/AdminSuccess.jsp\" name=\"form1\" method=\"POST\" >");
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
  out.print("<tr><td align=center colspan=5>&nbsp;您已经注册了本站的下列会员，请尽快缴费！</td></tr>");
  out.print(" <tr id=tableonetr> <td width=1>&nbsp;</td> <td nowrap>会员类型</td> <td nowrap>服务费用</td><td nowrap>服务说明</td></tr>");
}
int j = 1;
for(int i =0;moe.hasMoreElements();i++)
{


  String memberorder = ((String)moe.nextElement());
  MemberOrder moobj = MemberOrder.find(memberorder);
  MemberType obj = MemberType.find(moobj.getMembertype());

  //如果注册的会员不用缴费，是不显示在这里的
//  if(!MemberPay.isMembertype(moobj.getMembertype()))
//  {
//    continue;
//  }

  sql.append(" AND membertype !=").append(moobj.getMembertype());
  sp.append("/"+String.valueOf(moobj.getMembertype())+"/");
  out.print("<tr>");

  out.print("<td width=1><input type=\"radio\" name=\"memberorder\"  value="+memberorder);
  if(i==0)
    out.print(" checked=checked");
  out.print("></td>");

  out.print("<td>");
  out.print(obj.getMembername());
  out.print("</td>");
  out.print("<td>");

  java.util.Enumeration mpe = MemberPay.find(teasession._strCommunity," AND membertype="+moobj.getMembertype(),0,Integer.MAX_VALUE);
  while(mpe.hasMoreElements())
  {
    int payid = ((Integer)mpe.nextElement()).intValue();
    MemberPay mpobj = MemberPay.find(payid);
    out.print(mpobj.getPaytime()+"年"+mpobj.getPaymoney()+"元<br>");
  }
  out.print("</td>");

  out.print("<td>");
  out.print(obj.getCaption());
  out.print("</td>");

  out.print("</tr>");
}

if(sql!=null && sql.length()>0)
{
  out.print("</table><p><input type=\"submit\" value=\"下一步\" /></p></form>");
}

  sql.append(MemberOrder.getMemberTypeSQL(teasession._strCommunity,teasession._rv.toString(),1));
  //sql.append(" AND membertype in (SELECT membertype FROM RegisterInstall WHERE verify = 1 )");

//如果用户注册过一个会员类型，就不在这里显示着个会员类型的注册连接了
sql.append(" AND membertype not in (SELECT membertype FROM MemberRecord WHERE member = "+DbAdapter.cite(teasession._rv.toString())+" AND community ="+DbAdapter.cite(teasession._strCommunity)+" )");
 //out.print(sql.toString());
  java.util.Enumeration typee = MemberType.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
  if(typee.hasMoreElements())
  {
    out.print("<form action=\"/jsp/mov/AdminTransfer2.jsp\" name=\"form2\" method=\"POST\" >");
    out.print("<input type=hidden name=sp value="+sp.toString()+">");
    out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
    out.print("<tr><td align=center colspan=5>&nbsp;您可以选择下列会员注册</td></tr>");
    out.print(" <tr id=tableonetr> <td width=1>&nbsp;</td> <td nowrap>会员类型</td> <td nowrap>服务费用</td><td nowrap>服务说明</td></tr>");
  }
  boolean fa = false;
  for(int i =0;typee.hasMoreElements();i++)
  {
    int membertype = ((Integer)typee.nextElement()).intValue();
    MemberType mtyobj = MemberType.find(membertype);
    out.print("<tr>");

    out.print("<td width=1><input type=\"radio\" name=\"membertype\"  value="+membertype);
    if(i==0)
      out.print(" checked=checked");
    out.print("></td>");

    out.print("<td>");
    out.print(mtyobj.getMembername());
    out.print("</td>");
    out.print("<td>");
    java.util.Enumeration mpe = MemberPay.find(teasession._strCommunity," AND membertype="+membertype,0,Integer.MAX_VALUE);
    while(mpe.hasMoreElements())
    {
      int payid = ((Integer)mpe.nextElement()).intValue();
      MemberPay mpobj = MemberPay.find(payid);
      out.print(mpobj.getPaytime()+"年"+mpobj.getPaymoney()+"元<br>");
    }
    out.print("</td>");

    out.print("<td>");
    out.print(mtyobj.getCaption());
    out.print("</td>");

    out.print("</tr>");
    fa=true;
}

if(fa)
{
  out.print("</table><p><input type=\"submit\" value=\"下一步\" /></p></form>");
}

if(!fa && sql!=null && sql.length()==0)
{
  out.print("还没有设置会员注册类型，暂不能申请!");
}

%>
</body>
</html>

