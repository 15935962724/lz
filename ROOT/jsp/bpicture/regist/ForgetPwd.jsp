<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.member.Message"%>
<%@ page import="tea.entity.member.Profile"%>
<%@ page import="tea.entity.site.License"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.service.Robot"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.http.RequestHelper"%>




<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

%>



<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function submitEmail(text, alerttext)
{
	var   strReg="";
	var   r;
	var str = text.value;
        if(str.length>0){
          strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
          r=str.search(strReg);
          if(r==-1)
          {
            alert(alerttext);
            text.focus();
            return false;
          }

          return true;
        }
        return true;
}
</script>
<title>找回密码</title>
</head>

<body>
<%--String Msg=request.getParameter("Msg");
if(Msg!=null&&Msg!="")
{
out.println(Msg);
}
else--%>

<h1>找回密码</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<DIV ID="edit_BodyDiv">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
<%if(teasession.getParameter("suc")==null){
  out.print("如果您的密码已丢失或遗忘，请在下方输入您的会员ID，BP将会把会员密码发送到您的邮箱中！");
}else{
  out.print("您的密码已成功发送至【"+teasession.getParameter("member")+"】,请注意查收！");
}%>
<br />
<FORM name=foRetrieve METHOD=POST action="/servlet/EditBPperson" onSubmit="return(submitText(foRetrieve.member,'无效-会员ID')
  &&submitEmail(foRetrieve.member,'会员ID必须为EMAIL'));">
  <input type="hidden" name="act" value="forgetpwd"/>
会员ID:
<input type="TEXT" class="edit_input"  name=member>
<input type="submit" class="edit_button" id="edit_submit"  value="提交" <%if(teasession.getParameter("suc")!=null)out.print("disabled");%>>
<input type="button" value="返回" onclick="window.location.href='/servlet/Node?node=2198284';"/>
</FORM>
<SCRIPT>document.foRetrieve.member.focus();</SCRIPT>

</td></tr></table>
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

