<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="tea.entity.util.*" %>
<%@page import="java.math.BigDecimal"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int leid = 0;
if(teasession.getParameter("leid")!=null && teasession.getParameter("leid").length()>0)
{
  leid = Integer.parseInt(teasession.getParameter("leid"));
}
String nexturl = request.getParameter("nexturl");

LeagueShop leobj = LeagueShop.find(leid);
Card card1 = Card.find(leobj.getProvince());
Card card2 = Card.find(leobj.getCity());
LeagueShopType objty = LeagueShopType.find(leobj.getLsstype());


StringBuffer sql = new StringBuffer(" AND supplname = "+leid);
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&leid=").append(leid);
param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}


count = Paidinfull.count(teasession._strCommunity,sql.toString());


sql.append(" order by quantity desc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>销售统计详细</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>销售统计详细</h1>
          <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr><td colspan="4" align="center"><b><%=leobj.getLsname() %></b></td></tr>
           <tr>
             <td nowrap>加盟店类型：</td>
             <td nowrap><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
             <td nowrap>所属区域：</td>
             <td nowrap><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
           </tr>
          </table>
          <h2>列表(<%=count %>)</h2>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td nowrap>销售单号</td>
                <td nowrap>销售日期</td>
                <td nowrap>销售仓库</td>
                <td nowrap>销售数量</td>
                <td nowrap>销售金额</td>
                <td nowrap>退货数量</td>
                <td nowrap>退货金额</td>
                <td nowrap>操作</td>
              </tr>
              <%
              java.util.Enumeration e = Paidinfull.find(teasession._strCommunity,sql.toString(),pos,pageSize);
              while(e.hasMoreElements())
              {
                String paid = ((String)e.nextElement());
                Paidinfull pobj = Paidinfull.find(paid);
                Warehouse warobj = Warehouse.find(pobj.getWaridname());
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td ><%=paid%></td>
                <td><%=pobj.getTime_sToString() %></td>
                <td><%=warobj.getWarname()%></td>
                <td><%=pobj.getQuantity() %></td>
                <td ><%if(pobj.getTotal_2()!=null)out.print(new BigDecimal(pobj.getTotal_2()).setScale(2,2)); %>&nbsp;元</td>
                  <td><%=GoodsDetails.getReturnQuantity(teasession._strCommunity,paid) %></td>
                <td ><%=GoodsDetails.getAmount(teasession._strCommunity,paid) %>&nbsp;元</td>
                 <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/erp/SaleDetail3.jsp?paid=<%=paid%>','_self');"/></td>
              </tr>
              <%}%>
                <tr>
                  <td colspan="2">&nbsp;</td>
                  <td align="right"><b>合计数量和金额：</b></td>
                  <td><%=Paidinfull.getShuLiang(teasession._strCommunity,leid)%></td>
                  <td ><%=Paidinfull.getJinE(teasession._strCommunity,leid)%></td>
                  <td ><%=ReturnedShop.getReturnQuantity(teasession._strCommunity,leid) %></td>
                  <td><%=ReturnedShop.getAmount(teasession._strCommunity,leid)%>元</td>
              </tr>
              <%if (count > pageSize) {  %>
              <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
              <%}  %>
            </table>
          <br>
          <input type=button value="返回" onclick="window.open('<%=nexturl%>','_self');">
        </div>

          </form>

        </body>
</html>
