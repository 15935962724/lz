<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");


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
    form1.action='/jsp/mov/MemberDecide.jsp';
    form1.submit();
 }
 function f_submitNo()
 {
    form1.act.value='No';
    form1.action='/jsp/mov/MemberDecide.jsp';
    form1.submit();
 }
</script>
<h1>会员审核</h1>
<form method="POST" action="?" name="form1" >
<input type="hidden" name="nexturl" value="<%=nexturl%>" />
<input type="hidden" name="act" value="" />
<input type="hidden" name="md2" value="md2"/>
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
