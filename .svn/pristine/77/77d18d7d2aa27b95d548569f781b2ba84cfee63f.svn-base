<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

String s = request.getParameter("Community");
if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/community/Organizers");


%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NewOrganizers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

    <FORM name=foNew METHOD=POST action="/servlet/NewOrganizers" onSubmit="return(submitText(this.Members,'<%=r.getString(teasession._nLanguage, "InvalidMemberIds")%>')&&(this.submit.disabled=true));">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <input type="hidden" class="edit_input"  name=community value="<%=s%>">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "MemberId")%>:<input type="TEXT" class="edit_input"  name="Members" >
      </tr>
      <tr>
        <td align="center">
          <input type="submit" name="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </td>
      </tr>
  </table>
      </FORM>
      
<SCRIPT>document.foNew.Members.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


