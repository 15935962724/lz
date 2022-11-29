<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="java.math.BigDecimal"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();
StringBuffer sql = new StringBuffer(" AND type!=7");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time_s >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time_s <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
String purchase = teasession.getParameter("purchase");
if(purchase!=null && purchase.length()>0)
{
  sql.append(" AND purchase LIKE '%"+purchase+"%' ");
  param.append("&purchase=").append(purchase);
}

String lsname = teasession.getParameter("lsname");
if(lsname!=null && lsname.length()>0)
{
  sql.append(" AND supplname IN (SELECT  id FROM LeagueShop WHERE lsname LIKE "+DbAdapter.cite("%"+lsname+"%")+") ");
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}

int waridname = 0;
if(teasession.getParameter("waridname")!=null && teasession.getParameter("waridname").length()>0)
{
  waridname = Integer.parseInt(teasession.getParameter("waridname"));
  if(waridname>0)
  {
    sql.append(" AND waridname =").append(waridname);
    param.append("&waridname=").append(waridname);
  }
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Paidinfull.count(teasession._strCommunity,sql.toString());
String o=request.getParameter("o");
if(o==null)
{
  o="time_s";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
param.append("&o=").append(o).append("&aq=").append(aq);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>销售单管理</title>
</head>
<body id="bodynone">
<script>
function f_show(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:457px;dialogHeight:215px;';
  var url = '/jsp/erp/PurchaseShow.jsp?warid='+igd+'&act=cangku'
  window.showModalDialog(url,self,y);
}
function f_edit(igd)
{
  form1.purid.value= igd;
  form1.action = "/jsp/erp/EditPaidinfull.jsp";
  form1.submit();
}
function f_delete(igd)
{
  if(confirm('您确定要删除此内容吗？'))
  {
    form1.purid.value= igd;

    form1.act.value= 'delete';
    form1.action = "/servlet/EditPaidinfull";
    form1.submit();
  }
}
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/PaidinfullShow.jsp?paid='+igd;
  window.showModalDialog(url,self,y);
}
function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
</script>
<h1>销售单管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form action="?" name="form1" method="POST">

  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="purid" >
  <input type="hidden" name="act" >
  <input type="hidden" name="o" VALUE="<%=o%>">
  <input type="hidden" name="aq" VALUE="<%=aq%>">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>销售日期:</td>
      <td>

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
      </td>

      <td>销售单号:</td>
      <td><input type="text" name="purchase" value="<%if(purchase!=null)out.print(purchase);%>"/></td>
      </tr>
      <tr>
        <td>加盟店名称:</td>
        <td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
        <td>销售仓库:</td>
        <td><select name="waridname">
          <option value="0">请选择仓库</option>
          <%
          java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while (e2.hasMoreElements())
          {
            int warid = ((Integer)e2.nextElement()).intValue();
            Warehouse warobj = Warehouse.find(warid);
            out.print("<option value= "+warid);
            if(waridname==warid)
            {
              out.print(" selected");
            }
            out.print(">"+warobj.getWarname());
            out.print("</option>");
          }

          %>
          </select> </td>

          <td><input type="submit" value="查询"/></td>
    </tr>
  </table>
  <h2>列表(<%=count%>)</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap><a href="javascript:f_order('purchase');">销售单号</a>
      <%
      if(o.equals("purchase"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap><a href="javascript:f_order('time_s');">销售日期</a>
      <%
      if(o.equals("time_s"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap><a href="javascript:f_order('supplname');">加盟店名称</a>
      <%
      if(o.equals("supplname"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap><a href="javascript:f_order('waridname');">销售仓库</a>
      <%
      if(o.equals("waridname"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap><a href="javascript:f_order('quantity');">销售数量</a>
      <%
      if(o.equals("quantity"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap><a href="javascript:f_order('total_2');">销售金额</a>
      <%
      if(o.equals("total_2"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap>订单状态</td>
      <td nowrap>操作</td>
    </tr>
    <%
    java.util.Enumeration e = Paidinfull.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements()){
      String paid = ((String)e.nextElement());
      Paidinfull pobj = Paidinfull.find(paid);
      tea.entity.member.Profile p = tea.entity.member.Profile.find(pobj.getMember());
      LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><a href="#" onclick="f_c('<%=paid%>');"><%=paid%></a></td>
        <td align="center"><%=pobj.getTime_sToString()%></td>
        <td><%if(lsobj.getLsname()!=null){out.print(lsobj.getLsname());}%></td>
        <td ><a href="#" onclick="f_show('<%=pobj.getWaridname()%>');"><%=Warehouse.find(pobj.getWaridname()).getWarname() %></a></td>
        <td ><%=pobj.getQuantity() %></td>
        <td><%if(pobj.getTotal_2()!=null&&pobj.getTotal_2().length()>0){out.print(new BigDecimal(pobj.getTotal_2()).setScale(2,2));}%></td>
        <td ><% 
 
        if(pobj.getType()==0){
          out.print("处理中");
        }else if(pobj.getType()==1)
        {
          out.print("等待总部确认订单");
        }
        else if(pobj.getType()==2 || pobj.getType()==3)
        {
          out.print("已下单,正在备货");
        }else if(pobj.getType()==-1)
        {
          out.print("没有下单，编辑生成订单");
        }else if (pobj.getType() == 4)
        {
          out.print("备货完成，正在发货");
        }else if (pobj.getType() == 5)
        {
          out.print("发货完成，请等待收货");
        }else if(pobj.getType() == 6)
        {
          out.print("货物已经，订单完成");
        }else if(pobj.getType() == 8)
        {
          out.print("<font color=red>此订单为保存订单，还没有下单</font>");
        }


        %></td>
        <td> 

          <%
          if(pobj.getType()==0)
          {
            out.print("  <a href=\"#\" onclick=\"f_edit('"+paid+"');\">编辑</a>&nbsp;");
            out.print("<a href=\"#\" onclick=window.open('/jsp/erp/AuditShopstock.jsp?nexturl="+nexturl+"&paid="+paid+"','_self');>审核订单</a> &nbsp;");
            out.print("<a href=\"#\" onclick=\"f_delete('"+paid+"');\">删除</a>&nbsp;");
          }else if(pobj.getType()==8)
          {
            out.print("  <a href=\"#\" onclick=\"f_edit('"+paid+"');\">编辑</a>&nbsp;");
            out.print(" <input type=button disabled=disabled style=background:#666666 value=审核订单>&nbsp;");
            out.print("<a href=\"#\" onclick=\"f_delete('"+paid+"');\">删除</a>&nbsp;");
          }else
          {
            out.print("  <input type=button disabled=disabled style=background:#666666 value=编辑>&nbsp;");
            out.print(" <input type=button disabled=disabled style=background:#666666 value=审核订单>&nbsp;");
            out.print("<input type=button disabled=disabled style=background:#666666 value=删除>");
          }
          %>

        </td>
      </tr>
      <%}%>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
  <br />
  <input type="button" value="添加销售单" onclick="window.open('/jsp/erp/EditPaidinfull.jsp?nexturl=<%=nexturl%>','_self');"/>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>





