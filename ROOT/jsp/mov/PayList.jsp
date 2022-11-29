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
 MemberType obj = MemberType.find(membertype);
 RegisterInstall riobj = RegisterInstall.find(membertype);
if("paylist".equals(teasession.getParameter("act")))
{
  MemberPay mpobj = MemberPay.find(Integer.parseInt(teasession.getParameter("payid")));
  mpobj.delete();
}

%>


<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">

 function f_delete(igd)
 {
   form2.payid.value=igd;
   form2.action='?';
   form2.submit();
 }
</script>
</head>
<body >

<form action="?" name="form2" >
<input type="hidden" name="membertype" value="<%=membertype%>" />
<input type="hidden" name="payid"  />
<input type="hidden" name="act" value="paylist" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>缴费金额</td>
    <td>缴费期限</td>
    <td>缴费说明</td>
    <td>操作</td>
  </tr>
  <%
     java.util.Enumeration e = MemberPay.find(teasession._strCommunity," AND membertype="+membertype,0,Integer.MAX_VALUE);
     if(!e.hasMoreElements())
     {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
     }

     while(e.hasMoreElements())
     {
       int payid = ((Integer)e.nextElement()).intValue();
       MemberPay mobj = MemberPay.find(payid);
  %>
   <tr>
    <td><%=mobj.getPaymoney()%>元</td>
    <td><%=mobj.getPaytime()%>年</td>
    <td><%=mobj.getPaycontent()%></td>
    <td><input type="button" value="编辑" onclick="window.showModalDialog('/jsp/mov/EditPay.jsp?payid=<%=payid%>&membertype=<%=membertype%>',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:600px;dialogHeight:200px;');";>
      &nbsp;&nbsp;<input type="button" value="删除" onclick="f_delete('<%=payid%>');"/></td>
  </tr>
  <%} %>


</table>
<br>
</form>

</body>
</html>

