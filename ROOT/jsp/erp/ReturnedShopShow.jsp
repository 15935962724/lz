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
ReturnedShop rsobj = ReturnedShop.find(paid);
LeagueShop lsobj = LeagueShop.find(rsobj.getSupplname());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>加盟店退货单详细信息</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff" >
        <script type="">
        function f_p(igd)
        {
           rs = window.showModalDialog('/jsp/erp/ReturnedShopPrint.jsp?paid='+igd,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
        }
        </script>
        <div id="lzi_rkd">
          <h1>加盟店退货单详细信息</h1>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
          <td align="center" colspan="4"><b><%=lsobj.getLsname() %></b></td>
          </tr>
            <tr>
              <td nowrap>退货日期：</td>
              <td><%=rsobj.getTime_sToString()%></td>
              <td  nowrap>退货单号：</td>
              <td ><%=paid%></td>
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
              <td align="center" nowrap>折后单价</td>
              <td align="center" nowrap>数量</td>
              <td align="center" nowrap>金额</td>
              <td align="center" nowrap>备注</td>
            </tr>
            <%
              java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(paid),0,Integer.MAX_VALUE);
              for(int i = 1;e.hasMoreElements();i++)
              {
                int gdid = ((Integer)e.nextElement()).intValue();
                GoodsDetails gdobj = GoodsDetails.find(gdid);
                int nodeid =gdobj.getNode(); //Integer.parseInt(chersarr[i]);
                Node nobj = Node.find(nodeid);
                Goods g=Goods.find(nodeid);
                Commodity cobj = Commodity.find_goods(nodeid);
                BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);

            %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td align="center"><%=nobj.getNumber()%></td>
                <td align="center"><%=nobj.getSubject(teasession._nLanguage) %></td>
                <td align="center"><%=g.getSpec(teasession._nLanguage) %></td>
                <td align="center"><%
                Brand b=null;
                if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
                {
                  if(b.getNode()>0)
                  out.print(b.getName(teasession._nLanguage));
                }
                %></td>
                <td align="center"><%=g.getMeasure(teasession._nLanguage)%></td>
                <td align="center"><%out.print(gdobj.getSupply());%></td>
                <td align="center"><%=gdobj.getDsupply()%></td>
                  <td align="center"><%=gdobj.getQuantity()%></td>
                  <td align="center"><%=gdobj.getTotal()%></td>
                  <td align="center"><%=gdobj.getRemarksarr()%></td>
              </tr>
              <%}%>
              <tr>
                <td colspan="4" align="center"><font color="red">退货成功，共加回&nbsp;<%=rsobj.getTotal_2()%>&nbsp;元预付款，请注意查看</font></td>
                <td align="center"><b>合计数量和金额</b></td>
                <td align="center"><%=rsobj.getQuantity() %></td>
                <td align="center"><%=rsobj.getTotal_2()%>&nbsp;元</td>
                <td >&nbsp;</td>
              </tr>

          </table>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>经办人：</td>
              <td nowrap>管理员</td>
               <td  nowrap>备注：</td>
              <td  nowrap colspan="5"></td>
            </tr>
 <tr>
              <td  nowrap>联系人：</td>
              <td>
               <%
               if(rsobj.getMember2()!=null){
                 tea.entity.member.Profile pobj2 = tea.entity.member.Profile.find(rsobj.getMember2());
                 out.print(pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));
               }
               %>
              </td>
              <td  nowrap>联系电话：</td>
              <td id="jin1"><%if(rsobj.getTelephone()!=null)out.print(rsobj.getTelephone()); %></td>
                <td  nowrap>联系地址：</td>
                <td  id="jin2"><%if(rsobj.getAddress()!=null)out.print(rsobj.getAddress()); %></td>
            </tr>
          </table>

        </div>

        <br>
        <input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
        <input type="button" value="打印"  onclick="f_p('<%=paid%>');"/>


        </body>
</html>
