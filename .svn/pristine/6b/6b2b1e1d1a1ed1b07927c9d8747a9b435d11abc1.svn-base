<%@page contentType="text/html;charset=utf-8" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<% request.setCharacterEncoding("utf-8");

TeaSession teasession=new TeaSession(request);

if(request.getParameter("act")!=null)
{
	String email = request.getParameter("Email");
	String mobile = request.getParameter("Mobile");
	String question=request.getParameter("Question");
	String answer = request.getParameter("Answer");
	String nexturl = request.getParameter("nexturl");
	Profile probj = Profile.find(teasession._rv.toString());

	probj.set_anquan(email,mobile,question,answer);
	//probj.set(question,answer);
	response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode("安全信息修改成功","UTF-8")+"&nexturl="+nexturl);
	return;

}
Profile profile = Profile.find(teasession._rv.toString());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<div id="alqq">
<div id="h"><h1>安全信息</h1></div>
<form name="form1" METHOD=post  action=""  id="lzj_bd001">
<input type=hidden value="SafetyUser" name="act">
<input type=hidden value="<%=request.getRequestURL() %>" name="nexturl">
<div id="denglu">　　　<div id="shezhi3">账户安全信息</div> <br>
  <div id="shurukuang">
  <span class="shezhi4">　　　* </span>电子邮箱：
    <input name="Email" type="text" id="Email" value="<%if(profile.getEmail()!=null)out.print(profile.getEmail()); %>">
   &nbsp;&nbsp;&nbsp;&nbsp; 通过邮箱找回密码<br>
    <span class="shezhi4">　　　*</span> 移动电话：
    <input name="Mobile" type="text" id="Mobile" onKeyPress="inputInteger();" value="<%if(profile.getMobile()!=null)out.print(profile.getMobile()); %>">
   &nbsp;&nbsp;&nbsp;&nbsp; 通过移动电话找回密码<br>
    <br>
    <span class="shezhi4">　*</span> 密码提示问题：
    <select name="Question" >
      <option value="">请选择密码提示问题
        <option value="1" <%if(profile.getQuestion().equals("1"))out.print(" selected"); %>>你常去什么网站?</option>
          </select>
    <br>
    <span class="shezhi4">　　　　* </span>答　案：
    <input name="Answer" type="text" id="Answer" value="<%if(profile.getAnswer()!=null)out.print(profile.getAnswer()); %>">  <br>

<div id="shezhi6"><INPUT type=image id="df" src="/res/Home/u/0811/081151603.gif"></div>

</div>
</form>
<div id="shezhi5">请认真填写以上所有内容，安全信息一旦设定，将不能修改</div>
</option>

</body>
</html>


