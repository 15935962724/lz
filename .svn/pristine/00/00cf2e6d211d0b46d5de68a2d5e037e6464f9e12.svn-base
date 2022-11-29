<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String fusername=h.get("fusername","");
if(fusername.length()>0)
{
  sql.append(" AND fusername LIKE "+DbAdapter.cite("%"+fusername+"%"));
  par.append("&fusername="+h.enc(fusername));
}

String tusername=h.get("tusername","");
if(tusername.length()>0)
{
  sql.append(" AND tusername LIKE "+DbAdapter.cite("%"+tusername+"%"));
  par.append("&tusername="+h.enc(tusername));
}

String  content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=MMessenger.count(sql.toString());


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>微信消息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>类型:<select name="type"><%=h.options(MMessenger.MMESSENGER_TYPE,type)%></select></td>
  <td>发送方:<input name="fusername" value="<%=fusername%>"/></td>
  <td>接收方:<input name="tusername" value="<%=tusername%>"/></td>
  <td>内容:<input name="content" value="<%=content%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/MMessengerEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="mmessenger"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>类型</td>
  <td>发送方</td>
  <td>接收方</td>
  <td>内容</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY mmessenger DESC");
  Iterator it=MMessenger.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    MMessenger t=(MMessenger)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MMessenger.MMESSENGER_TYPE[t.type]%></td>
    <td><%=MT.f(t.fusername)%></td>
    <td><%=MT.f(t.tusername)%></td>
    <td><%=MT.f(t.content)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><a href="javascript:mt.act('view',<%=t.mmessenger%>)">查看</a>
      <!--<input type="button" value="编辑" onclick="f_act('edit',<%%>)"/>
        <input type="button" value="删除" onclick="f_act('del',<%%>)"/>-->
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.mmessenger.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='view')
  {
    form2.action='/jsp/weibo/MMessengerView.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
