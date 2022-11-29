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
String nuid = teasession.getParameter("nuid");
int nid = Node.findNumber(teasession._strCommunity,nuid);
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
  <title>分店商品销售统计详细</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>分店商品销售统计详细</h1>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr>
             <td nowrap><b>条形码或编号：</b></td>
             <td nowrap><%=nuid%></td>
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
                <td nowrap>分店名称</td>
                <td nowrap>分店类型</td>
                <td nowrap>分店所属区域</td>
                 <td nowrap>销售时间</td>
                <td nowrap>销售数量</td>
                <td nowrap>销售金额</td>
              </tr>
              <%
              int i = 1;
              java.util.Enumeration e = ICSalesList.find(" AND no ="+DbAdapter.cite(nuid),0,Integer.MAX_VALUE);
              if(!e.hasMoreElements())
              {
                out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
              }
              while(e.hasMoreElements())
              {
                int icsid =((Integer)e.nextElement()).intValue();
                ICSalesList icsobj = ICSalesList.find(icsid);
                ICSales icobj = ICSales.find(icsobj.getIcsales());
                LeagueShop lsobj = LeagueShop.find(icobj.getLeagueshop());
                LeagueShopType objty = LeagueShopType.find(lsobj.getLstype());
                Card card1 = Card.find(lsobj.getProvince());
                Card card2 = Card.find(lsobj.getCity());

              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td align="center"><%=i%></td>
                <td ><%=lsobj.getLsname() %></td>
                <td align="center"><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
                <td align="center"><%=LeagueShop.CSAREA[lsobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
                <td align="center"><%=icobj.getTimeToString()%></td>
                <td align="center"><%=icsobj.getQuantity()%></td>
                <td align="center"><%=icsobj.getPrice() %>&nbsp;元</td>
              </tr>
              <%i++;} %>
            </table>
          </span>


          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>


        </body>
</html>
