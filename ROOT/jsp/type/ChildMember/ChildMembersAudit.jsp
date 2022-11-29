<%@ page language="java" contentType="text/html; charset=UTF-8"%><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.db.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


Http h=new Http(request,response);
TeaSession tea=new TeaSession(request);

if(tea._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

StringBuffer sb1=new StringBuffer();
StringBuffer sb2=new StringBuffer();
String id=h.get("id", "");
sb2.append("?community="+h.community);
sb2.append("&id="+id);
String member=h.get("member", "").trim();
if(member.length()>0){
	sb1.append(" and member like "+DbAdapter.cite("%"+member+"%"));
	sb2.append("&member="+member);
}

String email=h.get("email", "").trim();
if(email.length()>0){
	sb1.append(" and email like "+DbAdapter.cite("%"+email+"%"));
	sb2.append("&email="+email);
}

String birth=h.get("birth", "").trim();
if(birth.length()>0){
	sb1.append(" and birth = "+DbAdapter.cite(birth));
	sb2.append("&birth="+birth);
}

String mobile=h.get("mobile", "").trim();
if(mobile.length()>0){
	sb1.append(" and mobile like "+DbAdapter.cite("%"+mobile+"%"));
	sb2.append("&mobile="+mobile);
}


String fname=h.get("fname", "");
String unitname=h.get("unitname", "");
String position=h.get("position", "");
String phone=h.get("phone", "");
if(fname.length()>0||unitname.length()>0||position.length()>0||phone.length()>0)
{
	sb1.append(" and member in ( select member from ProfileLayer where language="+h.language);
	if(fname.length()>0){
		sb1.append(" and firstname like "+DbAdapter.cite("%"+fname+"%"));
		sb2.append("&fname="+fname);
	}
	if(unitname.length()>0){
		sb1.append(" and unitname like "+DbAdapter.cite("%"+unitname+"%"));
		sb2.append("&unitname="+unitname);
	}
	if(position.length()>0){
		sb1.append(" and position like "+DbAdapter.cite("%"+position+"%"));
		sb2.append("&position="+position);
	}
	if(phone.length()>0){
		sb1.append(" and telephone like "+DbAdapter.cite("%"+phone+"%"));
		sb2.append("&phone="+phone);
	}
	sb1.append(")");
}

int membertype=h.getInt("membertype",5);
	sb1.append(" and membertype = "+membertype);

int count=0,size=10,pos=0;
pos=h.getInt("pos", 0);

count=ChildMember.count(h.community, sb1.toString());
%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
 <script src="/tea/tea.js" type="text/javascript"></script>
 <script src="/tea/mt.js" type="text/javascript"></script>
 <script src="/tea/Calendar.js" type="text/javascript"></script>
 <script src="/jsp/type/ChildMember/register.js" type="text/javascript"></script>

<link href="/res/<%=h.community%>/cssjs/community.css" type="text/css" rel="stylesheet">

 <script type="text/javascript">
function getDates(){

	if(mt.isIE){
		var d=new Calendar();
		d.show('form1.birth');
	}else{
		var d=new Calendar(1900+new Date().getYear());
		d.show('form1.birth');
	}
}

</script>
</head>
<body>
<h2>查询</h2>
<form name="form1" action="?">

	<table id="tablecenter" border="0" cellpadding="0" cellspacing="0">
		<input type="hidden" name="id" value="<%=id%>"/>
		<input type="hidden" name="membertype" value="<%=membertype%>"/>
		<tr>
			<td>用户名：</td>
			<td><input type="text" name="member" value="<%=member%>"/></td>
			<td>姓名：</td>
			<td><input type="text" name="fname" value="<%=fname%>"/></td>
			<td>单位全称：</td>
			<td><input type="text" name="unitname" value="<%=unitname%>"/></td>
		</tr>
		<tr>
			<td>职务：</td>
			<td><input type="text" name="position" value="<%=position%>"/></td>
			<td>出生日期：</td>
			<td><input id="" name="birth" size="7"  value="<%=birth%>"  style="cursor:pointer;width:126px;" readonly onClick="getDates();">
  <img style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="getDates();" /></td>
			<td>手机号：</td>
			<td><input type="text" name="mobile" value="<%=mobile%>"/></td>
		</tr>
		<tr>
			<td>电话：</td>
			<td><input type="text" name="phone" value="<%=phone%>"/></td>
			<td>邮箱：</td>
			<td><input type="text" name="email" value="<%=email%>"/></td>
			<td colspan="2"><input type="submit" value="查询"/></td>
		</tr>
	</table>
</form>


<h2>会员列表 (目前共有<font color="#000000" size="3"><%=count %></font>会员)
<input type="button" onclick="f_tab(5);" value="未审核"/><input type="button" onclick="f_tab(9);" value="未通过"/>
</h2>
<form name="form2">

<table id="tablecenter" border="0" cellpadding="0" cellspacing="0">
<input type="hidden" name="community" value="<%=h.community %>"/>
<input type="hidden" name="act" value=""/>
<tr>
  <td><input type="checkbox" value="" name="" onclick="selectAll(form2.mems,checked)"/></td>
  <td>会员ID</td>
  <td>用户名</td>
  <td>姓名</td>
  <td>单位</td>
  <td>职务</td>
  <td>性别</td>
  <td>出生年月日</td>
  <td>手机号</td>
  <td>电话</td>
  <td>邮箱</td>
  <td>注册时间</td>
  <td>操作</td>
</tr>
<%
Enumeration e=ChildMember.find(h.community, sb1.toString()+" order by profile desc", pos, size);
while(e.hasMoreElements()){
	String memberid=(String)e.nextElement();
	ChildMember cm=ChildMember.findChildMember(memberid, h.language);

%>
<tr>
	<td><input type="checkbox" value="<%=cm.getMember() %>" name="mems" /></td>
	<td><%=cm.getMid() %></td>
	<td><%=cm.getMember() %></td>
	<td><%=cm.getFname() %></td>
	<td><%=cm.getUnitname() %></td>
	<td><%=cm.getPosition() %></td>
	<td><%=cm.getSex()?"男":"女" %></td>
	<td><%=cm.getBirth() %></td>
	<td><%=cm.getMobile() %></td>
	<td><%=cm.getPhone() %></td>
	<td><%=cm.getEmail() %></td>
	<td><%=cm.getTime() %></td>
	<td><a href='###' onMouseOver='mt.more(this)'>操作</a><div style='display:none'><a href="javascript:f_v('<%=cm.getMember()%>');">审核</a><a href="javascript:delInfo('<%=cm.getMember()%>','<%=h.community%>','ChildMembersAudit');">删除</a></div></td>
</tr>
<%}%>
 <%if (count > size) {  %>
  <tr> <td colspan="2"><input type="button" onclick="delAll('<%=h.community %>','ChildMembersAudit');" value="批量删除"/><input type="button" onclick="f_v();" value="批量审核"/></td><td colspan="10" align="right"><%=new tea.htmlx.FPNL(h.language,request.getRequestURI()+sb2.toString()+"&pos=",pos,count,size)%>    </td> </tr>
  <%} else{ %>
 <tr> <td colspan="20"><input type="button" onclick="delAll('<%=h.community %>','ChildMembersAudit');" value="批量删除"/><input type="button" onclick="f_v();" value="批量审核"/></td></tr>
  <%} %>
</table>
</form>
</body>
</html>
