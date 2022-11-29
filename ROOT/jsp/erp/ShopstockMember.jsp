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
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();

int lsid = Integer.parseInt(teasession.getParameter("lsid"));
  StringBuffer sql = new StringBuffer("  AND type !=7 AND type !=8   ");
  //判断用户加盟店

  LeagueShop lsobj = LeagueShop.find(lsid);
  if(lsobj.getId()!=0){
    sql.append(" AND ");
    sql.append(" supplname= ").append(lsobj.getId());
  }
    int count = Paidinfull.count(teasession._strCommunity,sql.toString());
  sql.append(" order by time_s desc ");


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>

</head>
<body id="bodynone">
<script>

function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/ShopstockShow.jsp?paid='+igd;
  window.showModalDialog(url,self,y);
}

</script>
  <h1>进货单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表(<%=count %>)</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="purid">
   <input type="hidden" name="act" value="delete">
   <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>进货单号</td>
      <td nowrap>进货日期</td>
      <td nowrap>进货数量</td>
      <td nowrap>进货金额</td>
      <td nowrap>订单状态</td>

    </tr>
    <%
    java.util.Enumeration e = Paidinfull.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
       while(e.hasMoreElements())
       {
         String paid = ((String)e.nextElement());
         Paidinfull pobj = Paidinfull.find(paid);

    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><a href="#" onclick="f_c('<%=paid%>');"><%=paid%></a></td>
      <td align="center"><%=pobj.getTime_sToString()%></td>
      <td align="center"><%=pobj.getQuantity() %></td>
      <td align="center"><%=pobj.getTotal_2()%></td>
      <td align="center"><%

      if(pobj.getType()==0){
        out.print("处理中");
      }else if(pobj.getType()==1)
      {
        out.print("等待总部确认订单");
      }
      else if(pobj.getType()==2 || pobj.getType()==3)
      {
        out.print("已下单,正在备货");
      }else if(pobj.getType()==4)
      {
        out.print("备货完成，正在发货");
      }else if (pobj.getType() == 5)
      {
        out.print("发货完成，请等待收货");
      }else if(pobj.getType() == 6)
      {
        out.print("货物已经收到，订单完成");
      }
      %></td>


    </tr>
    <% }%>
  </table>
  <br />

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
