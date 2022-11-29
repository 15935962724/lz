<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.node.ChildMember" %><%@ page import="tea.entity.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %>
<%
	//Http h=new Http(request,response);
	TeaSession teasession = new TeaSession(request);

	if(teasession._rv==null)
	{
	  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	  return;
	}
	String member="";
	if(teasession._rv._strR!=null&&teasession._rv._strR.length()>0){
		member=teasession._rv._strR;
	}else{
		member=teasession._rv._strV;

	}
	String fname="",unitname="",position="",email="",mobile="",qq="",phone="",birth="",ltime1="";
	boolean sex=false;
	String url=request.getRequestURL().toString();
	ChildMember cm=ChildMember.findChildMember(member,teasession._nLanguage);
	if(cm.isExist()){
		fname=cm.getFname();
		unitname=cm.getUnitname();
		position=cm.getPosition();
		email=cm.getEmail();
		mobile=cm.getMobile();
		qq=cm.getQq();
		phone=cm.getPhone();
		birth=cm.getBirth();
		ltime1=cm.getLtime1();
		sex=cm.getSex();
	}
%>

 <script src="/tea/Calendar.js" type="text/javascript"></script>
 <script src="/jsp/type/ChildMember/register.js" type="text/javascript"></script>


<h2>账户设置</h2>
<div class="accountSet">用户名：<span><%=member %></span><a href="javascript:" onClick="Jump();">修改密码</a>
<span class="lastLogin">您上次登录时间：<%=ltime1%></span></div>
<div id=div1>
<div class="basicInfo">
<h2>基本信息</h2>
<form name="form1" action="/ChildMembers.do" target="_ajax" onsubmit="checkSome();">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="nextUrl" value="<%=url%>"/>
<table id="tab1">
	<tr>
		<td align="right">姓名：</td>
		<td><input type="text" name="fname" alt="姓名" value="<%=fname%>"></td>
		<td align="right">性别：</td>
		<td>
			<select name="sex">
				<option value="1" <%=sex?"selected":"" %>>男</option>
				<option value="0" <%=!sex?"selected":"" %>>女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">单位全称：</td>
		<td><input type="text" name="unitname" alt="单位全称" value="<%=unitname%>"></td>
		<td align="right">职务：</td>
		<td><input type="text" name="position" value="<%=position%>"></td>
	</tr>
	<tr>
		<td align="right">出生日期：</td>
		<td>
		<input id="" name="birth" size="7"  value="<%=birth %>"  style="cursor:pointer;width:126px;" readonly onClick="getDates();">
  <img style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="getDates();" />
		</td>
		<td align="right">手机号：</td>
		<td><input type="text" name="mobile" value="<%=mobile%>"></td>
	</tr>
	<tr>
		<td align="right">办公电话：</td>
		<td><input type="text" name="phone" value="<%=phone%>"></td>
		<td align="right">邮箱：</td>
		<td><input type="text" name="email" alt="邮箱" value="<%=email%>"></td>
	</tr>
	<tr>
		<td align="right">qq：</td>
		<td><input type="text" name="qq" value="<%=qq%>"></td>
		<td align="right" colspan="2"></td>
	</tr>
</table>
	<input type="submit" class="submit" value="修改"/>
</form>
</div>
</div>
<!--<div id=div2>
<h2>修改密码</h2>
<form name="form2" action="/ChildMembers.do">
<input type="hidden" name="act" value="changePwd"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="nextUrl" value="<%=url%>"/>
<table id="tab1">
	<tr>
		<td>旧密码</td>
		<td><input type="password" name="oldpwd"/></td>
	</tr>
	<tr>
		<td>新密码</td>
		<td><input type="password" name="pwd"/></td>
	</tr>
	<tr>
		<td>确认密码</td>
		<td><input type="password" name="pwd2"/></td>
	</tr>

</table>
<input type="button" onclick="subpwd();" value="保存"/>
</form>-->
</div>
