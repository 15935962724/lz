<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();

  StringBuffer sql = new StringBuffer("  AND type !=7 AND type !=8   ");
  //判断用户加盟店
  AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  LeagueShop lsobj = LeagueShop.find(LeagueShop.findid(arobj.getUnit()));
  if(lsobj.getId()!=0){
    sql.append(" AND ");
    sql.append(" supplname= ").append(lsobj.getId());
  }else
  {
   sql.append(" AND ");
    sql.append(" supplname= 0");
  }
//  for(int i =1;i<arobj.getDept().split("/").length;i++)
//  {
//    int dept =Integer.parseInt(arobj.getDept().split("/")[i]);
//    LeagueShop lsobj2 = LeagueShop.find(LeagueShop.findid(dept));
//    if(lsobj2.getId()!=0){
//
//      sql.append(" supplname=").append(lsobj2.getId());
//      if(arobj.getDept().split("/").length>i+1)
//      {
//        sql.append(" or supplname=").append(lsobj2.getId());
//      }else
//      {
//        sql.append(")");
//      }
//    }
//  }
//sql.append(Paidinfull.getLeagueShopId(teasession._strCommunity,teasession._rv.toString()));
int count = Paidinfull.count(teasession._strCommunity,sql.toString());
  sql.append(" order by time_s desc ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>进货单管理</title>
</head>
<body id="bodynone">
<script>
function f_edit(igd)
{
  form1.purid.value= igd;
  form1.action="/jsp/erp/EditShopstock.jsp";
  form1.submit();
}
function f_delete(igd){
  if(confirm('您确定要删除此内容吗？')){
    form1.purid.value= igd;
    form1.act.value= 'delete';
    form1.action = "/servlet/EditPaidinfull";
    form1.submit();
  }
}
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/PaidinfullShow.jsp?paid='+igd;///ShopstockShow
  window.showModalDialog(url,self,y);
}
function f_delete2(igd){
  if(confirm('您确定要删除此内容吗？')){
    form1.purid.value= igd;
    form1.act.value= 'delete2';
    form1.action = "/servlet/EditPaidinfull";
    form1.submit();
  }
}
</script>
  <h1>进货单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表(<%=count%>)</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="purid">
   <input type="hidden" name="act" value="delete">
   <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>进货单号</td>
      <td nowrap>进货日期</td>
      <td nowrap>进货数量</td>
      <td nowrap>进货金额</td>
      <td nowrap>订单状态</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = Paidinfull.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
       while(e.hasMoreElements())
       {
         String paid = ((String)e.nextElement());
         Paidinfull pobj = Paidinfull.find(paid);

    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><a href="#" onclick="f_c('<%=paid%>');"><%=paid%></a></td>
      <td align="center"><%=pobj.getTime_sToString()%></td>
      <td align="center"><%=pobj.getQuantity() %></td>
      <td align="center"><%=pobj.getTotal_2()%></td>
      <td><%

      if(pobj.getType()==0){
        out.print("处理中");
      }else if(pobj.getType()==1)
      {
        out.print("等待总部确认订单");
      }
      else if(pobj.getType()==2 || pobj.getType()==3)
      {
        out.print("已下单,正在备货");
      }else if(pobj.getType()==4)
      {
        out.print("备货完成，正在发货");
      }else if (pobj.getType() == 5)
      {
        out.print("发货完成，请等待收货");
      }else if(pobj.getType() == 6)
      {
        out.print("货物已经收到，订单完成");
      }
      %></td>

      <td >
      <%
      if(pobj.getType()==0)
      {
        out.print("<input type=button value=确认总部订单 onclick=window.open('/jsp/erp/AuditShopstock.jsp?nexturl="+nexturl+"&paid="+paid+"','_self'); > ");
      } else if( pobj.getType() ==1)
      {
        out.print("<input  type=button value=编辑 onclick=f_edit('"+paid+"'); >&nbsp;<input type=button value=删除  onclick=f_delete('"+paid+"'); >");
      }
      else if( pobj.getType() ==2 || pobj.getType()==3 || pobj.getType()==4 )
      {
        out.print("<input  type=button value=编辑 disabled=\"disabled\"  style=\"background:#666666\" >&nbsp;<input type=button value=删除 disabled=\"disabled\"  style=\"background:#666666\" >");
      }
      else if(pobj.getType()==5)
      {
        out.print("<input  type=button value=编辑 disabled=\"disabled\"  style=\"background:#666666\" >&nbsp;<input type=button value=删除 disabled=\"disabled\"  style=\"background:#666666\" >");
        out.print("&nbsp;<input type=button value=货物到达，确认收货 onclick=window.open('/jsp/erp/ConfirmShopstock.jsp?paid="+paid+"&nexturl="+nexturl+"','_self'); >");
      }else if(pobj.getType() == 6)
      {
        out.print("<input  type=button value=编辑 disabled=\"disabled\"  style=\"background:#666666\" >&nbsp;<input  type=button value=删除 disabled=\"disabled\"  style=\"background:#666666\" >");
      }
      %>

       </td>
    </tr>
    <% }%>
  </table>
  <br />
<input type="button" value="添加进货单" onclick="window.open('/jsp/erp/EditShopstock.jsp?nexturl=<%=nexturl%>','_self');"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
