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
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String paid = teasession.getParameter("paid");
Paidinfull pobj = Paidinfull.find(paid);
LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>加盟店进货单信息</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff" >
        <script type="">
        function f_p(igd)
        {
           rs = window.showModalDialog('/jsp/erp/PaidinfullPrint.jsp?paid='+igd,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
        }
        </script>
        <div id="lzi_rkd">
          <h1>加盟店进货单信息</h1>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td >加盟店名称：</td>
              <td ><%=lsobj.getLsname() %> </td>
              <td nowrap>仓库名称：</td>
              <td colspan="2"><%=Warehouse.find(pobj.getWaridname()).getWarname()%></td>
            </tr>
            <tr>
              <td nowrap>进货日期：</td>
              <td><%=pobj.getTime_sToString() %></td>
              <td  nowrap>进货单号：</td>
              <td ><%=paid %></td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr id="tableonetr">
              <td align="center" nowrap>商品编号</td>
              <td align="center" nowrap>商品名称</td>
              <td align="center" nowrap>规格型号</td>
              <td align="center" nowrap>品牌</td>
              <td align="center" nowrap>单位</td>
              <td align="center" nowrap>单价</td>
              <td align="center" nowrap>折扣</td>
              <td align="center" nowrap>折后单价</td>
              <td align="center" nowrap>数量</td>

              <td align="center" nowrap>金额</td>
               <td align="center" nowrap>备注</td>
            </tr>
            <%
            String g[] = pobj.getRsgoods().split("/");

            for(int i = 1;i<g.length;i++)
            {
              int n = Integer.parseInt(g[i]);
              Node nobj = Node.find(n);
              Goods gobj=Goods.find(n);
              Commodity cobj = Commodity.find_goods(n);
              BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td align="center"><%=nobj.getNumber() %></td>
                <td align="center"><%=nobj.getSubject(teasession._nLanguage) %></td>
                <td align="center"><%=gobj.getSpec(teasession._nLanguage) %></td>
                <td align="center"><%
                Brand b=null;
                if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
                {
                  if(b.getNode()>0)
                  out.print(b.getName(teasession._nLanguage));
                }

                %></td>
                <td align="center"><%=gobj.getMeasure(teasession._nLanguage)%></td>
                <td align="center"><%=pobj.getSupplyarr().split("/")[i] %></td>
                <td align="center"><%=pobj.getDiscountarr().split("/")[i] %></td>
                 <td align="center"><%=pobj.getDsupplyarr().split("/")[i] %>&nbsp;元</td>
                <td align="center"><%=pobj.getQuantityarr().split("/")[i] %></td>

                <td align="center"><%=pobj.getTotalarr().split("/")[i] %>&nbsp;元</td>
                  <td align="center">&nbsp;</td>
              </tr>
              <%} %>
              <tr>
                <td colspan="5">&nbsp;</td>
                <td align="center"><b>折前金额:</b></td>
                <td align="center"><%=pobj.getTotal() %>&nbsp;元</td>
                <td align="center"><b>折后数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity() %></td>
                <td align="center"><%=pobj.getTotal_2()%>&nbsp;元</td>
              </tr>

          </table>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>经办人：</td>
              <td nowrap><%
              tea.entity.member.Profile p = tea.entity.member.Profile.find(pobj.getMember());
              out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
              %></td>

            </tr>
            <tr>
              <td  nowrap>备注：</td>
              <td  nowrap colspan="5"></td>
            </tr>

          </table>

        </div>

        <br>
        <input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
        <input type="button" value="打印"  onclick="f_p('<%=paid%>');"/>


        </body>
</html>
