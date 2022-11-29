<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
int valid=obj.getInt("loginvalid");
String info=obj.get("logininfo");
if(info==null)
{
  info="您的用户正在等待管理员的审核,请耐心等待...";
}
String TYPE[]={"所有会员","审核会员","后台会员"};

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "会员登陆设置")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/loginvalid/logininfo/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"会员类型")%></td>
    <td>
    <%
    for(int i=0;i<TYPE.length;i++)
    {
      out.print("<input type='radio' name='loginvalid' value='"+i+"'");
      if(i==valid)
      out.print(" checked='true'");
      out.print(" id='lv"+i+"'><label for='lv"+i+"'>"+TYPE[i]+"</label>");
    }
    %>
    </td>
    <td>那类会员才能登陆系统</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"提示")%></td>
    <td><textarea name="logininfo" cols="50" rows="4"><%=info%></textarea></td>
    <td>没权限登陆时的提示信息.</td>
  </tr>
</table>


<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
