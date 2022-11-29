<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
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
String tmp=request.getParameter("pos");
int pos=tmp==null?0:Integer.parseInt(tmp);

String menuid=request.getParameter("id");
String name = request.getParameter("name");
String time = request.getParameter("time");
StringBuilder sql=new StringBuilder();
StringBuilder par=new StringBuilder();
par.append("?community=").append(teasession._strCommunity).append("&id=").append(menuid);
if(name!=null&&name.length()>0)
{
  sql.append(" AND leagueshop IN(SELECT leagueshop FROM LeagueShop WHERE lsname LIKE "+DbAdapter.cite("%"+name+"%")+")");
  par.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
if(time!=null&&time.length()>0)
{
  sql.append(" AND time<"+DbAdapter.cite(time));
  par.append("&time=").append(time);
}
int sum=ShopICard.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY shopicard DESC");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>加盟店领卡</title>
<script>
function f_act(id)
{
  if(confirm('确认删除?'))
  {
    window.open("/servlet/EditShopICard?act=del&shopicard="+id+"&community=<%=teasession._strCommunity%>&nexturl="+encodeURIComponent(location.href),"_self");
  }
}
</script>
</head>
<body id="bodynone">
<h1>加盟店领卡</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>加盟店名称:<input name="name" type="text" value="<%if(name!=null)out.print(name);%>"></td>
    <td>领取日期小于:<input type="text" name="time" size="12" value="<%if(time!=null)out.print(time);%>"><img src="/tea/image/public/Calendar2.gif" align="top"/></td>
      <td><input type="submit" value="查询"></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="?" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="/jsp/erp/icard/ICardTypes.jsp"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>加盟店</td>
      <td nowrap>起始卡号</td>
      <td nowrap>结束卡号</td>
      <td nowrap>领取日期</td>
      <td nowrap>操作</td>
    </tr>
<%
Enumeration e=ShopICard.find(teasession._strCommunity,sql.toString(),pos,10);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan='5' align='center'>暂无记录");
}else
{
  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    ShopICard sic=ShopICard.find(id);
    String lsname=LeagueShop.find(sic.getLeagueshop()).getLsname();
    if(name!=null&&name.length()>0)lsname=lsname.replaceAll(name,"<font color='red'>"+name+"</font>");
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td>"+lsname);
    out.print("<td>"+sic.getStartCode());
    out.print("<td>"+sic.getEndCode());
    out.print("<td>"+sic.getTimeToString());
    out.print("<td><input type='button' value='删除' onclick='f_act("+id+")'/>");
  }
  if(sum>10)out.print("<tr><td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,10));
}
%>
</table>
<input type="button" value="加盟店领卡" onClick="window.open('/jsp/erp/icard/EditShopICard.jsp?shopicard=0','_self');">
</form>

<h2>未被领取卡的状态</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>卡类型</td>
      <td nowrap>起始卡号</td>
      <td nowrap>结束卡号</td>
      <td nowrap>剩余张数</td>
    </tr>
    <%
    e=ICardType.find(teasession._strCommunity,"",0,200);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      ICardType ict=ICardType.find(id);
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td>"+ict.getName());
      int j=ICard.count(id," AND shopicard=0");
      if(j>0)
      {
        out.print("<td>"+ICard.find(id," AND shopicard=0 ORDER BY icard ASC",0,1).nextElement());
        out.print("<td>"+ICard.find(id," AND shopicard=0 ORDER BY icard DESC",0,1).nextElement());
        out.print("<td>"+j);
      }else
      {
        out.print("<td>--<td>--<td>--");
      }
    }
    %>
  </table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
