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

<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >

<br>
<div id="lzi_rkd">

  <table border="0" cellpadding="0" cellspacing="0" id="tableid1">
    <tr id="lzj_biao_xs">
      <td colspan="3" align="center"><%=lsobj.getLsname()%>加盟店退货单&nbsp;[&nbsp;操作员：&nbsp;管理员&nbsp;]</td>
    </tr>
    <tr>
      <td nowrap >退货日期：<%=rsobj.getTime_sToString()%></td>
      <td nowrap >单据编号：<%=paid %></td>
      <td nowrap>经办人：<%
      tea.entity.member.Profile ps = tea.entity.member.Profile.find(rsobj.getMember());
      out.print(ps.getLastName(teasession._nLanguage)+ps.getFirstName(teasession._nLanguage));
      %></td>
    </tr>
    <tr>
      <td nowrap>退货单位：<%=lsobj.getLsname()%></td>
      <td nowrap>联系电话：<%=rsobj.getTelephone() %></td>
      <td nowrap>地址：<%=rsobj.getAddress()%></td>
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
                <td colspan="6" align="center"></td>
                <td align="center"><b>合计数量和金额</b></td>
                <td align="center"><%=rsobj.getQuantity() %></td>
                <td align="center"><%=rsobj.getTotal_2()%>&nbsp;元</td>
                <td >&nbsp;</td>
              </tr>

          </table>

<br />

<div  id="printbutton">
 <input name="按钮" type="button" onClick="window.print();" value="打印">
 <input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
</div>
      <object  id="WebBrowser"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
      </object>

<style   media=print>
.Noprint{display:none;}
.PageNext{page-break-after:   always;}
</style>
      <!-- document.all.WebBrowser.ExecWB(7,1); -->

      <script type="">
      //-----  下面是打印控制语句  ----------
      window.onbeforeprint=beforePrint;
      window.onafterprint=afterPrint;
      //打印之前隐藏不想打印出来的信息
      var printbutton=document.getElementById('printbutton');
      function beforePrint()
      {
        printbutton.style.display='none';
      }
      //打印之后将隐藏掉的信息再显示出来
      function afterPrint()
      {
        printbutton.style.display='';
        //  window.close();
      }

      　　</SCRIPT>




</div>


</body>
</html>
