<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(request.getMethod().equals("POST"))
{
  tea.entity.node.Client client_obj=tea.entity.node.Client.find(Integer.parseInt(request.getParameter("client")),teasession._nLanguage);
  if(client_obj.isExists())
  {
    client_obj.setPrice(new java.math.BigDecimal(request.getParameter("price")).add(client_obj.getPrice()));
    response.sendRedirect(request.getRequestURI());
  }else
  {
    out.print(new tea.html.Script("alert('对不起,不存在');history.back();"));
  }
  return;
}
%>
<script>
function fsubmit()
{
 if(isNaN( parseFloat(form1.price.value)))
 {
   alert('请正确输入.');
   form1.price.focus();
   return false;
 }else
 form1.price.value= parseFloat(form1.price.value);
 return true;
}
</script>
<form name="form1" method="post" action="" onsubmit="return fsubmit()">
  <table>
  <tr>
    <td>客户</td>
    <td>
      <%
      tea.html.DropDown select=new tea.html.DropDown("client");
      java.util.Enumeration enumer=      tea.entity.node.Node.findByType(69,node.getCommunity());
      while(enumer.hasMoreElements())
      {
        int fbt_node=((Integer)enumer.nextElement()).intValue();
        select.addOption(fbt_node,tea.entity.node.Node.find(fbt_node).getCreator()._strR);
      }
      out.print(select.toString());
      %>
</td>
  </tr>
  <tr>
    <td>充值</td>
    <td><input type="text" name="price"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="提交"></td>
  </tr>
</table>
</form>

