<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

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

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND p.deleted=0 AND p.community="+DbAdapter.cite(h.community));

boolean isM="webmaster".equals(h.username);
if(!isM)
{
  sql.append(" AND p.member!='webmaster'");
}

int len=sql.length();
//判断显示
boolean ispass = false;

String username=h.get("username","");
if(username.length()>0)
{
	ispass = true;
  sql.append(" AND p.member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&username="+Http.enc(username));
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  ispass = true;
  sql.append(" AND p.mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+Http.enc(mobile));
}

int sex=h.getInt("sex",-1);
if(sex!=-1)
{
  ispass = true;
  sql.append(" AND p.sex="+sex);
  par.append("&sex="+sex);
}

//范围
int selectrole=h.getInt("selectrole");
par.append("&selectrole="+selectrole);
int dept=h.getInt("dept");
//String numstr = "";
//if(selectrole==0&&ispass){
//	Iterator it=Dept.find(" AND path like '%/"+dept+"/%'",0,200).iterator();
//	 while(it.hasNext()){
//		 Dept d=(Dept)it.next();
//		 numstr += d.dept+",";
//	 }
//	 numstr = numstr.substring(0,numstr.length()-1);
//	sql.append(" AND ds.dept in ("+numstr+")");
//}else{
	sql.append(" AND ds.dept="+dept);
//}
par.append("&dept="+dept);
//
//if(ispass){
//	sql.append("AND dept in (CASE when (select count(1) from deptseq where member=p.profile) > 1 then (select top 1 dept from deptseq where member=p.profile and dept in ("+(numstr==""?"''":numstr)+")) else (select dept from deptseq where member=p.profile) end)");
//}
int sum=Profile.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

AdminUnit d=AdminUnit.find(dept);

AdminFunction m=AdminFunction.find(menuid);
String acts=m.getAction(h)+",oper";


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
<%
if(ispass)out.print(".SEQ{display:none}");
%>
</style>
</head>
<body>
<h1>用户管理——<%=d.name%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="dept" value="<%=dept%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">性别：</td><td><select name="sex"><option value="-1">--<option value="1">男<option value="0">女</select></td>
  <td class="th">手机号：</td><td><input name="mobile" value="<%=mobile%>"/></td>
<%--
  <td class="th">查询范围：</td><td><select name="selectrole"><option value="0" <% if(selectrole==0){out.print("selected='selected'");}; %>>含分局</option>
  <option value="1" <% if(selectrole==1){out.print("selected='selected'");}; %>>不含分局</option></select>
  </td>
--%>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
<h2>列表</h2>
<form name="form2" action="/DeptSeqs.do?dept=<%=dept%>" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="dept" value="<%=dept%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="member"/>
<input type="hidden" name="acts" value="<%= acts %>" />
<input type="hidden" name="act"/>
<input type="hidden" name="locking"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户名</td>
  <td>姓名</td>
  <td>手机号</td>
  <td>角色</td>
  <td class="SEQ">顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY ds.sequence,p.profile");
  Iterator it=Profile.find1(sql.toString(),pos,15).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Profile p=(Profile)it.next();
    AdminUsrRole aur=AdminUsrRole.find(h.community,p.profile);
  %>
  <tr id="<%=MT.enc(p.profile)%>">
    <td><%=i%><input type="checkbox" name="members" value="<%=p.profile%>" style="display:none"/></td>
    <td><a href="###" onclick="mt.act(this,'view')"><%=MT.red(p.member,username)%></a></td>
    <td><%=p.getName(h.language)%></td>
    <td><%=MT.f(p.mobile)%></td>
    <td><%=AdminRole.f(aur.getRole())%></td>
    <td class="SEQ"><img name="sequence" src="/tea/image/public/move2.gif" seq="<%=DeptSeq.find(dept,p.profile).sequence%>" /></td>
    <td>
     <%
     out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
     if(acts.contains("oper"))
     {
       out.println("<a href=### onclick=mt.act(this,'edit')>编辑</a>");
       if(!"webmaster".equals(p.member) && !"admin".equals(p.member)){
    	   out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
       }
       if(p.isLocking()){
       		if(!"webmaster".equals(p.member) && !"admin".equals(p.member))out.println("<a href=### onclick=mt.act(this,'lock',0)>启用</a>");
       }else{
       		if(!"webmaster".equals(p.member) && !"admin".equals(p.member))out.println("<a href=### onclick=mt.act(this,'lock',1)>禁用</a>");
       }
     }
     if(acts.contains("reset"))
     {
       out.println("<a href=### onclick=mt.act(this,'reset')>重置密码</a>");
     }
     %>
    </td>
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,15));
}%>
</table>

<%
if(acts.contains("oper"))
{
  out.println("<input type='button' value='添加' onclick=mt.act(null,'edit') />");
  if(isM)out.println("<input type='button' value='添加已存在的用户' onclick=mt.act(null,'add') />");
}
%>
</form>

<script>
form1.sex.value="<%=sex%>";
mt.sequence(form2.members,<%=pos%>);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.member.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,"form2.action='/Members.do';form2.submit()");
  }else if(a=='reset')
  {
    mt.show('你确定要重置密码吗？',2,"form2.action='/Members.do';form2.submit()");
  }else if(a=='add')
  {
    mt.show("用户名：<input id='_member' />",2,"form2.member.value=$$('_member').value;form2.submit();return false;");
  }else if(a=='lock'){
	  if(b==0){
		form2.locking.value=0;
	  	mt.show('你确定要启用该用户吗？',2,"form2.action='/Members.do';form2.submit()");
	  }else{
		form2.locking.value=1;
		mt.show('你确定要禁用该用户吗？',2,"form2.action='/Members.do';form2.submit()");
	  }
  }else{
    if(a=='view')
      form2.action='/jsp/profile/Member1View.jsp';
    else if(a=='edit')
      form2.action='/jsp/admin/popedom/DeptSeqEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
