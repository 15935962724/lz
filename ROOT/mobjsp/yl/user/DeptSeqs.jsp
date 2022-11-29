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


sql.append(" AND p.type=0 AND member <> 'webmaster' ");

int len=sql.length();

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND p.member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&username="+Http.enc(username));
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

int membertype = h.getInt("membertype",-1);

if(membertype>-1){
     sql.append(" AND p.membertype ="+membertype);
	 par.append("&membertype="+membertype);
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
<h1>用户管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">用户名：</td><td><input name="username" value="<%=username%>"/></td>
  <td class="th">手机号：</td><td><input name="mobile" value="<%=mobile%>"/></td>
  <td class="th">邮箱：</td><td><input name="email" value="<%=email%>"/></td>
  <td class="th">用户类型：
  <select name="membertype">
  	<option value="-1">--全部--</option>
  	<%
  		for(int i=0;i<Profile.MEMBER_TYPE.length;i++){
  			out.print("<option "+(i==membertype?"selected='selected'":"")+" value='"+i+"'>"+Profile.MEMBER_TYPE[i]+"</option>");
  		}
  	%>
  </select>
  </td>
  <td><input type="submit" value="查询" class="btn btn-primary"/></td>
</tr>
</table>
</form>
<h2>列表</h2>
<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="member"/>
<input type="hidden" name="act" value="delete"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户名</td>
  <td>手机</td>
  <td>邮箱</td>
  <td>用户类型</td>
  <td>用户积分</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY p.profile");
  Iterator it=Profile.find1(sql.toString(),pos,15).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Profile p=(Profile)it.next();
    AdminUsrRole aur=AdminUsrRole.find(h.community,p.profile);
  %>
  <tr id="<%=MT.enc(p.profile)%>">
    <td><%=i%><input type="checkbox" name="members" value="<%=p.profile%>" style="display:none"/></td>
    <td><a href="###" onclick="mt.act(this,'view')"><%=MT.red(p.member,username)%></a></td>
    <td><%= MT.f(p.getMobile()) %></td>
    <td><%= MT.f(p.getEmail()) %></td>
    <td><%= Profile.MEMBER_TYPE[p.membertype] %></td>
    <td><%= p.getIntegral() %></td>
    <td>
     <%
     out.println("<a href=### onclick=mt.act(this,'edit',"+p.profile+")>编辑</a>");
     out.println("<a href=### onclick=mt.act(this,'delete',"+p.profile+")>删除</a>");
     out.println("<a href=### onclick=mt.show('/jsp/yl/shop/ShopPointsEdit.jsp?member="+p.profile+"',2,'积分设置',600,300)>积分设置</a>");
     %>
    </td>
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,15));
}%>
</table>
<%
out.println("<input type='button' class='btn btn-primary' value='添加' onclick=mt.act(this,'edit',0) />");
%>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  if(a=='edit')
  {
	  form2.member.value = b;
	  form2.action='/jsp/yl/user/EditProfile.jsp';form2.target='_self';form2.method='get';form2.submit();
    //location = "/jsp/yl/user/EditProfile.jsp?member="+b+"&nexturl="+form2.nexturl.value;
  }else if(a=='delete')
  {
	  mt.show("是否删除？",2);
	    mt.ok=function()
	    {
	    	form2.member.value=b;
	  	  form2.submit();
	    };
	}
};
</script>
</body>
</html>
