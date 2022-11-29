<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
Node n=Node.find(h.node);

BBS b=BBS.find(h.node,h.language);

Calendar cal = Calendar.getInstance();
cal.setTime(n.getUpdatetime());
cal.add(cal.DAY_OF_YEAR,b.expiration);


int sum = 0;
ArrayList al = BBSPoll.find(" AND node=" +h.node,0,200);
Iterator it = al.iterator();
for(int i = 1;it.hasNext();i++)
{
  BBSPoll bp = (BBSPoll) it.next();
  sum += bp.hits;
}

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看投票贴子</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form2" action="/FriendLists.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="remark"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>主题</td>
  <td><%=n.getAnchor(h.language)%></td>
</tr>
<tr>
  <td>参与人数</td>
  <td><%=b.vote%>人</td>
</tr>
<tr>
  <td>投票类型</td>
  <td><%=b.multiple?"多选":"单选"%></td>
</tr>
<tr>
  <td>到期日期</td>
  <td><%=b.expiration<1?"无限制":MT.f(cal.getTime(),1)%></td>
</tr>
</table>

<table id="tablecenter" cellspacing="0">
<%
it = al.iterator();
for(int i = 1;it.hasNext();i++)
{
  BBSPoll bp = (BBSPoll) it.next();
  out.print("<tr><td>" + i + "." + bp.question );
  int per =sum<1?0: bp.hits * 100 / sum;
  out.print("<tr><td><div style='background:#FAFAFA;width:470px;margin-left:20px;float:left'><div style='background:#F2A61F;width:" + per + "%;'></div></div>" + per + "% (" + bp.hits + ")");
}
%>
</table>
<input type="button" value="参与者" onclick="mt.bpv()">
<input type="button" value="返回" onclick="history.back()">

<script>
mt.bpv=function(){mt.show('/jsp/type/bbs/BBSPollViewInc.jsp?node=<%=h.node%>',1,'参与投票的会员',400,300);};
</script>

</body>
</html>
