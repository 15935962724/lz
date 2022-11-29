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
<!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>导出设置了服务商的医院</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='8' class='bornone'>查询</td></tr>
</thead>
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
  <td class='bornone'><input type="submit" value="查询" class="btn btn-primary"/></td>
</tr>
</table>
</div>
</form>
<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="member"/>
<input type="hidden" name="act" value="delete"/>
<input type="hidden" name="locking" />
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='10'>列表</td></tr>
</thead>
<tr>
  <th width='60'>序号</th>
  <th>用户名</th>
  <th>手机</th>
  <th>邮箱</th>
  <th>用户类型</th>
  <th>用户积分</th>
  
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
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
    <td><%=MT.red(p.member,username)%></td>
    <td><%= MT.f(p.getMobile()) %></td>
    <td><%= MT.f(p.getEmail()) %></td>
    <td><%= Profile.MEMBER_TYPE[p.membertype] %></td>
    <td><%= p.getIntegral() %></td>
    
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,15));
}%>
</table>
</div>


</form>
<form action="/ShopHospitals.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="hospitalexp" type="hidden" />
	
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dchospital()">导出</button></div>
<script>
function dchospital(){
	form3.submit();
}
</script>
</body>
</html>
