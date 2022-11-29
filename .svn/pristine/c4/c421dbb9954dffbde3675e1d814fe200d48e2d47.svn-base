<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();
String memberid = teasession.getParameter("memberid");
Profile pobj = Profile.find(memberid);
LeagueShop lsobj =LeagueShop.find(pobj.getAgent());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店会员消费信息</title>
</head>
<body id="bodynone">
<script type="">
function f_smc()
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:957px;dialogHeight:515px;';
  var url = '/jsp/leagueshop/ShopMemberConsumeShow.jsp'
  window.showModalDialog(url,self,y);
}
</script>
<h1>分店会员消费信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form accept="?" name="form2">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>会员姓名:</td><td><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%></td>
      <td>会员性别：</td> <td><%if(pobj.isSex()){out.print("男");}else{out.print("女");}%></td>
      <td>会员卡号：</td>
      <td><%=memberid%></td>
      <td>入会日期:</td>
      <td><%=pobj.getTimeToString()%></td>
    </tr>
    <tr>
      <td>联系地址:</td>
      <td colspan="5"><%=pobj.getAddress(teasession._nLanguage) %></td>
      <td>Tel联系电话:</td>
      <td><%=pobj.getTelephone(teasession._nLanguage) %></td>
    </tr>

  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>消费单号</td>
      <td align="center" nowrap>消费日期</td>
      <td align="center" nowrap>消费商品数量</td>
      <td align="center" nowrap>消费金额</td>
    </tr>
    <%
    String sql =" and ics.icard="+DbAdapter.cite(memberid)+"  group   by  ic.icsales ";
    boolean f = false;
    java.util.Enumeration e = ICSales.findIcsales(sql,0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements())
    {
      String icid = ((String)e.nextElement());
      ICSales icobj = ICSales.find(icid);
      f = true;

    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center" nowrap><%=icid%></td>
      <td align="center"><%=icobj.getTimeToString() %></td>
      <td align="center"><%=icobj.getQuantity()%></td>
      <td align="center"><%=icobj.getPrice()%>&nbsp;元</td>
    </tr>
    <%} %>
    <%if(f){%>
    <tr>
     <td align="center">&nbsp;</td>
      <td align="center"><b>合计:</b></td>
      <td align="center"><%=ICSales.getShuLiang(sql) %></td>
      <td align="center"><%=ICSales.getJinE(sql) %>&nbsp;元</td>
    </tr>
    <%}%>
  </table>

  </form>
  <br />
  <input type=button value="返回" onClick="javascript:history.back()">
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
