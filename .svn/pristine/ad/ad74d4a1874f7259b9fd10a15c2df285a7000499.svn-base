<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
int shopicard = Integer.parseInt(request.getParameter("shopicard"));

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>加盟店领卡</title>
<script>
function f_c()
{
  var rs = window.showModalDialog('/jsp/erp/LookClient.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null)
  {
    form1.leagueshop.value= rs.split('/')[1];
    //form1.joinname.value= rs.split('/')[2];
  }
}
</script>
</head>
<body id="bodynone" onload="form1.leagueshop.focus();">
<h1>加盟店领卡</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form name="form1" action="/servlet/EditShopICard" onSubmit="return submitText(this.leagueshop,'无效-加盟店')&&submitText(this.icardtype,'无效-卡类型')&&submitInteger(this.quantity,'无效-张数');">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
      <input type="hidden" name="nexturl" value="/jsp/erp/icard/ShopICards.jsp"/>
      <input type="hidden" name="shopicard" value="<%=shopicard%>"/>
      <input type="hidden" name="act" value="edit"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>加盟店:</td>
        <td><%=LeagueShop.toHtml(teasession._strCommunity,0)%><input onclick="f_c()" type="button" value="...">
        </td>
      </tr>
      <tr>
        <td>卡类型:</td>
        <td><%=ICardType.toHtml(teasession._strCommunity,0)%></td>
      </tr>
      <tr>
        <td>张数:</td>
        <td><input name="quantity" type="text" value="1000" mask="int"></td>
      </tr>
      <tr>
        <td>领卡日期:</td>
        <td><%=new tea.htmlx.TimeSelection("time", null)%></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input type="submit" value="保存领卡记录">
          <input type="button" value="返回" onclick='history.back();'></td>
      </tr>
    </table>
  </form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
