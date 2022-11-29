<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
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
int leid = 0;
if(teasession.getParameter("leid")!=null && teasession.getParameter("leid").length()>0)
{
  leid = Integer.parseInt(teasession.getParameter("leid"));
}
int nid = 0;
if(teasession.getParameter("nid")!=null && teasession.getParameter("nid").length()>0)
{
  nid = Integer.parseInt(teasession.getParameter("nid"));
}

StringBuffer sql = new StringBuffer(" AND leagueshop="+leid);
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&leid=").append(leid);
param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));

StringBuffer sql2 = new StringBuffer("  AND ic.node = "+nid);
StringBuffer param2 = new StringBuffer();
param2.append("?id=").append(request.getParameter("id"));
param2.append("&nid=").append(nid);
param2.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = ICInventory.count(sql.toString());

int pos2 = 0, pageSize2 = 10, count2 = 0;
if (request.getParameter("pos2") != null) {
  pos2 = Integer.parseInt(request.getParameter("pos2"));
}
count2 = ICInventory.count(" ic.leagueshop ",sql2.toString());

//Node nobj = Node.find(nid);

sql.append(" order by quantity ASC ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>分店库存统计详细</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>分店库存统计详细</h1>
          <%
            if(leid>0){//分店
            LeagueShop leobj =LeagueShop.find(leid);
            Card card1 = Card.find(leobj.getProvince());
            Card card2 = Card.find(leobj.getCity());
            LeagueShopType objty = LeagueShopType.find(leobj.getLstype());

          %>
          <form action="?" name="form1" method="POST">

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr><td colspan="4" align="center"><b><%=leobj.getLsname() %></b></td></tr>
           <tr>
             <td nowrap>所属区域：</td>
             <td nowrap><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
             <td nowrap>分店类型：</td>
             <td nowrap><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
           </tr>
          </table>
          <h2>列表(<%=count %>)</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
               <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>商品类别</td>
                <td align="center" nowrap>库存数量</td>
              </tr>
              <%
              java.util.Enumeration e1 = ICInventory.find(sql.toString(),pos,pageSize);
              if(!e1.hasMoreElements())
              {
                out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
              }
              while(e1.hasMoreElements()){
                int icid =((Integer)e1.nextElement()).intValue();
                ICInventory icobj = ICInventory.find(icid);
                Node nobj = Node.find(icobj.getNode());
                Goods gobj = Goods.find(icobj.getNode());
                String gts[] =  gobj.getGoodstype().split("/");
                StringBuffer sp = new StringBuffer();
                for(int index=2;index<gts.length;index++)
                {
                  GoodsType gtobj=GoodsType.find(Integer.parseInt(gts[index]));
                  sp.append(gtobj.getName(teasession._nLanguage)+"&nbsp;&nbsp;");
                }

              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
               <td ><%=nobj.getNumber() %></td>
                <td><%=nobj.getSubject(teasession._nLanguage) %></td>
                <td ><%=sp.toString() %></td>
                <td align="center"><%=icobj.getQuantity()%></td>
              </tr>
              <%}if(count>0){ %>
               <tr>
                <td colspan="2">&nbsp;</td>
                <td align="center"><b>库存总量:</b></td>
                <td align="center"><%=ICInventory.getLeQuantity("leagueshop",leid) %></td>
              </tr>
              <%}if (count > pageSize) {  %>
              <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
              <%}  %>
            </table>

               </form>
<%} %>

<%
if(nid>0){
  Node nobj = Node.find(nid);
  Goods gobj = Goods.find(nid);
  String gts[] =  gobj.getGoodstype().split("/");
  StringBuffer sp = new StringBuffer();
  for(int index=2;index<gts.length;index++)
  {
    GoodsType gtobj=GoodsType.find(Integer.parseInt(gts[index]));
    sp.append(gtobj.getName(teasession._nLanguage)+"&nbsp;&nbsp;");
  }

  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><td colspan="4" align="center"><b><%=nobj.getSubject(teasession._nLanguage)%></b></td></tr>
    <tr>
      <td nowrap>条形码或编号：</td>
      <td nowrap><%=nobj.getNumber()%></td>
      <td nowrap>商品类别：</td>
      <td nowrap><%=sp.toString()%></td>
    </tr>
  </table>
    <h2>列表(<%=count2 %>)</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>分店名称</td>
      <td align="center" nowrap>所属区域</td>
      <td align="center" nowrap>分店类型</td>
      <td align="center" nowrap>库存数量</td>
    </tr>
    <%
   java.util.Enumeration e = ICInventory.findLeagueshop(" ic.leagueshop ",sql2.toString(),pos2,pageSize2);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements()){
      int leids =((Integer)e.nextElement()).intValue();
      LeagueShop leobj =LeagueShop.find(leids);
      Card card1 = Card.find(leobj.getProvince());
      Card card2 = Card.find(leobj.getCity());
      LeagueShopType objty = LeagueShopType.find(leobj.getLstype());
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=leobj.getLsname() %></td>
      <td><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
      <td><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
      <td ><%=ICInventory.getLeQuantity2(nid,leids)%></td>
    </tr>
     <%}if(count2>0){ %>
    <tr>
      <td colspan="2">&nbsp;</td>
      <td align="center"><b>库存总量:</b></td>
      <td align="center"><%=ICInventory.getLeTotal(" AND node ="+nid) %></td>
    </tr>
    <%}if (count2 > pageSize2) {  %>
              <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param2.toString()+"&pos2=",pos2,count2,pageSize2)%>    </td> </tr>
              <%}  %>
  </table>

  <%} %>
  <br>
          <input type=button value="返回" onClick="window.open('<%=nexturl%>','_self')">
        </div>


        </body>
</html>
