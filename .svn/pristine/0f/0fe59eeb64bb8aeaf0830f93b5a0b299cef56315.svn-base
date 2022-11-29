<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.util.*"%><%@page import="tea.resource.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Http h=new Http(request,response);

Resource r=new Resource();

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND community="+DbAdapter.cite(h.community));

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int type=h.getInt("type",-1);
if(type!=-1)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String sorttype=h.get("sorttype","");
if(sorttype.length()>0)
{
  sql.append(" AND sorttype LIKE "+DbAdapter.cite("%"+sorttype+"%"));
  par.append("&sorttype="+h.enc(sorttype));
}

String node_not=h.get("node_not","");
if(node_not.length()>0)
{
  sql.append(" AND node_not LIKE "+DbAdapter.cite("%"+node_not+"%"));
  par.append("&node_not="+h.enc(node_not));
}

int hours=h.getInt("hours");
if(hours>0)
{
  sql.append(" AND hours LIKE "+DbAdapter.cite("%"+hours+"%"));
  par.append("&hours="+hours);
}

int sum=LuceneList.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>搜索管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td>类型:<%=new tea.htmlx.TypeSelection(h.community,h.language,type,false)%></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Lucenes.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lucenelist"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>类型</td>
  <td>排除节点</td>
  <td>创建时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LuceneList.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LuceneList t=(LuceneList)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=t.getType(h.language)%></td>
    <td><%=t.getNodeNot(h.language)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td>
      <a href="javascript:mt.act('ledit',<%=t.lucenelist%>)">编辑</a>
      <a href="javascript:mt.act('ldel',<%=t.lucenelist%>)">删除</a>
      <a href="javascript:mt.act('attr',<%=t.lucenelist%>)">搜索源</a>
      <a href="javascript:mt.act('test',<%=t.lucenelist%>)">测试</a>
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('ledit','0')"/>
</form>

<script>
var t=new Option("--","-1");
t.innerHTML="--";
var op=form1.type.options;
if(mt.isIE)
  op.insertBefore(t,op[0]);
else
  op.add(t,0);
form1.type.value="<%=type%>";

form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.lucenelist.value=id;
  if(a=='ldel')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='ledit')
    {
      form2.action='/jsp/util/LuceneListEdit.jsp';
    }else if(a=='attr')
    {
      form2.action='/jsp/util/Lucenes.jsp';
    }else if(a=='test')
    {
      form2.action='/jsp/util/Search.jsp?community=<%=h.community%>&lucenelist='+id;
    }
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
