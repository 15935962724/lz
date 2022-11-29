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
<script src="/tea/erp.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>销售单信息</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff" scroll=yes >
        <script type="">
          f_show('<%=pobj.getSupplname()%>','<%=paid%>');
        function f_p(igd)
        {
         var  rs = window.showModalDialog('/jsp/erp/PaidinfullPrint.jsp?paid='+igd,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
       //  window.open('/jsp/erp/PaidinfullPrint.jsp?paid='+igd,'flow_view','status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=350,left=100,top=100');
        }
        </script>
        <div id="lzi_rkd">
          <h1>销售单信息</h1>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td >加盟店名称：</td>
              <td ><%=lsobj.getLsname() %> </td>
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
              int n =gdobj.getNode();
              Node nobj = Node.find(n);
              Goods gobj=Goods.find(n);

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

                <td colspan="6" align="right"><b>折前金额:</b></td>
                <td align="center"><%=pobj.getTotal() %>&nbsp;元</td>
                <td colspan="2" align="right"><b>折后数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity() %></td>
                <td  align="center"><%=pobj.getTotal_2()%>&nbsp;元</td>
              </tr>

          </table>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr>
              <td nowrap>经办人：</td>
              <td  id="jin1"><%
              if(pobj.getMember()!=null){
                Profile p = Profile.find(pobj.getMember());
                out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
              }
              %> </td>

              <td nowrap>联系人：</td>
              <td  id="jin1">
            <%
            if(pobj.getMember2()!=null){
              Profile p2 = Profile.find(pobj.getMember2());
              out.print(p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage));
            }
              %>
              </td>
              <td  nowrap>联系电话：</td>
              <td id="jin1"><%=pobj.getTelephone() %></td>
            </tr>
            <tr>

              <td  nowrap >联系地址：</td>
              <td  id="jin2" colspan="5"><%=pobj.getAddress()%></td>
            </tr>
            <tr>
             <td nowrap >备注：</td>
              <td  id="jin2" colspan="5"><%=pobj.getRemarks()%></td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>
        </div>

        <br>
        <input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
        <input type="button" value="打印"  onclick="f_p('<%=paid%>');"/>


        </body>
</html>
