<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}

String base=" AND community="+DbAdapter.cite(h.community);

StringBuffer sql=new StringBuffer(base),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?id="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String mname=h.get("mname","");
if(mname.length()>0)
{
  sql.append(" AND(1=0");
  ArrayList al=AdminFunction.find(" AND af.community="+DbAdapter.cite(h.community)+" AND afl.name LIKE "+DbAdapter.cite("%"+mname+"%"),0,200);
  for(int i=0;i<al.size();i++)
  {
    AdminFunction m=(AdminFunction)al.get(i);
    sql.append(" OR adminfunction LIKE '%|"+m.id+":%'");
  }
  sql.append(")");
  par.append("&mname="+Http.enc(mname));
}

AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
String rs[]=aur.getRole().split("/");
if(!rs[1].equals("14100022")){//14100022超级管理员,14111318系统管理员
	sql.append(" AND id!=14100022 "); // AND id!=14111318
}

boolean oper=h.getBool("oper");
if(oper)
{
  sql.append(" AND menu0 LIKE '%oper%'");
  par.append("&oper="+oper);
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=AdminRole.count(sql.toString());

%>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
<%
//if(sql.length()>base.length())
out.println(".SEQ{display:none}");
%>
</style>
</head>
<body>
<h1>角色管理</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">类型：</td><td><select name="type"><%=h.options(AdminRole.ROLE_TYPE,type)%></td>
  <td class="th">权限：</td><td><input name="mname" value="<%=mname%>"/><!-- <input type="checkbox" name="oper" value="oper" <%=oper?" checked ":""%> id="oper"/><label for="oper">操作</label>--></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/Roles.do" method="POST" target="_ajax">
<input type="hidden" name="role"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>类型</td>
  <td>描述</td>
  <td class="SEQ">顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY sequence");
  Iterator it=AdminRole.find(sql.toString(),pos,15).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    AdminRole t=(AdminRole)it.next();
  %>
  <tr id="<%=MT.enc(t.id)%>">
    <td><%=i%><input type="checkbox" name="roles" value="" style="display:none"/></td>
    <td><a href="javascript:mt.act('view',<%=t.id%>)"><%=MT.red(t.name,name)%></a></td>
    <td><%=MT.f(AdminRole.ROLE_TYPE,t.type)%></td>
    <td><%=MT.f(t.content,50)%></td>
    <td class="SEQ"><img name="sequence" src="/tea/image/public/move2.gif" id="<%=t.id%>" value="<%=t.sequence%>" /></td>
    <td>
      <a href="###" onclick="mt.act(this,'edit')">编辑</a>
      <a href="###" onclick="mt.act(this,'clone')">复制</a>
      <a href="###" onclick="mt.act(this,'menu')">权限设置</a>
      <a href="###" onclick="mt.act(this,'consign')">授权</a>
      <a href="###" onclick="mt.act(this,'node')">内容管理权限</A>
      <%--
      <A id="EDN_Desktop" href="/jsp/admin/DynamicDesktop.jsp?node=<%=teasession._nNode%>&role=<%=id%>&community=<%=teasession._strCommunity%>" ><%=r.getString(teasession._nLanguage, "默认桌面")%></A>
      <A id="EDN_NetDisk" href="/jsp/netdisk/EditNetDiskSize.jsp?node=<%=teasession._nNode%>&role=<%=id%>&community=<%=teasession._strCommunity%>"><%=r.getString(teasession._nLanguage, "NetDisk")%></A>
      --%>
      <%
      //if(t.type>1)
      out.print("<a href=### onclick=mt.act(this,'del')>删除</a>");
      %>
    </td>
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='5' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}%>
</table>
<br/>
<input type="button" value="添加" onClick="mt.act(null,'edit')"/>
<!--
<input type="button" value="导出" onclick="mt.act('exp',0)"/>
-->
</form>

<form name="form3" action="/Roles.do" method="POST" target="_ajax">
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
<input type="hidden" name="act"/>
</form>
<script>
mt.sequence(form2.roles,<%=pos%>);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a)
{
  form2.act.value=a;
  form2.role.value=t?mt.ftr(t).id:'';
  if(a=='del')
  {
    mt.show("你确定要删除吗?",2,"form2.submit()");
  }else if(a=='clone')
  {
    form2.submit();
  }else if(a=='exp')
  {
    form3.act.value=a;
    form3.submit();
  }else if(a=='node')
  {
    var rs=window.showModalDialog('/jsp/admin/popedom/NodeRole.jsp?role='+form2.role.value+"&t="+new Date().getTime(),self,'edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;');
    if(rs==1)
    {
      window.location.reload();
    }
    return;
  }else
  {
    if(a=='view')
      form2.action='/jsp/admin/popedom/RoleView.jsp';
    else if(a=='edit')
      form2.action='/jsp/admin/popedom/RoleEdit.jsp';
    else if(a=='menu')
      form2.action='/jsp/admin/popedom/RoleSetMenu.jsp';
    else if(a=='consign')
      form2.action='/jsp/admin/popedom/RoleSetConsign.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
}
</script>
</body>
</html>
