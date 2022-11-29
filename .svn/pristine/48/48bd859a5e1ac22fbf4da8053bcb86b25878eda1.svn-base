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

String nexturl = teasession.getParameter("nexturl");
int nid = Integer.parseInt(teasession.getParameter("nid"));

Node nobj = Node.find(nid);
Goods gobj = Goods.find(nid);
String gts[] =  gobj.getGoodstype().split("/");
StringBuffer sp = new StringBuffer();
for(int index=2;index<gts.length;index++)
{
  GoodsType gtobj=GoodsType.find(Integer.parseInt(gts[index]));
  sp.append(gtobj.getName(teasession._nLanguage)+"&nbsp;&nbsp;");
}
Commodity cobj = Commodity.find_goods(nid);
BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>采购单商品销售情况统计</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>采购单商品销售情况统计</h1>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr>
             <td nowrap><b>条形码或编号：</b></td>
             <td nowrap><%=nobj.getNumber()%></td>
             <td nowrap><b>商品名称：</b></td>
             <td nowrap><%=nobj.getSubject(teasession._nLanguage)%></td>
           </tr>
           <tr>
             <td nowrap><b>商品类别：</b></td>
             <td nowrap><%=sp.toString() %></td>
             <td nowrap><b>商品品牌：</b></td>
             <td nowrap><%
             Brand b=null;
             if(gobj.getBrand()>0&&(b=Brand.find(gobj.getBrand())).isExists())
             {
               if(b.getNode()>0)
               out.print(b.getName(teasession._nLanguage));
             }
             %></td>
           </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
              <td nowrap>序号</td>
                <td nowrap>加盟店名称</td>
                <td nowrap>销售单号</td>
                <td nowrap>销售日期</td>
                 <td nowrap>仓库名称</td>
                <td nowrap>销售数量</td>
                <td nowrap>销售金额</td>
              </tr>
              <%
              int i = 1;

              java.util.Enumeration e = GoodsDetails.findPai(teasession._strCommunity," and gd.node ="+nid+" order by gd.gdid desc ",0,Integer.MAX_VALUE);
              if(!e.hasMoreElements())
              {
                out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
              }
              int qt = 0;
              java.math.BigDecimal tt = new java.math.BigDecimal("0");
              while(e.hasMoreElements())
              {
                int gdid =((Integer)e.nextElement()).intValue();
                GoodsDetails  gdobj =GoodsDetails.find(gdid);
                Paidinfull pobj = Paidinfull.find(gdobj.getPaid());
                Warehouse warobj = Warehouse.find(pobj.getWaridname());
                LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());

                qt = qt+gdobj.getQuantity();
                tt = tt.add(new java.math.BigDecimal(gdobj.getTotal())).setScale(2,4);

              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td align="center" width="1"><%=i%></td>
                 <td ><%=lsobj.getLsname()%></td>
                 <td ><%=gdobj.getPaid()%></td>
                <td ><%=gdobj.getTime_sToString()%></td>
                <td ><%=warobj.getWarname()%></td>
                <td ><%=gdobj.getQuantity()%></td>
                <td><%=gdobj.getTotal()%>&nbsp;元</td>
              </tr>
              <%i++;} %>
              <%
              if(i>1)
              {
               %>
               <tr>
                 <td colspan="4"></td>
                 <td align="right"><b>总计：</b></td>
                 <td ><%=qt%></td>
                 <td colspan="2" ><%=tt%>&nbsp;元</td>

               </tr>
               <%}%>

            </table>
          </span>


          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>


        </body>
</html>
