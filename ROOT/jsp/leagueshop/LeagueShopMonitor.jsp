<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}


%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>分店销售情况监测</title>
</head>
<body>
<h1>分店销售情况监测</h1>
<h2>查询</h2>
<form action="">
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <tr><td>分店名称:</td><td><input /></td><td>法人:</td><td><input /></td><td>分店类型：</td><td><select><option>---</option><option>唯美度</option><option>奥瑞拉</option></select></td></tr>
    <tr><td>加盟商姓名:</td><td><input /></td><td>分店级别:</td>
      <td>
        <select>
          <option value="" selected>请选择级别</option>
          <option value="红宝级连锁店">红宝级连锁店</option>
          <option value="翡翠级连锁店">翡翠级连锁店</option>
          <option value="白金级旗舰店">白金级旗舰店</option>
          <option value="钻石级旗舰店">钻石级旗舰店</option>
          <option value="代理级旗舰店">代理级旗舰店</option>
        </select>
      </td>
      <td colspan="2"><input type="button" value="查询" /></td>
</tr>
</table>
</form>
<h2>分店数量（3）</h2>
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr  id="tableonetr" ><td nowrap>分店名称</td><td nowrap>法人</td><td nowrap>营业电话</td><td nowrap>加盟商姓名</td><td nowrap>加盟级别</td><td>账户余额</td><td></td></tr>
<tr><td nowrap><a href="/jsp/leagueshop/EditLeagueShop2.jsp">唯美世界</a></td><td nowrap>李小双</td><td nowrap>010-84765588</td><td nowrap>李逍遥</td><td nowrap>唯美度：翡翠级连锁店</td><td>12万</td><td><input type="button" value="查询信息" onclick="window.open('/jsp/leagueshop/LeagueShopMonitor2.jsp?statics=bianji','_self')" /></td></tr>
<tr><td nowrap><a href="/jsp/leagueshop/EditLeagueShop2.jsp">红宝石真情</a></td><td nowrap>郑敏</td><td nowrap>010-84765588</td><td nowrap>郑敏</td><td nowrap>奥瑞拉：碧海云天旗舰店</td><td>50万</td><td><input type="button" value="查询信息" onclick="window.open('/jsp/leagueshop/LeagueShopMonitor2.jsp?statics=bianji','_self')" /></td></tr>
<tr><td nowrap><a href="/jsp/leagueshop/EditLeagueShop2.jsp">碧海浪涛</a></td><td nowrap>李嘉利</td><td nowrap>010-84765588</td><td nowrap>李嘉利</td><td nowrap>奥瑞拉：玫瑰有约形象店</td><td>12万</td><td><input type="button" value="查询信息" onclick="window.open('/jsp/leagueshop/LeagueShopMonitor2.jsp?statics=bianji','_self')" /></td></tr>

</table>

</body>
</html>

