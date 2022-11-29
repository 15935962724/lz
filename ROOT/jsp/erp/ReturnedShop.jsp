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

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();
StringBuffer sql = new StringBuffer();
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

  sql.append(" order by time_s desc ");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>加盟店退货单管理</title>
</head>
<body id="bodynone">
<script>
function f_edit(igd)
{
  form1.purid.value= igd;
  form1.action="/jsp/erp/EditReturnedShop.jsp";
  form1.submit();
}
function f_delete(igd){
  if(confirm('您确定要删除此内容吗？')){
    form1.purid.value= igd;
    form1.act.value= 'delete';
    form1.action = "/servlet/EditReturnedShop";
    form1.submit();
  }
}
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/ReturnedShopShow.jsp?paid='+igd;
  window.showModalDialog(url,self,y);
}
function f_delete2(igd){
  if(confirm('您确定要删除此内容吗？')){
    form1.purid.value= igd;
    form1.act.value= 'delete2';
    form1.action = "/servlet/EditReturnedShop";
    form1.submit();
  }
}
</script>
  <h1>加盟店退货单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表(1)</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="purid">
   <input type="hidden" name="act" value="delete">
   <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>退货单号</td>
      <td nowrap>退货日期</td>
      <td nowrap>退货数量</td>
      <td nowrap>退货金额</td>
      <td nowrap>订单状态</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = ReturnedShop.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
       while(e.hasMoreElements())
       {
         String paid = ((String)e.nextElement());
         ReturnedShop pobj = ReturnedShop.find(paid);

    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td align="center"><a href="#" onclick="f_c('<%=paid%>');"><%=paid%></a></td>
      <td align="center"><%=pobj.getTime_sToString()%></td>
      <td align="center"><%=pobj.getQuantity() %></td>
      <td align="center"><%=pobj.getTotal_2()%></td>
      <td align="center"><%

      if(pobj.getType()==0){
        out.print("等待总部审核");
      }else if(pobj.getType() ==1)
      {
        out.print("同意退货");
      }else if(pobj.getType() ==2)
      {
        out.print("不同意退货");
      }else if(pobj.getType() ==4)
      {
        out.print("总部已经收到货物");
      }
      %></td>

      <td align="center">
      <%
      if(pobj.getType()==0)
      {
        out.print("<input  type=button value=编辑 onclick=f_edit('"+paid+"'); >&nbsp;<input type=button value=删除  onclick=f_delete('"+paid+"'); >");
      }else if(pobj.getType() ==1||pobj.getType() ==2||pobj.getType() ==4)
      {
        out.print("<input  type=button value=编辑 disabled=\"disabled\"  style=\"background:#666666\" >&nbsp;");
        out.print("<input  type=button value=编辑 disabled=\"disabled\"  style=\"background:#666666\" >");
      }
      %>

       </td>
    </tr>
    <% }%>
  </table>
  <br />
<input type="button" value="添加退货单" onclick="window.open('/jsp/erp/EditReturnedShop.jsp?nexturl=<%=nexturl%>','_self');"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
