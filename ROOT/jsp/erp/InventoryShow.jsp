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
<%@page import="java.math.BigDecimal"%>
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
int warid = Integer.parseInt(teasession.getParameter("warid"));
   Warehouse warobjs = Warehouse.find(warid);
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
  <title>库存商品明细账列表</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>库存商品明细账列表</h1>
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
           <tr>
           <td><b>商品规格</b></td>
           <td><%=gobj.getSpec(teasession._nLanguage) %></b></td>
            <td><b>所在仓库</b></td>
           <td><%=warobjs.getWarname()%></b></td>
           </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
              <td nowrap>序号</td>
                <td nowrap>单据编号</td>
                <td nowrap>添加日期</td>
                <td nowrap>单据类型</td>
                <td nowrap>数量</td>
                <td nowrap>金额</td>
              </tr>
              <%
              int i = 1;

              java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," and type <=7 and time_s is not null  and warehouse = "+warid+" and node ="+nid+" order by time_s desc ",0,Integer.MAX_VALUE);
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
                String s = gdobj.getTotal();
				if(gdobj.getSupply_2()!=null && gdobj.getSupply_2().length()>0)
				{
						s = new BigDecimal(String.valueOf(gdobj.getQuantity())).multiply(new BigDecimal(gdobj.getSupply_2())).setScale(2,BigDecimal.ROUND_HALF_UP).toString();
				} 
				String q = String.valueOf(gdobj.getQuantity());
				if(gdobj.getType()!=1 && gdobj.getType()!=2)
				{
					s = "-"+s;
					q = "-"+q;
					tt = tt.subtract(new java.math.BigDecimal(s)).setScale(2,4);
				}else
				{
					tt = tt.add(new java.math.BigDecimal(s)).setScale(2,4);
				}
                qt = qt+(Integer.parseInt(q));
                
               // "总部销售单","加盟店退货单","总部采购单","总部退货单","总部调拨单","总部报损单","总部配送单","总部赠送单"
               
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td align="center" width="1"><%=i%></td>
                 <td ><%=gdobj.getPaid()%></td>
                 <td ><%=gdobj.getTime_sToString()%></td>
                <td ><%=GoodsDetails.TYPE[gdobj.getType()]%></td>
                <td ><%=q%></td>
                <td><%=s%>&nbsp;元</td>
              </tr>
              <%i++;} %>
              <%
              if(i>1)
              {
               %>
               <tr>
                 <td colspan="3"></td>
                 <td align="right"><b>总计：</b></td>
                 <td ><%=qt%></td>
                 <td colspan="3" ><%=tt%>&nbsp;元</td>

               </tr>
               <%}%>

            </table>
          </span>


          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>


        </body>
</html>
