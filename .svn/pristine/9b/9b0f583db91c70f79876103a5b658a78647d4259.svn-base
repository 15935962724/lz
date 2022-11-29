<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?community="+h.community);

sql.append(" AND node="+h.node);
par.append("&node="+h.node);


int pos=h.getInt("pos");
int sum=BBSActivity.count(sql.toString());
par.append("&pos=");


%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<iframe name="_rs" style="display:none"></iframe>

<form name="form2" action="/servlet/EditBBS" method="post" target="_rs">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act" value="activity"/>
<input type="hidden" name="op"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>申请者</td>
  <td>联系方式</td>
  <td>留言</td>
  <td>每人花销</td>
  <td>申请时间</td>
  <td>状态</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=BBSActivity.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    BBSActivity t=(BBSActivity)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="bbsactivity" value="<%=t.bbsactivity%>"/></td>
    <td><%=MT.f(t.member)%></td>
    <td><input value="<%=MT.f(t.contact)%>" size="10" readonly="readonly"/></td>
    <td><input value="<%=MT.f(t.remark)%>" size="10" readonly="readonly"/></td>
    <td><%=t.payment==0?"自费":t.cost+"元"%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%=t.STATE_TYPE[t.state]%></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="checkbox" onclick="mt.select(form2.bbsactivity,checked)" id="sel"/><label for="sel">全选</label>
<input type="button" value="删除" name="multi" onclick="f_act('del')"/>
<input type="button" value="批准" name="multi" onclick="f_act('state')"/>
<input type="button" value="导出" onclick="f_act('exp')"/>
</form>

<script>
mt.disabled(form2.bbsactivity);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.op.value=a;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
    return;
  }
  if(a=='exp')form2.act.value='activity'+a;
  form2.submit();
}
</script>
</body>
</html>
