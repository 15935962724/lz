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
par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND father="+h.node);

sql.append(" AND node IN(SELECT node FROM animal WHERE 1=1");
int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String latin=h.get("latin","");
if(latin.length()>0)
{
  sql.append(" AND latin LIKE "+DbAdapter.cite("%"+latin+"%"));
  par.append("&latin="+h.enc(latin));
}
sql.append(")");

int pos=h.getInt("pos");
par.append("&pos=");
int sum=Node.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>动物管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">种类：</td><td><select name="type"><%=h.options(Animal.ANIMAL_TYPE,type)%></select></td>
  <td class="th">物种代码：</td><td><input name="code" value="<%=code%>"/></td>
  <td class="th">物种名称：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">拉丁名字：</td><td><input name="latin" value="<%=latin%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Animals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="animalid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="Type"/>
<input type="hidden" name="EditNode"/>
<input type="hidden" name="NewNode"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>种类</td>
  <td>物种代码</td>
  <td>物种名称</td>
  <td>拉丁名字</td>
  <td>濒危因素</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY node");
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    Animal t=Animal.find(node);
%>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=Animal.ANIMAL_TYPE[t.type]%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(t.latin)%></td>
    <td><%=MT.f(t.endanger)%></td>
    <td><a href=javascript:mt.act('edit',<%=t.node%>)>编辑</a> <a href=javascript:mt.act('del',<%=t.node%>)>删除</a> <a href=javascript:mt.act('fileup',<%=t.node%>)>上传组图</a> <a href=javascript:mt.act('editfile',<%=t.node%>,<%=t.getAlbum() %>)>修改组图</a></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
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
    form2.action='/jsp/type/animal/EditAnimal.jsp';
    form2.target=form2.method='';
    form2.submit();
  }else if(a=='fileup')
  {
	    form2.action="/jsp/type/album/EditAlbum.jsp";
	    form2.animalid.value=id;
	    form2.node.value=14030131;
	    form2.Type.value=95;
	    form2.NewNode.value='ON';
	    form2.target=form2.method='';
	    form2.submit();
	  }else if(a=='editfile')
	  {
		    form2.action="/jsp/type/album/EditAlbum.jsp";
		    form2.animalid.value=id;
		    form2.node.value=b;
		    form2.Type.value=95;
		    form2.EditNode.value='ON';
		    form2.target=form2.method='';
		    form2.submit();
		  }
};
</script>
</body>
</html>
