<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX").add("/tea/ui/node/type/sms/EditUser");

Community c=Community.find(teasession._strCommunity);

if(request.getMethod().equals("POST"))
{
	String vertify=(String)session.getAttribute("sms.vertify");
	String vertify1 = request.getParameter("vertify").trim();

	if (!vertify1.equals(vertify))
	{
	  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ConfirmCodeError")+"<a href=\"javascript:history.back();\">"+r.getString(teasession._nLanguage, "Tautology")+"</A>","UTF-8"));
	  return;
	}
	
	String name=request.getParameter("name");
	String domain=request.getParameter("domain");
	String passwd=request.getParameter("passwd");
	String cpasswd=request.getParameter("cpasswd");
	
	Vpopmail obj=Vpopmail.find(name,domain);
	if(obj.isExists())
	{
		response.sendRedirect( "/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode("用户已存在.<a href=\"javascript:history.back();\">"+r.getString(teasession._nLanguage, "Tautology")+"</A>","UTF-8"));
		return;
	}
	
	Vpopmail.create(c.getSmtp(),name,domain,cpasswd);
	
	response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode("注册成功.","UTF-8")+"&nexturl="+java.net.URLEncoder.encode("http://"+c.getSmtp(),"UTF-8"));
	return;
}
String domain=c.getSmtp();
int i=domain.indexOf(".");
if(i==-1)
{
	response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode("SMTP设置不正确.","UTF-8"));
	return;
}
domain=domain.substring(i+1);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1>注册邮箱</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" method="post" onsubmit="return submitIdentifier(form1.name,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(form1.passwd,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(form1.passwd,form1.cpasswd,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')&&submitInteger(form1.vertify,'<%=r.getString(teasession._nLanguage, "Validate")%>')">
<input type=hidden name=community value="<%=teasession._strCommunity%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>用户名</td>
      <td><input name="name" type="text">@<%=domain%><input type=hidden name=domain value="<%=domain%>"></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>密码:</td>
      <td><input name="passwd" type="password" size=30></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>确认密码:</td>
      <td><input name="cpasswd" type="password" size=30></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=r.getString(teasession._nLanguage, "Validate")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=vertify maxlength=20> <img src="validate.jsp" ></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td></td>
      <td><input type="submit"  value="提交">
        <input type="reset" value="重置"></td>
    </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
