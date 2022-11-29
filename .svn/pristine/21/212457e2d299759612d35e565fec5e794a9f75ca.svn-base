<%@page contentType="text/html;charset=utf-8" %><%@ page import="tea.ui.TeaSession"%><%@ page import = "tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
tea.resource.Resource r = new tea.resource.Resource("/tea/resource/ProfilePostulant");

String member=request.getParameter("member");
ProfilePostulant pp=ProfilePostulant.find(member,teasession._strCommunity);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1>积分/审核/编号</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 METHOD=POST ACTION="/servlet/EditProfilePostulant" onSubmit="return f_submit(this);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
<input type="hidden" name="act" value=""/>

<h2>积分</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>积分:</td>
      <td><input type="text" onBlur="this.value=this.value.replace(/\D/g,'');" onKeyPress="if(window.event.keyCode<48||window.event.keyCode>57)window.event.returnValue=false;"  name=point value="<%=pp.getPoint()%>"  size=20 maxlength=9></td>
    </tr>
	   	<tr><td></td><td><input type="submit" onclick="form1.act.value='setpoint'; return submitInteger(form1.point,'无效-积分');" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
		<input type="reset"  value="重置">
	   	<input type="button" onclick="window.history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>"></td></tr>
	</table>
		<br>


	<h2>审核</h2>
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
	  <td>审核:</td>
	  <td><input name="auditing" type="radio" value="true" checked>批准
	  <input type="radio" name="auditing" value="false" <%if(!pp.isAuditing())out.print(" checked ");%>>拒绝 </td>
	</tr>
   	<tr><td></td><td><input type="submit" onclick="form1.act.value='setauditing';" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
			<input type="reset"  value="重置">
	   	<input type="button" onclick="window.history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>"></td></tr>
	</table>
	<br>



		<h2>编号</h2>
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		<tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
		  <td>编号:</td>
		  <td><input type="hidden" name="code_old" value="<%=pp.getCode()%>"/>
                    <input type="text"  name=code  value="<%=pp.getCode()%>"  size=20 maxlength=40></td>
		</tr>
   	<tr><td></td><td><input type="submit" onclick="form1.act.value='setcode';" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
			<input type="reset" value="重置">
	   	<input type="button" onclick="window.history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>"></td></tr>
	</table>
</FORM>
<br>
<SCRIPT>document.form1.point.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>



