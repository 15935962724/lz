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
Paidinfull pobj =Paidinfull.find(paid);
 LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/erp.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>库房备货</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
<script type="text/javascript">
  f_show('<%=pobj.getSupplname()%>','<%=paid%>');
  

  
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/PaidinfullShow.jsp?paid='+igd;
  window.showModalDialog(url,self,y);
}
function f_sub()
{
	
}
</script>
        <div id="lzi_rkd">
          <h1>库房备货订单详细</h1>
          <form action="/servlet/EditPaidinfull" method="POST" name="form1" onsubmit="return f_sub();">
          <input type="hidden" name="act" value="StockupDetail"/>
          <input type="hidden" name="purid" value="<%=paid%>"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>销售单号：</td>
              <td nowrap><%=paid %></td>
                <td nowrap>加盟店名称：</td>
                <td nowrap><%=lsobj.getLsname()%></td>
            </tr>
            <tr>
              <td nowrap>仓库名称：</td>
              <td nowrap><%
              Warehouse warobj = Warehouse.find(pobj.getWaridname());
              out.print(warobj.getWarname());
              %></td>
              <td nowrap>下单日期：</td>
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
                int goodsid = gdobj.getNode();
                Node nobj = Node.find(goodsid);
                Goods gobj=Goods.find(goodsid);

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
                  <td align="center"><%if(gdobj.getDiscount2()!=null)out.print(gdobj.getDiscount2());%>&nbsp;折</td>
                  <td align="center"><%=gdobj.getQuantity()%></td>
                  <td align="center"><%=gdobj.getTotal()%>&nbsp;元</td>
                  <td align="center"><%=gdobj.getRemarksarr()%></td>
                </tr>
                <%} %>
              <tr>
                <td colspan="4">&nbsp;</td>
                <td align="right"><b>折前合计金额:</b></td>
                <td align="center"><%=pobj.getTotal()%></td>
                <td align="right" colspan="2"><b>折后合计数量和金额：</b></td>
                <td align="center"><%=pobj.getQuantity() %></td>
                <td align="center"><%=pobj.getTotal_2() %>&nbsp;元</td>

              </tr>

            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>经办人：</td>
              <td  id="jin1"><%
              Profile p = Profile.find(pobj.getMember());
              out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
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

              <td  nowrap>联系地址：</td>
              <td  id="jin2" colspan="5"><%=pobj.getAddress()%></td>
            </tr>
            <tr>
              <td nowrap>备注：</td>
              <td  id="jin2" colspan="5"><%=pobj.getRemarks()%></td>
            </tr>
          </table>
          
          
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td>库房备货确认人员：&nbsp;
              <input type="text" name="sdmember1" id="sdmember1"  value="<%if(pobj.getSdmember1()!=null&&pobj.getSdmember1().length()>0)out.print(pobj.getSdmember1()); %>"  <%if(pobj.getSdmember1()!=null&&pobj.getSdmember1().length()>0)out.print("readonly"); %>>&nbsp;
              <input type="text" name="sdmember2"  id="sdmember2" value="<%if(pobj.getSdmember2()!=null&&pobj.getSdmember2().length()>0)out.print(pobj.getSdmember2()); %>" <%if(pobj.getSdmember1()!=null&&pobj.getSdmember2().length()>0)out.print("readonly"); %>>&nbsp;
              <input type="text" name="sdmember3"  id="sdmember3" value="<%if(pobj.getSdmember3()!=null&&pobj.getSdmember3().length()>0)out.print(pobj.getSdmember3()); %>" <%if(pobj.getSdmember1()!=null&&pobj.getSdmember3().length()>0)out.print("readonly"); %>>&nbsp;
              <input type="text" name="sdmember4"  id="sdmember4" value="<%if(pobj.getSdmember4()!=null&&pobj.getSdmember4().length()>0)out.print(pobj.getSdmember4()); %>" <%if(pobj.getSdmember1()!=null&&pobj.getSdmember4().length()>0)out.print("readonly"); %>>&nbsp; (注：填写检查订单信息人员的名称)
              </td>
            </tr>
          </table>
          

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>
          
          
          <br>
          <input type="submit" value="备货完成">&nbsp;
          <input type="button" value="打印"   onclick="f_c('<%=paid%>');">&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>
<script>
  var sd1 = document.getElementById("sdmember1");
  var sd2 = document.getElementById("sdmember2");
  var sd3 = document.getElementById("sdmember3");
  var sd4 = document.getElementById("sdmember4");
  
  if(sd1.value=='')
  {
	  sd2.readOnly='true';
	   sd3.readOnly='true';
	    sd4.readOnly='true';
  }else if(sd2.value=='')
  {
	   sd3.readOnly='true';
	    sd4.readOnly='true';
  }else if(sd3.value=='')
  {

	    sd4.readOnly='true';
  }
  
</script>
          </form>

        </body>
</html>
