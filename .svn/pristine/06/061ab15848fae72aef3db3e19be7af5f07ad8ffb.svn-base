<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.semi.*" %>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();
StringBuffer param = new StringBuffer();

StringBuffer sql = new StringBuffer(" ");
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

String goods = teasession.getParameter("goods");

int supplname = 0;
if(teasession.getParameter("supplname")!=null && teasession.getParameter("supplname").length()>0)
{
  supplname = Integer.parseInt(teasession.getParameter("supplname"));
}
if(supplname>0)
{
  sql.append(" AND supplname =").append(supplname);
  param.append("&supplname=").append(supplname);
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = SemiPurchase.count(teasession._strCommunity,sql.toString());
String o=request.getParameter("o");
if(o==null)
{
  o="purchase";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>

<body>
<script type="">
function f_edit(igd)
{
  form1.purid.value=igd;
  form1.action="/jsp/erp/semi/EditSemipurchase.jsp"
  form1.submit();
}
function f_delete(igd)
{
  if(confirm('确实要删除吗？')){
    form1.purid.value=igd;
    form1.act.value='delete';
    form1.action="/jsp/erp/semi/EditSemipurchase.jsp"
    form1.submit();
  }
}
function f_submit()
{
  return ((form1.time_c.value==''||submitDate(form1.time_c,'您输入的时间格式不正确，时间格式是：2009-01-01')) &&
  (form1.time_d.value==''||submitDate(form1.time_d,'您输入的时间格式不正确，时间格式是：2009-01-01')));
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
<h1>显示可以拆卸的商品列表</h1>
<form name="form1" action="?" onsubmit="return f_submit();">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="purid"/>

<input type="hidden" name="act"/>
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>入库日期:&nbsp;
      从&nbsp;   <input name="time_c" size="7"  value="<%if(time_c!=null){out.print(time_c);}%>">
      <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_c);" alt="" />
        &nbsp;到&nbsp;<input name="time_d" size="7"  value="<%if(time_d!=null){out.print(time_d);}%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_d);" alt="" />
        &nbsp;
    </td>

    <td>商品名称: &nbsp;<input type="text" name="goods" value="<%if(goods!=null)out.print(goods);%>"></td>

      <td><input type="submit" value="查询"/></td>
  </tr>
</table>
<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>商品合成规则编号</td>
    <td nowrap>合成商品的名称</td>
    <td nowrap>需要的半成品</td>
    <td nowrap>操作</td>
  </tr>
  <%
  java.util.Enumeration e = SemiPurchase.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂没有入库记录</td></tr>");
  }
  for(int i=0;e.hasMoreElements();i++)
  {
    String purchase  = String.valueOf(e.nextElement());
    SemiPurchase spobj = SemiPurchase.find(purchase);

    String goodsnum="",goodsname="",semigoodsname="";
    String spstr[] = spobj.getGoods().split("/");
    if(spstr.length>1)
    {
      goodsnum=spstr[1];
      Node nodeobj = Node.find(Integer.parseInt(goodsnum));
      goodsname = nodeobj.getSubject(teasession._nLanguage);
    }
    StringBuffer strss = new StringBuffer("");
    String semistr[] = spobj.getSemigoods().split("/");
    if(semistr.length>1)
    {
      for(int j=0;j<semistr.length;j++)
      {
        if(semistr[j]!=null && semistr[j].length()>0)
        {
          SemiGoods sgobj2 =  SemiGoods.find(Integer.parseInt(semistr[j]));
          strss.append(sgobj2.getSubject()).append("/");
        }
        semigoodsname=strss.toString();
      }
    }
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td nowrap><%=spobj.getPurchase()%></td>
      <td nowrap><%=goodsname%></td>
      <td nowrap><%=semigoodsname%></td>
      <td nowrap><input type=button  value=拆卸 onclick="window.open('/jsp/erp/semi/EditSemiCatecargocai.jsp?puridsg=<%=purchase%>','_self')"></td>

    </tr>
    <%
  }
  %>
    <%if(count > pageSize){%>
    <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%></td> </tr>
    <%}%>
</table>
</form>
</body>
</html>
