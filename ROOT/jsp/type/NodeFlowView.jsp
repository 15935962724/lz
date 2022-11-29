<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

int node=h.getInt("node");
sql.append(" AND node="+node);

int sum=NodeFlow.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<form name="form2" action="/NodeFlowEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="subflow"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>操作人</td>
  <td>状态</td>
  <td>时间</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=NodeFlow.find(sql.append(" ORDER BY flow").toString(),0,200).iterator();
  for(int i=1;it.hasNext();i++)
  {
    NodeFlow t=(NodeFlow)it.next();
    if(i>1)out.print("<tr><td colspan='3' align='center'>↓");

  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=Profile.find(t.member).getMember()%></td>
    <td><%
    out.print(NodeFlow.STATE_TYPE[t.state]);
    if(MT.f(t.content).length()>0)out.print(" <span style='color:red'>（"+t.content+"）<span>");
    %></td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>

<input type="button" value="关闭" onclick="parent.mt.close()"/>
</form>

</body>
</html>
