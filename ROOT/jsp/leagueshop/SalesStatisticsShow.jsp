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
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>
<%

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int lsid = 0;
if(teasession.getParameter("lsid")!=null && teasession.getParameter("lsid").length()>0)
{
  lsid = Integer.parseInt(teasession.getParameter("lsid"));
}

StringBuffer sql = new StringBuffer( " AND leagueshop = "+lsid );
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&lsid=").append(lsid);

LeagueShop leobj = LeagueShop.find(lsid);
LeagueShopType objty = LeagueShopType.find(leobj.getLsstype());//分店类型
Card card1 = Card.find(leobj.getProvince());
Card card2 = Card.find(leobj.getCity());



int pos = 0, pageSize = 15, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
 

 count = ICSales.count2(sql.toString());
sql.append(" order by time desc ");
 
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>分店销售情况统计详细</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>分店销售情况统计详细</h1>
          <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr><td colspan="4" align="center"><b><%=leobj.getLsname() %></b></td></tr>
           <tr>
             <td nowrap>分店类型：</td>
             <td nowrap><%if(objty.getLstypename()!=null)out.print(objty.getLstypename());%></td>
             <td nowrap>所属区域：</td>
             <td nowrap><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
           </tr>

          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
              <td nowrap>序号</td>
                <td nowrap>销售单号</td>
                <td nowrap>销售日期</td>
                <td nowrap>销售数量</td>
                <td nowrap>销售金额</td>
                <td nowrap>操作</td>
              </tr>
              <%
                java.util.Enumeration e = ICSales.find(sql.toString(),pos,pageSize);
                if(!e.hasMoreElements())
                {
                  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
                }
                for(int i = 1;e.hasMoreElements();i++)
                {
                  String icid = ((String)e.nextElement());
                  ICSales icobj = ICSales.find(icid);
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td width="1" align="center"><%=i%></td>
                <td><%=icid %></td>
                <td align="center"><%=icobj.getTimeToString() %></td>
                <td><%=icobj.getQuantity() %></td>
                <td ><%if(icobj.getPrice()!=null)out.print(icobj.getPrice());%>&nbsp;元</td>
                 <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/erp/SaleDetail2.jsp?lsid=<%=lsid%>&icid=<%=icid%>','_self');"/></td>
              </tr>
              <%}%>
                 <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
            </table>
          </span>


          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
