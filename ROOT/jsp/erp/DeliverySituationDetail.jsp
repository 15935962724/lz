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
String paid =teasession.getParameter("paid");

Paidinfull pobj = Paidinfull.find(paid);
LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
Warehouse warobj = Warehouse.find(pobj.getWaridname());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/erp.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>收货情况</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff">
<script>
  f_show('<%=pobj.getSupplname()%>','<%=paid%>');
</script>
        <div id="lzi_rkd">
          <h1>收货情况</h1>
          <form action="/servlet/EditPaidinfull" method="POST" name="form1" onsubmit="return f_submit();">
          <input type="hidden" name="act" value="ConfirmShopstock"/>
          <input type="hidden" name="purid" value="<%=paid%>"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <h2>商品信息</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>销售单号：</td>
              <td nowrap><%=paid %></td>
              <td nowrap>加盟店名称：</td>
              <td nowrap><%=lsobj.getLsname() %></td>
            </tr>
            <tr>
              <td nowrap>仓库名称：</td>
              <td nowrap><%=warobj.getWarname()%></td>
              <td nowrap>销售日期：</td>
              <td nowrap><%=pobj.getTime_sToString()%></td>
            </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>单价</td>
                <td align="center" nowrap>折扣</td>
                <td align="center" nowrap>活动折扣</td>
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

                int nodeid =gdobj.getNode();
                Node nobj = Node.find(nodeid);
                Goods gobj=Goods.find(nodeid);
                Commodity cobj = Commodity.find_goods(nodeid);
                BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
                %>
               <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                  <td align="center"><%=nobj.getNumber() %></td>
                  <td ><%=nobj.getSubject(teasession._nLanguage) %></td>
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
                  <td align="center"><%=gdobj.getSupply() %></td>
                  <td align="center"><%=gdobj.getDiscount() %>&nbsp;折</td>
                  <td align="center"><%=gdobj.getDiscount2()%>&nbsp;折</td>
                   <td align="center"><%=gdobj.getDsupply()%></td>
                  <td align="center"><%=gdobj.getQuantity()%></td>
                  <td align="center"><%=gdobj.getTotal().trim()%>&nbsp;元</td>
                  <td align="center"><%=gdobj.getRemarksarr()%></td>
                </tr>
                <%} %>
              <tr>
                <td colspan="4">&nbsp;</td>
                <td align="right"><b>折前合计金额:</b></td>
                <td align="center"><%=pobj.getTotal()%>&nbsp;元</td>

                <td align="right" colspan="3"><b>折后合计数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity()%></td>
                <td align="center"><%=pobj.getTotal_2()%>&nbsp;元</td>
                 <td align="center">&nbsp;</td>
              </tr>

            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>经办人：</td>
              <td><%
             Profile pobj1 = Profile.find(pobj.getMember());
             out.print(pobj1.getLastName(teasession._nLanguage)+pobj1.getFirstName(teasession._nLanguage));
              %> </td>
              <td nowrap>联系人：</td>
              <td ><%
             Profile pobj2 = Profile.find(pobj.getMember2());
             out.print(pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));
              %>  </td>

            </tr>
            <tr>
              <td nowrap>备注：</td>
              <td colspan="3"><%=pobj.getRemarks()%></td>
            </tr>
          </table>
                    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>

          <%
          tea.entity.util.Card  c1 =tea.entity.util.Card.find(lsobj.getProvince());//省
          tea.entity.util.Card  c2 =tea.entity.util.Card.find(lsobj.getCity());//市
          %>
          <h2>收货地址</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>&nbsp;发货选择:</td>
              <td>
               <%=Paidinfull.DEL_TYPE[pobj.getDeltype()] %>&nbsp;<%=Paidinfull.DEL_TYPE2[pobj.getDeltype()]+":"+pobj.getDeltype2() %>
              </td>
            </tr>
            <tr>
              <td nowrap>省(州)：</td>
              <td  id="jin1"><%if(pobj.getCity()!=null){out.print(pobj.getCity());}else{out.print(c1.getAddress()+c2.getAddress());}%></td>
            </tr>
            <tr>
              <td nowrap>收货地址</td>
              <td  id="jin1"><% if(pobj.getShipaddress()!=null){out.print(pobj.getShipaddress());}else{out.print( lsobj.getRegion()+lsobj.getPort()+lsobj.getNumber());}%></td>
            </tr>
            <tr>
              <td nowrap>收货人</td>
              <td  id="jin2"><% if(pobj.getConsignee()!=null){out.print(pobj.getConsignee());}else{out.print(pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));}%></td>
            </tr>
            <tr>
              <td nowrap>收货人邮编：</td>
              <td  id="jin2"><%if(pobj.getZip()!=null)out.print(pobj.getZip());%></td>
            </tr>
            <tr>
              <td nowrap>收货人电话：</td>
              <td  id="jin2"><% if(pobj.getTel()!=null){out.print(pobj.getTel());}else{out.print(pobj.getTel());}%></td>
            </tr>
            <tr>
              <td nowrap>发货时间：</td>
              <td  id="jin2"><% out.print(pobj.getStimeToString()); %></td>
            </tr>
            <tr>
              <td nowrap>预计到达时间：</td>
              <td  id="jin2"><%out.print(pobj.getFtimeToString()); %></td>
              </tr>
          </table>
          <br>

          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
