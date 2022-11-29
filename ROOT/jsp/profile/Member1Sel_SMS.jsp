<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.sub.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>alert('您还没有登录或登录已超时，请重新登录！');top.location.replace('/');</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?community="+h.community);

String member=h.get("member","");
par.append("&member="+member);

sql.append(" AND deleted=0 AND type=1");
sql.append(" AND member!='webmaster'");

String field=h.get("field","");
if(field.length()>0)
{
  sql.append(" AND "+field+" IS NOT NULL");
  par.append("&field="+field);
}

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&member="+Http.enc(username));
}
//int dept=h.getInt("dept");
//if(dept>0)
//{
//  sql.append(" AND member IN(SELECT member FROM AdminUsrRole WHERE unit="+dept+")");
//  par.append("&dept="+dept);
//}
String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+Http.enc(mobile));
}
String smstype = h.get("smstype","");
if(smstype.length()>0){
	par.append("&smstype="+smstype);
}

int sum=Profile.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

sql.append(" ORDER BY profile DESC");

//Dept d=Dept.getRoot(h.community);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>var pmt=parent.mt;</script>
<style>#go{display:none}</style>
</head>
<body>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="field" value="<%=field%>"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="smstype" value="<%=smstype %>" />
<table id="tablecenter" cellspacing="0">
<tr>
  <td>用户名:<input name="username" value="<%=username%>" size="15"/></td>
<%--
  <td>部门:<select name="dept" style="width:150px"><option value="0">--</option><%=d.options(dept)%></select></td>
--%>
  <td><input type="submit" value="查询"/>
</tr>
</table>
</form>

<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="key" />
<input type="hidden" name="member"/>
<input type="hidden" name="subcontractor"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>&nbsp;</td>
  <td nowrap>用户名</td>
  <td nowrap>手机号</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Profile.find(sql.toString(),pos,15);
  while(e.hasMoreElements())
  {
    username=(String)e.nextElement();
    Profile p=Profile.find(username);
    int mid=p.getProfile();

    out.print("<tr><td><input type='checkbox' name='members'");
    if(member.indexOf("|"+mid+"|")!=-1)out.print(" checked='' disabled");
    out.print(" value='"+mid+"' alt='"+username+"'/>");
    out.print("<td>"+username);
    out.print("<td>"+p.getMobile());
    //out.print("<td>"+MT.f(Dept.find(AdminUsrRole.find(h.community,username).getUnit()).name));
  }
%>
<tr>
<td><input type="checkbox" onClick="mt.select(form2.members,checked)" id="select"/><label for="select">全选</label></td>
<td colspan='2' align='right'><%="共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,15)%></td>
</tr>
<%
}%>
</table>
<input type="button" name="multi" value="确定" onclick="f_ok()"/>
<input type="button" value="关闭" onclick="pmt.close()"/>
</form>

<script>
mt.disabled(form2.members);
function f_ok()
{
  var arr=form2.members||form1.contacts,v='|',n='',h='';
  if(!arr.length)arr=new Array(arr);
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i];
    if(t.disabled||!t.checked)continue;
    v+=t.value+'|';
    n+=t.alt+'；';
   
    h+="<span><input type='hidden' name='<%=smstype%>' value='"+t.value+"'/>"+t.alt+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' />　</span>";
  }
  pmt.receive(v,n,h);
  pmt.close()
}
</script>
</body>
</html>
