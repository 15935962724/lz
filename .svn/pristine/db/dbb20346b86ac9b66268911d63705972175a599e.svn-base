<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl = teasession.getParameter("nexturl");
String member = teasession.getParameter("member");

int profile=0;
String password=null,firstname=null,lastname=null,email=null;
if(member!=null)
{
  Profile p=Profile.find(member);
  password=p.getPassword();
  firstname=p.getFirstName(teasession._nLanguage);
  lastname=p.getLastName(teasession._nLanguage);
  email=p.getEmail();
  profile=p.getProfile();
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function fload()
{
  try
  {
    form1.member.focus();
  }catch(e)
  {}
}
</script>
</head>
<body onload="fload();">

<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditAgent" method="post" onsubmit="return submitText(this.member,'<%=r.getString(teasession._nLanguage,"InvalidMemberId")%>')&&submitText(this.password,'<%=r.getString(teasession._nLanguage,"InvalidPassword")%>')&&submitText(this.lastname,'<%=r.getString(teasession._nLanguage,"InvalidLastName")%>')&&submitText(this.firstname,'<%=r.getString(teasession._nLanguage,"InvalidFirstName")%>')&&submitEmail(this.email,'<%=r.getString(teasession._nLanguage,"InvalidEmail")%>');">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="profile" value="<%=profile%>"/>
<input type="hidden" name="action" value="editagentmember"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员ID</td>
    <td>
    <%
    if(member!=null)
    {
      out.print(member+"<input type=hidden name=member value="+member+" >");
    }else
    {
      out.print("<input type=text name=member >");
    }
    %></td>
  </tr>
  <tr>
    <td>密码</td>
    <td><input name="password" type="password" value="" ></td>
  </tr>
  <tr>
    <td>姓</td>
    <td><input name="lastname" type="text" size="6" value="<%if(lastname!=null)out.print(lastname);%>" >
      名<input name="firstname" type="text" size="15" value="<%if(firstname!=null)out.print(firstname);%>" ></td>
  </tr>
    <tr>
      <td>Email</td>
      <td><input name="email" type="text" value="<%if(email!=null)out.print(email);%>"  ></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" value="提交">
      <input type="reset" value="重置">
      <input type="button" value="返回" onClick="history.back();"></td>
  </tr>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>



