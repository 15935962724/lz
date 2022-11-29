<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);
h.node=65;
//sql.append(" AND father="+h.node);

int specimen=h.getInt("specimen");
if(specimen>0)
{
  sql.append(" AND specimen="+specimen);
  par.append("&specimen="+specimen);
}

String keyword=h.get("keyword","");
if(keyword.length()>0)
{
  sql.append(" AND keyword LIKE "+DbAdapter.cite("%"+keyword+"%"));
  par.append("&keyword="+h.enc(keyword));
}

String copyrightowner=h.get("copyrightowner","");
if(copyrightowner.length()>0)
{
  sql.append(" AND copyrightowner LIKE "+DbAdapter.cite("%"+copyrightowner+"%"));
  par.append("&copyrightowner="+h.enc(copyrightowner));
}


int pos=h.getInt("pos");
par.append("&pos=");
int sum=SPicture.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>图片管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="specimen" value="<%=specimen%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">主题词：</td><td><input name="keyword" value="<%=keyword%>"/></td>
  <td class="th">版权人：</td><td><input name="copyrightowner" value="<%=copyrightowner%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/SPictures.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="picture"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="node"/>
<input type="hidden" name="specimen" value="<%=specimen%>"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>标本</td>
  <td>保护区</td>
  <td>文件名</td>
  <td>多媒体类型</td>
  <td>主题词</td>
  <td>版权人</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=SPicture.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    SPicture t=(SPicture)it.next();
    Node n=Node.find(t.specimen);
    Specimen s=Specimen.find(t.specimen);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=Node.find(s.reserve).getAnchor(h.language)%></td>
    <td><%=MT.f(t.mulname)%></td>
    <td><%=MT.f(t.multype)%></td>
    <td><%=MT.f(t.keyword)%></td>
    <td><%=MT.f(t.copyrightowner)%></td>
    <td><a href=javascript:mt.act('edit',<%=t.node%>)>编辑</a> <a href=javascript:mt.act('del',<%=t.node%>)>删除</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/type/spicture/EditSPicture.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
