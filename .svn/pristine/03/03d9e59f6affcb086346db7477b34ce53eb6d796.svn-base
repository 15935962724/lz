<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>alert('您还没有登录或登录已超时，请重新登录！');top.location.replace('/');</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

sql.append(" AND member!='webmaster' AND deleted=0");

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&username="+Http.enc(username));
}

int sex=h.getInt("sex",-1);
if(sex!=-1)
{
  sql.append(" AND sex="+sex);
  par.append("&sex="+sex);
}

Date birth0=h.getDate("birth0");
if(birth0!=null)
{
  sql.append(" AND birth>"+DbAdapter.cite(birth0));
  par.append("&birth0="+MT.f(birth0));
}

Date birth1=h.getDate("birth1");
if(birth1!=null)
{
  sql.append(" AND birth<"+DbAdapter.cite(birth1));
  par.append("&birth1="+MT.f(birth1));
}

Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+Http.enc(mobile));
}
String email=h.get("email","");
if(email.length()>0)
{
  sql.append(" AND email LIKE "+DbAdapter.cite("%"+email+"%"));
  par.append("&email="+Http.enc(email));
}

int degree=h.getInt("degree");
String name=h.get("name","");

sql.append(" AND EXISTS(SELECT member FROM ProfileLayer pl WHERE p.member=pl.member");
if(degree>0)
{
  sql.append(" AND pl.degree='"+degree+"'");
  par.append("&degree="+degree);
}
if(name.length()>0)
{
  sql.append(" AND pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}
String org=h.get("org","");
if(org.length()>0)
{
  sql.append(" AND pl.organization LIKE "+DbAdapter.cite("%"+org+"%"));
  par.append("&org="+Http.enc(org));
}
String job=h.get("job","");
if(job.length()>0)
{
  sql.append(" AND pl.job LIKE "+DbAdapter.cite("%"+job+"%"));
  par.append("&job="+Http.enc(job));
}
String tel=h.get("tel","");
if(tel.length()>0)
{
  sql.append(" AND pl.telephone LIKE "+DbAdapter.cite("%"+tel+"%"));
  par.append("&tel="+Http.enc(tel));
}
sql.append(")");


int pos=h.getInt("pos");
par.append("&pos=");

int sum=Profile.count(sql.toString());

sql.append(" ORDER BY profile DESC");


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
  <td class="th">姓名：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">姓别：</td><td><select name="sex"><option value="-1">---不限---</option><option value="1">男</option><option value="0">女</option></select></td>
</tr>
<tr>
  <td class="th">单位：</td><td><input name="org" value="<%=org%>"/></td>
  <td class="th">职务：</td><td><input name="job" value="<%=job%>"/></td>
  <td class="th">出生日期：</td><td><input name="birth0" value="<%=MT.f(birth0)%>" onClick="mt.date(this)" class="date"/> 至 <input name="birth1" value="<%=MT.f(birth1)%>" onClick="mt.date(this)" class="date"/></td>
</tr>
<tr>
  <td class="th">手机：</td><td><input name="mobile" value="<%=mobile%>"/></td>
  <td class="th">电话：</td><td><input name="tel" value="<%=tel%>"/></td>
  <td class="th">邮箱：</td><td><input name="email" value="<%=email%>"/>　　<input type="submit" value="查询"/></td>
<%--  <td class="th">注册时间：</td><td><input name="times" value="<%=MT.f(times)%>" onClick="mt.date(this)" class="date"/> 至 <input name="timee" value="<%=MT.f(timee)%>" onClick="mt.date(this)" class="date"/></td>--%>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/EduMembers.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>" />
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>&nbsp;</td>
  <td nowrap>用户名</td>
  <td nowrap>姓名</td>
  <td nowrap>单位</td>
  <td nowrap>职务</td>
  <td nowrap>出生日期</td>
  <td nowrap>手机</td>
  <td nowrap>电话</td>
  <td nowrap>邮箱</td>
  <td nowrap>注册时间</td>
  <td nowrap>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Profile.find(sql.toString(),pos,20);
  while(e.hasMoreElements())
  {
    String mid=(String)e.nextElement();
    Profile p=Profile.find(mid);
    int member=p.getProfile();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="members" value="<%=member%>"/></td>
    <td><%=mid%></td>
    <td><%=p.getName(h.language)+"（"+(p.isSex()?"先生":"女士")+"）"%></td>
    <td><%=MT.f(p.getOrganization(h.language))%></td>
    <td><%=MT.f(p.getJob(h.language))%></td>
    <td><%=MT.f(p.getBirth())%></td>
    <td><%=MT.f(p.getMobile())%></td>
    <td><%=MT.f(p.getTelephone(h.language))%></td>
    <td><%=p.getEmail()%></td>
    <td><%=MT.f(p.getTime(),1)%></td>
    <td member="<%=member%>" username="<%=mid%>">
      <a href="###" onclick="mt.act(this,'edit')">详细</a>
      <a href="/jsp/type/course/CoursePlanPays.jsp?username=<%=Http.enc(mid)%>">培训记录</a>
      <a href="###" onclick="mt.act(this,'clear')">清空密码</a>
      <a href="###" onclick="mt.act(this,'del')">删除</a>
    </td>
  </tr>
  <%}
%>
<tr>
<td colspan="20">
  <span style="float:right"><%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)%></span>
  <input type="checkbox" onClick="mt.select(form2.members,checked)" id="select"/><label for="select">全选</label>
  <input type="button" name="multi" value="批量删除" onClick="mt.act(this,'del')"/>
  <input type="button" name="multi" value="发送E-Mail" onClick="mt.act(this,'email')"/>
  <input type="button" name="multi" value="发送短信" onClick="mt.act(this,'sms')"/>
  <input type="button" value="导出" onClick="mt.act(this,'exp')"/>
</td>
<%
}%>
</table>
<input type="button" value="添加" onclick="mt.act(this,'edit')"/>
</form>

<script>
form1.sex.value="<%=sex%>";
mt.disabled(form2.members);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(m,a,id,b,c)
{
  form2.act.value=a;
  var p=m.parentNode;
  form2.member.value=p.getAttribute('member')||0;
  var username=p.getAttribute('username')||'所选';
  form2.key.disabled=a!='exp';
  if(a=='del')
  {
    mt.show("确认要删除“"+username+"”吗？",2,"form2.submit()");
  }else if(a=='clear')
  {
    mt.show("确认要清空“"+username+"”密码吗？",2,"form2.submit()");
  }else if(a=='exp')
  {
    form2.submit();
  }else
  {
    if(a=='edit')
    {
      form2.action="/jsp/custom/edu/EduMemberEdit.jsp";
    }else if(a=='email')
    {
      form2.action="/jsp/message/MessageEdit.jsp";
    }else if(a=='sms')
    {
      form2.action="/jsp/sms/SMessageAdd.jsp";
    }
    form2.method=form2.target="";
    form2.submit();
  }
};
</script>
</body>
</html>
