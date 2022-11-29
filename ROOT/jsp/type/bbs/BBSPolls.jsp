<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

sql.append(" AND type=57 AND community="+DbAdapter.cite(h.community)+" AND EXISTS(SELECT node FROM BBS b WHERE n.node=b.node AND b.special=1)");


int pos=h.getInt("pos");
int sum=Node.count(sql.toString());

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>投票贴子</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2>列表 <%=sum%></h2>
<form name="form2" action="/FriendLists.do">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="node"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
<td>主题</td>
<td>发起者</td>
<td>参与人数</td>
<td>时间</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=0;e.hasMoreElements();i++)
  {
    int nid=((Integer)e.nextElement()).intValue();
    Node n=Node.find(nid);
    BBS b=BBS.find(nid,h.language);
  %>
    <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
      <td><%=n.getAnchor(h.language)%></td>
      <td><%=n.getCreator()%></td>
      <td><%=b.vote%></td>
      <td><%=MT.f(n.getTime(),1)%></td>
      <td><input type="button" value="查看" onclick="f_act(<%=nid%>)"/></td>
    </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>

</form>


<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(n)
{
  form2.node.value=n;
  form2.action='/jsp/type/bbs/BBSPollView.jsp';
  form2.submit();
}
</script>
</body>
</html>
