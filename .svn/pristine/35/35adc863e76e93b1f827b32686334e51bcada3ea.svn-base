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
sql.append(" AND p.deleted=0 AND type=2 AND p.community="+DbAdapter.cite(h.community));

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





int sum=Profile.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>

</head>
<body>
<h1>会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>

  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
<h2>列表</h2>
<form name="form2" action="/Paimas.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="member"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td><input type="checkbox" onclick="mt.select(form2.members,checked)"></td>
  <td>序号</td>
  <td>用户名</td>
  <td>姓名</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY p.profile desc");
  Iterator it=Profile.find1(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Profile p=(Profile)it.next();
    AdminUsrRole aur=AdminUsrRole.find(h.community,p.profile);
  %>
  <tr id="<%=MT.enc(p.profile)%>">
  	<td><input type="checkbox" name="members" value="<%=p.profile%>" /></td>
    <td><%=i%></td>
    <td><a href="###" onclick="mt.act(this,'view')"><%=MT.red(p.member,username)%></a></td>
    <td><%=p.getName(h.language)%></td>
    <td>
     <%
     //out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    
       //out.println("<a href=### onclick=mt.act(this,'edit')>编辑</a>");
       if(!"webmaster".equals(p.member))out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
       //out.println("<a href=### onclick=mt.act(this,'reset')>重置密码</a>");
     %>
    </td>
  </tr>
  <%
  }

  if(sum>10){
	  out.print("<tr><td align='left'><input type='button' onclick=mt.act(this,'del') value='批量删除'></td><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10));
  }else{
	  out.print("<tr><td colspan='10' align='left'><input type='button' onclick=mt.act(this,'del') value='批量删除'></td></tr>");
  }
}%>
</table>


</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.member.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,"form2.action='/Paimas.do';form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/type/Consultant/BPersonInfo.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
