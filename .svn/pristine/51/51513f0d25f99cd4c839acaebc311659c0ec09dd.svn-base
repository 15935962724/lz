<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.sub.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>alert('您还没有登录或登录已超时，请重新登录！');top.location.replace('/');</script>");
  return;
}
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

sql.append(" AND type=2 AND deleted=0");
sql.append(" AND community="+DbAdapter.cite(h.community));

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&member="+Http.enc(username));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND member IN(SELECT member FROM ProfileLayer WHERE firstname LIKE "+DbAdapter.cite("%"+name+"%")+")");
  par.append("&name="+Http.enc(name));
}

int sex=h.getInt("sex",-1);
if(sex!=-1)
{
  sql.append(" AND sex="+sex);
  par.append("&sex="+sex);
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

int tab=h.getInt("tab");
int role=h.getInt("role");

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

String[] TAB={"待审","通过","不通过"};
String[] SQL={" AND verifgtime IS NULL"," AND verifgtime IS NOT NULL AND locking=0"," AND locking=1"};

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>.T<%=tab%>{display:none}</style>
</head>
<body>
<h1>成员单位管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">姓名：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">性别：</td><td><select name="sex"><option value="-1">--<option value="1">男<option value="0">女</select></td>
</tr>
<tr>
  <td class="th">手机号：</td><td><input name="mobile" value="<%=MT.f(mobile)%>"></td>
  <td class="th">电子邮箱：</td><td><input name="email" value="<%=MT.f(email)%>"></td>
  <td class="th"></td><td><input type="submit" value="查询"/></td>
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
<input type="hidden" name="type"/>
<input type="hidden" name="role" value="<%=role%>"/>

<div class="switch">
<%
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' id='a_tab"+i+"'>"+TAB[i]+"（"+Profile.count(sql.toString()+SQL[i])+"）</a>");
}
%>
</div>
<script>$("a_tab<%=tab%>").className="current";</script>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>&nbsp;</td>
  <td nowrap>用户名</td>
  <td nowrap>姓名</td>
  <td nowrap>性别</td>
  <td nowrap>手机号</td>
  <td nowrap>电子邮箱</td>
  <td class="T0" nowrap>审核人/时间</td>
  <td nowrap>操作</td>
</tr>
<%
sql.append(SQL[tab]);
int sum=Profile.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY profile DESC");
  Enumeration e=Profile.find(sql.toString(),pos,20);
  while(e.hasMoreElements())
  {
    String mid=(String)e.nextElement();
    Profile p=Profile.find(mid);
    int member=p.getProfile();

  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="members" value="<%=member%>"/></td>
    <td><a href="javascript:mt.act('view',<%=member%>)"><%=mid%></a></td>
    <td><%=p.getName(h.language)%></td>
    <td><%=p.isSex()?"男":"女"%></td>
    <td><%=p.getMobile()%></td>
    <td><%=p.getEmail()%></td>
    <td class="T0"><%=p.getVerifgmember()+" / "+MT.f(p.getVerifgtime(),1)%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('view','"+member+"')>查看</a> ");
    if(acts.contains("audit"))out.println("<a href=javascript:mt.act('audit',"+member+","+(p.isLocking()?0:1)+")>审核</a> ");
    //if(acts.contains("del"))out.println("<a href=javascript:mt.act('del',"+member+")>删除</a> ");
    if(acts.contains("clear"))out.println("<a href=javascript:mt.act('clear',"+member+")>清空密码</a> ");
    %>
    </td>
  </tr>
  <%
  }
%>
<tr>
<td colspan="4"><input type="checkbox" onClick="mt.select(form2.members,checked)" id="select"/><label for="select">全选</label>
<%--
<input type="button" name="multi" value="批量删除" onClick="mt.act('dels','')"/>
<input type="button" name="multi" value="发送E-Mail" onClick="mt.act('email','',value)"/>
<input type="button" name="multi" value="发送站内信" onClick="mt.act('msg','',value)"/>
<input type="button" value="导出Excel" onClick="mt.act('exp','')"/>
--%>
</td>
<td colspan='9' align='right'>
<%
out.print(new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%></td></tr>
</table>
<%--
<input type="button" value="添加" onclick="mt.act('edit','')"/>
--%>
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
  }else if(a=='audit')
  {
    mt.show("状态：<input name='type' type='radio' value='1' id='type1' /><label for='type1'>通过</label>　<input name='type' type='radio' value='0' id='type0' /><label for='type0'>不通过</label>",2,"form2.type.value=$$('type1').checked;form2.submit()");
    $$('type'+b).checked=true;
  }else
  {
    if(a=='edit')
      form2.action="/jsp/admin/popedom/DeptSeqEdit.jsp";
    else if(a=='view')
      form2.action="/jsp/custom/papc/MemberView.jsp";
    form2.method=form2.target="";
    form2.submit();
  }
};
</script>
</body>
</html>
