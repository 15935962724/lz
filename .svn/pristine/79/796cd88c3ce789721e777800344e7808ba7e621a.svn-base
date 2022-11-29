<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String menuid=request.getParameter("id");
String nexturl = request.getRequestURI()+"?"+request.getContextPath();
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

int brand=0;
tmp=request.getParameter("brand");
if(tmp!=null)brand=Integer.parseInt(tmp);


StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);

String no=request.getParameter("no");
String name=request.getParameter("name");
if(no!=null&&no.length()>0)
{
  sql.append(" AND no LIKE ").append(DbAdapter.cite("%"+no+"%"));
  par.append("&no=").append(java.net.URLEncoder.encode(no,"UTF-8"));
}
if(name!=null&&name.length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  par.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
if(brand>0)
{
  sql.append(" AND brand=").append(brand);
  par.append("&brand=").append(brand);
}
par.append("&pos=");

int sum=ShopService.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>服务管理</title>
<script>
function f_edit(id)
{
  window.open('/jsp/erp/EditShopService.jsp?shopservice='+id,'_self');
}
function f_del(id)
{
  if(confirm('确认删除?'))
  {
    window.open('/servlet/EditShopService?act=del&shopservice='+id+'&nexturl='+encodeURIComponent(location.href),'_self');
  }
}
</script>
</head>
<body id="bodynone">
<h1>服务管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>编号:<input type="text" name="no" value="<%if(no!=null)out.print(no);%>"/></td>
  <td>名称:<input type="text" name="name" value="<%if(name!=null)out.print(name);%>"/></td>
  <td>品牌:<select name="brand"><option value="0">---------------</option>
    <%
    Enumeration eb=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    while(eb.hasMoreElements())
    {
      int id=((Integer)eb.nextElement()).intValue();
      out.print("<option value="+id);
      if(id==brand)out.print(" selected='true'");
      out.print(">"+Brand.find(id).getName(teasession._nLanguage));
    }
    %>
    </select>
    <td><input type="submit" value="GO"/></td></tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form action="?" name="form1" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="/jsp/erp/icard/ICardTypes.jsp"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>编号</td>
      <td nowrap>名称</td>
      <td nowrap>价格</td>
      <td nowrap>提成类型</td>
      <td nowrap>提成量</td>
      <td nowrap>品牌</td>
      <td nowrap>操作</td>
    </tr>
<%
Enumeration e=ShopService.find(teasession._strCommunity,sql.toString(),pos,15);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  ShopService ss=ShopService.find(id);
  int bid=ss.getBrand();
  Brand b=Brand.find(bid);
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+ss.getNo());
  out.print("<td>"+ss.getName());
  out.print("<td>"+ss.getPrice());
  out.print("<td>"+(ss.isDType()?"0":"%"));
  out.print("<td>"+ss.getDeduct());
  out.print("<td>");
  if(b.isExists())out.print(b.getName(teasession._nLanguage));
  out.print("<td><input type='button' value='编辑' onclick='f_edit("+id+")'>");
  //if(!ICard.find(teasession._strCommunity," AND icardtype=" + id,0,1).hasMoreElements())
  {
    out.print("<input type='button' value='删除' onclick='f_del("+id+")'>");
  }
}
if(sum>15)out.print("<tr><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,15));
%>
</table>
<input type="button" value="添加服务项目" onClick="f_edit(0);">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
