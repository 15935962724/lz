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

String member=teasession._rv._strV;
ProfilePostulant pp=ProfilePostulant.find(member,teasession._strCommunity);

if(!pp.isExists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("对不起,你还不是志愿者.积分只对志愿者开放.","UTF-8"));
  return;
}
if(!pp.isAuditing())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("对不起,管理员还没有批准你加入志愿者团队.","UTF-8"));
  return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1>积分</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 METHOD=POST ACTION="/servlet/EditProfilePostulant" onSubmit="return f_submit(this);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
<input type="hidden" name="act" value=""/>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>积分:</td>
      <td><%=pp.getPoint()%></td>
    </tr>
    <tr><td>注:积分好处XXXXXXXXXXXXXXXX</td></tr>
    <tr><td>注:积分规则XXXXXXXXXXXXXXXX</td></tr>
</table>
</FORM>
<br>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>



