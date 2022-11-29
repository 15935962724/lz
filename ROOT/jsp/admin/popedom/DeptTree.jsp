<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
/* if(h.isIllegal())
{
  out.println("非法操作！");
  return;
} */

//AdminUnit obj=AdminUnit.getRoot(h.community);
int menuid=h.getInt("id");

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String depts=h.get("depts");

if(sql.length()>0)
{
  Iterator it=AdminUnit.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
  sql.setLength(0);
  sql.append(" AND dept IN(");
  while(it.hasNext())
  {
    AdminUnit d=(AdminUnit)it.next();
    sql.append(d.path.substring(1).replace('/',','));
  }
  sql.append("0)");
}

%><html><head>
<base target="dept_user"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
.tree{margin-left:15px;}
img{border:0}
</style>
</head>
<body>
<h1>部门列表</h1>

<form name="form1" action="?" target="_self">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="depts" value="<%=depts%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td><input name="name" value="<%=name%>"/> <input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
<%
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
if("webmaster".equals(h.username))aur.classes="/"+AdminUnit.getRootId(h.community)+"/";
String[] arr=aur.classes.split("/");
for(int i=1;i<arr.length;i++)
{
  AdminUnit d=AdminUnit.find(Integer.parseInt(arr[i]));
  out.print("<tr><td id='Departmentlist'><div id="+d.id+"><a href='###' onclick=mt.act(this,'user')>"+d.name+"</a></div><div class='tree'>"+d.toTree(0,sql.toString(),depts)+"</div>");
}
%>
<div id='0'><img src='/tea/image/tree/minus.gif' onclick='mt.tree(this)' align=absmiddle>&nbsp;<a href='###' onclick=mt.act(this,'user')>无部门</a></div>
</table>

<script>
//highlighter
mt.red=function(tag,q)
{
  if(q=='')return;
  var arr=document.getElementsByTagName(tag);
  for(var i=0;i<arr.length;i++)
  {
    arr[i].innerHTML=arr[i].innerHTML.replace(q,'<font color=red>'+q+'</font>');
  }
};

mt.tree=function(img)
{
  var p=img.parentNode,d=p.nextSibling,ish=d.style.display=="";
  d.style.display=ish?"none":"";
  img.src="/tea/image/tree/"+(ish?"plus":"minus")+".gif";
  //
  form1.depts.value=form1.depts.value.replace('|'+p.id+'|','|')+(ish?"":p.id+"|");
  //
  if(d.innerHTML!="")return;
  d.innerHTML="load...";
  mt.send("/Depts.do?act=ajax&dept="+p.id+"&key=<%=MT.enc(sql.toString())%>&depts=|",function(h){d.innerHTML=h.substring(h.indexOf('\n')+1)||"无子项";mt.red('A',form1.name.value);});
};
mt.act=function(t,a)
{
  if(a=='user')
  t.href="DeptSeqs.jsp?id="+form1.id.value+"&dept="+mt.fdiv(t).id;
};
mt.red('A',form1.name.value);

if(parent.dept_user.location.href=='about:blank')
document.links[0].click();
//window.open(document.links[0].href,"dept_user");
</script>
</body>
</html>
