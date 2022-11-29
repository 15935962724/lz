<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>

<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();
  StringBuffer sql = new StringBuffer();
  StringBuffer param = new StringBuffer();
  param.append("?id=").append(request.getParameter("id"));

  sql.append(" AND (type =2 or type = 3 ) ");

  String time_c = teasession.getParameter("time_c");
  if(time_c!=null && time_c.length()>0)
  {
    sql.append(" AND time_s >=").append(DbAdapter.cite(time_c));
    param.append("&time_c=").append(time_c);
  }
  String time_d = teasession.getParameter("time_d");
  if(time_d!=null && time_d.length()>0)
  {
    sql.append(" AND time_s <=").append(DbAdapter.cite(time_d));
    param.append("&time_d=").append(time_d);
  }
  String purchase = teasession.getParameter("purchase");
  if(purchase!=null && purchase.length()>0)
  {
    sql.append(" AND purchase LIKE '%"+purchase+"%' ");
    param.append("&purchase=").append(purchase);
  }
  String lsname = teasession.getParameter("lsname");
if(lsname!=null && lsname.length()>0)
{
  sql.append(" AND supplname IN (SELECT  id FROM LeagueShop WHERE lsname LIKE "+DbAdapter.cite("%"+lsname+"%")+") ");
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
  int pos = 0, pageSize = 10, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = Paidinfull.count(teasession._strCommunity,sql.toString());
    sql.append(" order by time_s desc ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>库房备货</title>
</head>
<body id="bodynone">
<script type="">
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/PaidinfullShow.jsp?paid='+igd;
  window.showModalDialog(url,self,y);
}
</script>
  <h1>库房备货</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
   <td>销售单号:</td><td><input type="text" name="purchase" value="<%if(purchase!=null)out.print(purchase);%>"/></td>
    <td>下单日期:</td>
    <td>

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
    </td>

    <td>加盟店名称:</td><td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>

<h2>列表(1)</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>销售单号</td>
      <td nowrap>下单日期</td>
      <td nowrap>加盟店名称</td>
      <td nowrap>总价</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = Paidinfull.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    for(int i = 1;e.hasMoreElements();i++){
      String paid = ((String)e.nextElement());
      Paidinfull pobj = Paidinfull.find(paid);
      tea.entity.member.Profile p = tea.entity.member.Profile.find(pobj.getMember());
      LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
      %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><%=i %></td>
      <td align="center"><a href="#" onclick="f_c('<%=paid%>');"><%=paid %></a></td>
      <td align="center"><%=pobj.getTime_sToString() %></td>
      <td align="center"><%=lsobj.getLsname()%></td>
      <td align="center"><%=pobj.getTotal_2() %></td>
      <td align="center"><input type="button" value="审核备货" onclick="window.open('/jsp/erp/StockupDetail.jsp?paid=<%=paid %>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
    <%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
