<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

String acts=h.get("acts","");

int root=AdminUnit.getRootId(h.community);

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

sql.append(" AND p.type=1 AND p.community="+DbAdapter.cite(h.community));
if(!h.debug)sql.append(" AND p.recycle=0");
if(!"webmaster".equals(h.username))sql.append(" AND p.member!='webmaster'");
sql.append(" AND(aur.community="+DbAdapter.cite(h.community)+" OR aur.community IS NULL)");
//sql.append(" AND p.member!='webmaster' AND aur.role!='/44/'");

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND p.member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&username="+Http.enc(username));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND pl.lastname+pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}

int sex=h.getInt("sex",-1);
if(sex!=-1)
{
  sql.append(" AND p.sex="+sex);
  par.append("&sex="+sex);
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND p.mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+Http.enc(mobile));
}

String email=h.get("email","");
if(email.length()>0)
{
  sql.append(" AND p.email LIKE "+DbAdapter.cite("%"+email+"%"));
  par.append("&email="+Http.enc(email));
}

String qq=h.get("qq","");
if(qq.length()>0)
{
  sql.append(" AND p.qq LIKE "+DbAdapter.cite("%"+qq+"%"));
  par.append("&qq="+Http.enc(qq));
}

//兼容部门
String depts="";
boolean isMe=h.getBool("me");
if(isMe)
{
  sql.append(" AND( 1=0");
  AdminUsrRole aur=AdminUsrRole.find(h.community,h.username);
  depts=MT.f(aur.getDept(),"/");
  String[] arr=depts.split("/");
  for(int i=1;i<arr.length;i++)
  {
    AdminUnit d=AdminUnit.find(Integer.parseInt(arr[i]));
    sql.append(" OR aur.unit IN("+(d.id==root?String.valueOf(d.id):"SELECT id FROM AdminUnit WHERE path LIKE '"+d.path+"%'")+")");
  }
  sql.append(")");
}

int role=h.getInt("role");
if(role>0)
{
  sql.append(" AND aur.role LIKE "+DbAdapter.cite("%/"+role+"/%"));
  par.append("&role="+role);
}

String mname=h.get("mname","");
if(mname.length()>0)
{
  sql.append(" AND(1=0");
  ArrayList al=AdminFunction.find(" AND af.community="+DbAdapter.cite(h.community)+" AND afl.name"+(mname.charAt(0)=='='?"="+DbAdapter.cite(mname.substring(1)):" LIKE "+DbAdapter.cite("%"+mname+"%")),0,200);
  for(int i=0;i<al.size();i++)
  {
    AdminFunction m=(AdminFunction)al.get(i);
    ArrayList al2=AdminRole.find(" AND adminfunction LIKE '%|"+m.id+":%'",0,200);
    for(int j=0;j<al2.size();j++)
    {
      AdminRole ro=(AdminRole)al2.get(j);
      sql.append(" OR aur.role LIKE '%/"+ro.id+"/%'");
    }
  }
  sql.append(")");
  par.append("&mname="+Http.enc(mname));
}

int dept=h.getInt("dept");
if(dept>0)
{
  sql.append(" AND aur.unit IN("+(dept==root?String.valueOf(dept):"SELECT id FROM AdminUnit WHERE path LIKE '"+AdminUnit.find(dept).path+"%'")+")");
  par.append("&dept="+dept);
}

int order=h.getInt("order",6);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=Profile.count(sql.toString());





out.print("<!-- "+sql.toString()+" -->");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1><!--后台用户管理-->
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">姓名：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">性别：</td><td><select name="sex"><option value="-1">--<option value="1">男<option value="0">女</select></td>
</tr>
<tr>
  <td class="th">手机号：</td><td><input name="mobile" value="<%=MT.f(mobile)%>"></td>
  <td class="th">电子邮箱：</td><td><input name="email" value="<%=MT.f(email)%>"></td>
  <td class="th">腾讯QQ：</td><td><input name="qq" value="<%=MT.f(qq)%>"></td>
</tr>
<tr>
  <td class="th">角色：</td><td><select name="role"><option value="0">--</option><%=AdminRole.options(" AND community="+DbAdapter.cite(h.community),role)%></select></td>
  <td class="th">部门：</td><td><select name="dept"><option value="0">--</option><%=AdminUnit.options(" AND community="+DbAdapter.cite(h.community),dept)%></select></td>
  <td class="th">权限：</td><td><input name="mname" value="<%=mname%>"/>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>



<h2>列表</h2>
<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="key" />
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="merge"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="18" align="center"><input type="checkbox" onClick="mt.select(form2.members,checked)" title="选中/取消选中"/></td>
  <td nowrap><a href="javascript:mt.order('O1')" id="O1">用户名</a></td>
  <td nowrap><a href="javascript:mt.order('O2')" id="O2">姓名</a></td>
  <td nowrap><a href="javascript:mt.order('O3')" id="O3">部门</a></td>
  <td nowrap><a href="javascript:mt.order('O4')" id="O4">QQ</a></td>
  <td nowrap><a href="javascript:mt.order('O5')" id="O5">手机号</a></td>
  <td nowrap>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"p.profile","p.member","pl.firstname","aur.unit","p.qq","p.mobile","p.time"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+","+ORDER_TYPE[0]);
  Iterator it=Profile.find1(sql.toString(),pos,15).iterator();
  while(it.hasNext())
  {
    Profile p=(Profile)it.next();
    String mid=p.getMember();
    int member=p.getProfile();
    AdminUsrRole aur=AdminUsrRole.find(h.community,p.profile);

  %>
  <tr data='<%=p%>'>
    <td width="18" align="center"><input type="checkbox" name="members" value="<%=member%>"/></td>
    <td><a href="/jsp/profile/Member1View.jsp?member=<%=member%>"><%=MT.red(mid,username)%></a></td>
    <td><%=MT.red(p.getName(h.language),name)%></td>
    <td><%=aur.getUnit()<1?"--":AdminUnit.find(aur.getUnit()).getPath()%></td>
    <td><%=MT.red(p.qq,qq)%></td>
    <td><%=MT.red(p.mobile,mobile)%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('view','"+member+"')>查看</a>");
    if(acts.contains("oper"))
    {
      out.println("<a href=javascript:mt.act('edit','"+member+"')>编辑</a>");
      out.println("<a href=javascript:mt.act('del','"+member+"')>删除</a>");
      out.println("<a href=javascript:mt.act('clear','"+member+"')>清空密码</a>");
    }
    %>
    </td>
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='9' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}
%>
</table>
<%--
<input type="button" name="multi" value="发送E-Mail" onClick="mt.act('email','',value)"/>
<input type="button" name="multi" value="发送站内信" onClick="mt.act('msg','',value)"/>
<input type="button" value="导出Excel" onClick="mt.act('exp','')"/>
--%>
<input type="button" name="multi" value="批量删除" onClick="mt.act('del','')"/>
<input type="button" name="multi" value="合并" onClick="mt.act('merge','0')"/>
<input type="button" value="添加" onClick="mt.act('edit','')"/>
</form>

<script>
form1.sex.value=<%=sex%>;
mt.disabled(form2.members);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b,c)
{
  form2.act.value=a;
  form2.member.value=id;
  if(a=='del')
  {
    mt.show("确认要删除吗？",2,"form2.submit()");
  }else if(a=='clear')
  {
    mt.show("确认要清空密码吗？",2,"form2.submit()");
  }else if(a=='exp')
  {
    form2.key.value="<%=MT.enc(sql.toString())%>";
    form2.submit();
  }else if(a=='merge')
  {
    var h='',arr=form2.members;
    for(var i=0;i<arr.length;i++)
    {
      if(!arr[i].checked)continue;
      eval("d="+mt.ftr(arr[i]).getAttribute('data'));
      h+="<option value="+d.id+">"+d.username;
    }
    mt.show("合并为：<select id='_merge'>"+h+"</select>",2,"form2.merge.value=$$('_merge').value;form2.submit();");
  }else
  {
    if(a=='edit')
      form2.action="/jsp/admin/popedom/DeptSeqEdit.jsp";
    else if(a=='view')
      form2.action="/jsp/profile/Member1View.jsp";
    form2.method=form2.target="";
    form2.submit();
  }
};
//setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
