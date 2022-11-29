<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(request.getMethod().equals("POST"))
{
  tea.entity.node.Salesmanship obj=tea.entity.node.Salesmanship.find(Integer.parseInt(request.getParameter("waiter")),Integer.parseInt(request.getParameter("trade")));
  if(obj.isExists())
  {
    out.print(new tea.html.Script("alert('此记录已经存在。');history.back();"));
  }else
  {
    obj.set();
    response.sendRedirect(request.getRequestURI()+"?"+request.getQueryString());
  }
  return;
}
%>
<form name="form1" method="post" action="">

<table border="1">
  <tr>
    <td>作业员</td>
    <td>
      <select name="waiter">
        <%
java.util.Enumeration enumer=        tea.entity.node.Waiter.find(node.getCommunity());
while(enumer.hasMoreElements())
{
  tea.entity.node.Waiter waiter=  tea.entity.node.Waiter.find(((Integer)  enumer.nextElement()).intValue(),teasession._nLanguage);
  out.print("<option value="+waiter.getNode()+">"+waiter.getCode());
}
        %>
    </select></td>
    <td>订单</td>
    <td>
      <select name="trade">
                <%
                enumer=tea.entity.member.Trade.find();
                while(enumer.hasMoreElements())
                {
                  int trade=((Integer)enumer.nextElement()).intValue();
                  // tea.entity.member.Trade trade=  tea.entity.member.Trade.find();
                  out.print("<option value="+trade+">"+trade);
                }
        %>

      </select>
    </td>
    <td><input type="submit" name="Submit" value="添加"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
