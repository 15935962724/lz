<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@ page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer("  and  lsstatic=0");

param.append("?id=").append(request.getParameter("id"));

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
String lsname="";
if(teasession.getParameter("lsname")!=null && teasession.getParameter("lsname").length()>0)
{
  lsname= teasession.getParameter("lsname");
  sql.append("  and  lsname like ").append(DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(lsname);
}
String lsbuyname="";
if(teasession.getParameter("lsbuyname")!=null && teasession.getParameter("lsbuyname").length()>0)
{
  lsbuyname = teasession.getParameter("lsbuyname");
  sql.append(" and lsbuyname=").append(DbAdapter.cite(lsbuyname));
  param.append("&lsbuyname=").append(lsbuyname);
}

String  tel = "";
if(teasession.getParameter("tel")!=null && teasession.getParameter("tel").length()>0)
{
  tel=teasession.getParameter("tel");
  sql.append(" and tel=").append(DbAdapter.cite(tel));
  param.append("&tel=").append(tel);
}

int lstype=0,lsstype=0;
if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
{
  lstype=Integer.parseInt(teasession.getParameter("lstype"));

  if(lstype==0)
  {
  }
  else
  {
    sql.append("  and  lstype=").append(lstype);
    param.append("&lstype=").append(lstype);
  }
}
if(teasession.getParameter("lsstype")!=null && teasession.getParameter("lsstype").length()>0)
{
  lsstype=Integer.parseInt(teasession.getParameter("lsstype"));
  if(lsstype==0)
  {

  }
  else
  {
    sql.append("  and  lsstype=").append(lsstype);
    param.append("&lsstype=").append(lsstype);
  }
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =LeagueShop.count(teasession._strCommunity,sql.toString());
String o=request.getParameter("o");
if(o==null)
{
  o="id";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<script type="">
function f_order(v)
{
  var aq=form3.aq.value=="true";
  if(form3.o.value==v)
  {
    form3.aq.value=!aq;
  }else
  {
    form3.o.value=v;
  }
  form3.action="?";
  form3.submit();
}
var obj;
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  if(v=="0")v="1111111111";
  sendx("/servlet/Ajax?act=leagueshop&value="+v,f_change);
}
function f_change(d)
{
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
  switch(obj.name)
  {
    case "lsstype":
    form3.lsstype.value="<%=lsstype%>";
    break;
  }
}
function f_load()
{
  form3.lstype.onchange();
}
</script>
<title>分店管理员列表</title>
</head>
<body onload="f_load()">
<h1>分店管理员列表</h1>
<form name="form3" action="?" method="POST">

<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<input type="hidden" name="act"  value="" >
<h2>查询</h2>

<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr>
    <td>分店名称:</td><td><input  name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
    <td nowrap>分店类型：<select  name="lstype" onChange="f_ajax(value,'lsstype')"><option  value="0">-------</option>
<%
Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,8);
for(int i=0;eu.hasMoreElements();i++)
{
  int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
  LeagueShopType objty = LeagueShopType.find(idtt);
  out.print("<option value="+idtt);
        if(lstype==idtt)
        {
          out.print(" selected ");
        }
    out.print(">"+objty.getLstypename()+"</option>");
  }
  %>
  </select>　</td>
     <td nowrap>分店级别：<select name="lsstype" ><option value="0" >-------</option><option value="5000">其他</option>
</select>　　</td>
    <td><input type="submit" value="查询" /></td></tr>


</table>
</form>

<form action="/servlet/EditLeagueShopExcel"  name="form2">
<input type="hidden" name="action" value="EditLeagueShopExcel">
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="EditLeagueShopExcel">
<input type="hidden" name="count" value="<%=count%>">
<h2>分店数量（<%=count%>）</h2>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr  id="tableonetr" >
   <td nowrap ><a href="javascript:f_order('id');">分店编号</a>
  <%
  if(o.equals("id"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td>
    <td nowrap ><a href="javascript:f_order('lsname');">分店名称</a>
  <%
  if(o.equals("lsname"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('shopkeepername');">分店店长</a>
  <%
  if(o.equals("shopkeepername"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td>
  <td nowrap><a href="javascript:f_order('lstype');">分店类型</a>
  <%
  if(o.equals("lstype"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('lsstype');">加盟级别</a>
  <%
  if(o.equals("lsstype"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td></td></tr>
  <%
  
  Enumeration euls = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
  if(!euls.hasMoreElements())
  {
    out.print("<tr><td nowrap colspan=3>暂无信息</td></tr>");
  }
  for(int i=0;euls.hasMoreElements();i++)
  {

    int lsid = Integer.parseInt(String.valueOf(euls.nextElement()));
    LeagueShop objlist = LeagueShop.find(lsid);
    LeagueShopServer objser = LeagueShopServer.find(objlist.getLsstype());
    LeagueShopType objtype = LeagueShopType.find(objlist.getLstype());
    %>
    <tr>
      <td nowrap><a href="/jsp/leagueshop/EditLeagueShop.jsp?idss=<%=lsid%>" target="_self"><%=lsid%></a></td>
      <td nowrap><a href="/jsp/leagueshop/EditLeagueShop.jsp?idss=<%=lsid%>" target="_self"><%if(objlist.getLsname()!=null)out.print(objlist.getLsname());%></a></td>
      <td nowrap><a href="/jsp/leagueshop/EditLeagueShop.jsp?idss=<%=lsid%>" target="_self"><%if(objlist.getLsbuyname()!=null)out.print(objlist.getLsbuyname());%></a></td>
      <td nowrap><a href="/jsp/leagueshop/EditLeagueShop.jsp?idss=<%=lsid%>" target="_self"><%if(objtype.getLstypename()!=null)out.print(objtype.getLstypename());%></a></td>
      <td nowrap><a href="/jsp/leagueshop/EditLeagueShop.jsp?idss=<%=lsid%>" target="_self"><%if(objser.getLssname()!=null)out.print(objser.getLssname());%></a></td>
      <td><input name="按钮" type="button" value="编辑" onClick="window.open('/jsp/leagueshop/EditLeagueShop.jsp?idss=<%=lsid%>', '_self')" ></td>
    </tr>
    <%
    }
    %>

      <tr><td colspan="5"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>

    <tr><td nowrap colspan="5" align="center"><input type="button" value="创建分店" onclick="window.open('/jsp/leagueshop/EditLeagueShop.jsp','_self')" /> <input type="submit" value="导出"/></td></tr>
    </table>
    </form>
</body>
</html>

