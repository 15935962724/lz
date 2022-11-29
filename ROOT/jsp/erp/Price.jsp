<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int nodeid = 0;
if(teasession.getParameter("nodeid")!=null && teasession.getParameter("nodeid").length()>0)
{
  nodeid = Integer.parseInt(teasession.getParameter("nodeid"));
}
Node nobj = Node.find(nodeid);
Commodity cobj = Commodity.find_goods(nodeid);
BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>预售价格</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
    <script type="">
    function f_button(igd)
    {
      window.returnValue=igd;
      window.close();
    }
    </script>
    <h1>预售价格</h1>
    <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td>商品名称：</td><td colspan="2"><%=nobj.getSubject(teasession._nLanguage) %></td></tr>
      <tr id="tableonetr">
        <td align="center" nowrap> 行号</td>
        <td align="center" nowrap>价格方式</td>
        <td align="center" nowrap>单价</td>
      </tr>
      <tr onclick="f_button('<%=bpobj.getSupply()%>');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>1</td>
        <td>价格1</td>
        <td><%=bpobj.getSupply() %></td>
      </tr>
      <tr onclick="f_button('<%=bpobj.getList() %>');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>2</td>
        <td>价格2</td>
        <td><%=bpobj.getList() %></td>
      </tr>
      <tr onclick="f_button('<%=bpobj.getPrice() %>');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>3</td>
        <td>价格3</td>
        <td><%=bpobj.getPrice() %></td>
      </tr>
      <tr onclick="f_button('<%=bpobj.getPrice1() %>');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>4</td>
        <td>价格4</td>
        <td><%=bpobj.getPrice1() %></td>
      </tr>
      <tr onclick="f_button('<%=bpobj.getPrice2() %>');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>5</td>
        <td>价格5</td>
        <td><%=bpobj.getPrice2() %></td>
      </tr>
      <tr onclick="f_button('<%=bpobj.getPrice3() %>');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>6</td>
        <td>价格6</td>
        <td><%=bpobj.getPrice3() %></td>
      </tr>
    </table>

    <br>
    <input type="submit" value="确定"/>&nbsp;
    <input type="button" value="关闭"  onClick="javascript:window.close();">
    </form>

    </body>
</html>
