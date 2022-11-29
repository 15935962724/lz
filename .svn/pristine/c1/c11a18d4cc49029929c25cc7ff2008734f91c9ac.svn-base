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
String nexturl = teasession.getParameter("nexturl");
String paid = teasession.getParameter("paid");
Paidinfull pobj = Paidinfull.find(paid);
LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/erp.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>进货单信息审核</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff" >
        <script type="">

        function f_p(igd)
        {
           form1.act.value='AuditShopstock';
           form1.purid.value=igd;
           form1.action='/servlet/EditPaidinfull';
           form1.submit();
        }
          f_show('<%=pobj.getSupplname()%>','<%=paid%>');
        </script>
        <div id="lzi_rkd">
          <h1>进货单信息审核</h1>
          <form action="?" method="POST" name="form1">
       <input type="hidden" name="purid" value="<%=paid%>"/>

          <input type="hidden" name="act">
            <input type="hidden" name="nexturl" value="<%=nexturl%>">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td >加盟店名称：</td>
              <td ><%=lsobj.getLsname()%> </td>
              <td nowrap>仓库名称：</td>
              <td colspan="2"><%=Warehouse.find(pobj.getWaridname()).getWarname()%></td>
            </tr>
            <tr>
              <td nowrap>销售日期：</td>
              <td><%=pobj.getTime_sToString() %></td>
              <td  nowrap>销售单号：</td>
              <td ><%=paid %></td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr id="tableonetr">
              <td align="center" nowrap>条形码或编号</td>
              <td align="center" nowrap>商品名称</td>
              <td align="center" nowrap>规格型号</td>
              <td align="center" nowrap>品牌</td>
              <td align="center" nowrap>单位</td>
              <td align="center" nowrap>单价</td>
              <td align="center" nowrap>折扣</td>
              <td align="center" nowrap>活动打折</td>
              <td align="center" nowrap>折后单价</td>
              <td align="center" nowrap>数量</td>
              <td align="center" nowrap>金额</td>
                <td align="center" nowrap>备注</td>
            </tr>
            <%
            java.util.Enumeration e  = GoodsDetails.find(teasession._strCommunity," AND paid = "+DbAdapter.cite(paid),0,Integer.MAX_VALUE);
            for(int i = 1;e.hasMoreElements();i++)
            {
              int gdid = ((Integer)e.nextElement()).intValue();
              GoodsDetails gdobj = GoodsDetails.find(gdid);
              int n = gdobj.getNode();
              Node nobj = Node.find(n);
              Goods gobj=Goods.find(n);
              Commodity cobj = Commodity.find_goods(n);
              BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
//                GoodsDetails gdobj = GoodsDetails.find(GoodsDetails.getGDid(paid,n));
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td><%=nobj.getNumber() %></td>
                <td><%=nobj.getSubject(teasession._nLanguage) %></td>
                <td><%=gobj.getSpec(teasession._nLanguage) %></td>
                <td><%
                Brand b=null;
                if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
                {
                  if(b.getNode()>0)
                  out.print(b.getName(teasession._nLanguage));
                }

                %></td>
                <td align="center"><%=gobj.getMeasure(teasession._nLanguage)%></td>
                <td align="center"><%=gdobj.getSupply()%></td>
                <td align="center"><%=gdobj.getDiscount()%>&nbsp;折</td>
                  <td align="center"><%if(gdobj.getDiscount2()!=null)out.print(gdobj.getDiscount2());%>&nbsp;折</td>
                 <td align="center"><%=gdobj.getDsupply()%>&nbsp;元</td>
                <td align="center"><%=gdobj.getQuantity()%></td>

                <td align="center"><%=gdobj.getTotal() %>&nbsp;元</td>
                  <td align="center"><%if(gdobj.getRemarksarr()!=null&&gdobj.getRemarksarr().length()>0){out.print(gdobj.getRemarksarr());}else {out.print("&nbsp;");}%></td>
              </tr>
              <%} %>
              <tr>

                <td colspan="5" align="right"><b>折前金额:</b></td>
                <td align="center"><%=pobj.getTotal() %>&nbsp;元</td>
                <td align="right" colspan="3"><b>折后数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity() %></td>
                <td align="center" ><%=pobj.getTotal_2()%>&nbsp;元</td>
                <td>&nbsp;</td>
              </tr>

          </table>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td  nowrap>经办人：</td>
              <td id="jin1"><%
              Profile p1 = Profile.find(pobj.getMember());
              out.print(p1.getLastName(teasession._nLanguage)+p1.getFirstName(teasession._nLanguage));
              %> </td>

                  <td  nowrap>联系人：</td>
              <td><%
              if(pobj.getMember2()!=null){
                Profile p2= Profile.find(pobj.getMember2());
                out.print(p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage));
              }
              %></td>
              <td  nowrap>联系电话：</td>
              <td id="jin1"><%if(pobj.getTelephone()!=null)out.print(pobj.getTelephone()); %></td>
            </tr>
            <tr>

                <td  nowrap>联系地址：</td>
                <td  id="jin2" colspan="5"><%if(pobj.getAddress()!=null)out.print(pobj.getAddress()); %></td>
            </tr>
            <tr>
             <td  nowrap>备注：</td>
                  <td  id="jin2" colspan="5"><%if(pobj.getRemarks()!=null)out.print(pobj.getRemarks());%></td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>

        </div>

        <br>
        <input type=button value="返回" onClick="javascript:history.back()">&nbsp;
        <input type="button" value="确认审核"  onclick="f_p('<%=paid%>');"/>

   </form>
        </body>
</html>
