<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.Calendar" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

StringBuffer sb=new StringBuffer ();
sb.append("?community=").append(teasession._strCommunity);
sb.append("&id=").append(request.getParameter("id"));

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<script type="">
function f_edit(t,id,a)
{
  if(a=="del")
  {
    if(!confirm('确认删除吗?'))return;
    form1.method="post";
  }
  form1.act.value=a;
  form1.leagueshoptype.value=t;
  form1.leagueshopmsg.value=id;
  form1.nexturl.value=location.pathname+location.search;
  form1.action='/jsp/leagueshop/EditLeagueShopMsg.jsp';
  form1.submit();
}
</script>
</head>

<body>
<h1>公告管理</h1>

<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="leagueshoptype" value="0"/>
<input type="hidden" name="leagueshopmsg" value="0"/>
<input type="hidden" name="act" />
<input type="hidden" name="nexturl" />
<%
Enumeration e=LeagueShopType.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  LeagueShopType lst=LeagueShopType.find(id);
  out.print("<h2>"+lst.getLstypename()+"</h2>");
  out.print("<table border='0' CELLPADDING='0' CELLSPACING='0' id='tablecenter'><tr id='tableonetr'><td>&nbsp;<td>主题<td>内容<td>位置<td>时间<td>&nbsp;");
  int sum=LeagueShopMsg.count(" AND leagueshoptype="+id+" AND state IN(0,1)");
  if(sum<1)
  {
    out.print("<tr><td colspan='5' align='center'>暂无记录");
  }else
  {
    int pos=0;
    String tmp=request.getParameter("pos"+id);
    if(tmp!=null)pos=Integer.parseInt(tmp);
    Enumeration em=LeagueShopMsg.find(id," AND state IN(0,1) ORDER BY leagueshopmsg DESC",0,10);
    for(int i=pos+1;em.hasMoreElements();i++)
    {
      LeagueShopMsg lsm=(LeagueShopMsg)em.nextElement();
      int mid=lsm.getLeagueshopMsg();
      out.print("<tr><td>"+i+"<td>"+lsm.getSubject()+"<td>"+lsm.getContent()+"<td>"+LeagueShopMsg.STATE_TYPE[lsm.getState()]+"<td>"+lsm.getTimeToString()+"<td><input type='button' value='编辑' onclick='f_edit("+id+","+mid+")'><input type='button' value='删除' onclick=f_edit("+id+","+mid+",'del')>");
    }
    if(sum>10)out.print("<tr><td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,sb.toString()+"&pos"+id+"=",pos,sum,10));
  }
  out.print("</table><input type='button' value='添加公告' onclick='f_edit("+id+",0)'>");
}
%>
</form>
</body>
</html>
