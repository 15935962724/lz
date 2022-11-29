<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.member.*" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

String subject=r.getString(teasession._nLanguage,"1170218830203")+"("+tea.entity.admin.Worktel.sdf.format(new java.util.Date())+")";

/*
StringBuffer sb=new StringBuffer();

String worklogs[]=request.getParameterValues("worklog");
if(worklogs!=null)
{
  sb.append("<link href=\"http://").append(request.getServerName()).append("/tea/CssJs/").append(community).append(".css\" rel=\"stylesheet\" type=\"text/css\">");
  sb.append("<table border=1 cellpadding=0 cellspacing=0 id=tablecenter>");
  sb.append("<tr id=tableonetr><td></td><th nowrap>").append(r.getString(teasession._nLanguage,"Time")).append("</th>");
  sb.append("<TH noWrap>").append(r.getString(teasession._nLanguage,"1168584443703")).append("</th>");
  sb.append("<TH noWrap>").append(r.getString(teasession._nLanguage,"1168584403266")).append("</th>");
  sb.append("<TH noWrap>").append(r.getString(teasession._nLanguage,"1168592903313")).append("</th>");
  sb.append("<TH noWrap>").append(r.getString(teasession._nLanguage,"1168595223953")).append("</th>");
  sb.append("<TH noWrap>").append(r.getString(teasession._nLanguage,"Text")).append("</th></tr>");

  for(int i=0;i<worklogs.length;i++)
  {
    Worklog obj=Worklog.find(Integer.parseInt(worklogs[i]));
    sb.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\">");
    sb.append("<td width=1 >").append(i+1).append("</td>");
    sb.append("<td>&nbsp;").append(obj.getTimeToString()).append("</td>");

    sb.append("<td>&nbsp;");
    if(obj.getWorkproject()>0)
    sb.append(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));
    sb.append("</td>");

    sb.append("<td>&nbsp;");
    if(obj.getWorklinkman()!=null)
    sb.append(obj.getWorklinkman());
    sb.append("</td>");

    sb.append("<td>&nbsp;");
    if(obj.getWorktype()>0)
    sb.append(Worktype.find(obj.getWorktype()).getName(teasession._nLanguage));
    sb.append("</td>");
    sb.append("<td>&nbsp;").append(obj.isPublicity()?"√":"X").append("</td>");

    sb.append("<td>&nbsp;").append(obj.getContent(teasession._nLanguage).replaceAll("\r\n","<br/>")).append("</td>");
  }
  sb.append("</table>");
}
*/

StringBuffer inbox=new StringBuffer();
/*
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
java.util.Enumeration e=AdminUsrRole.find(teasession._strCommunity," AND( classes=2 OR ( classes=1 AND unit="+aur.getUnit()+" ))",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  String member=(String) e.nextElement();
  Profile p=Profile.find(member,teasession._strCommunity);
  String email=p.getEmail(teasession._nLanguage);
  if(email!=null&&email.length()>0)
  {
    inbox.append(email).append(";");
  }
}
*/

String url="http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/admin/workreport/Worktels_4.jsp;jsessionid="+session.getId()+"?"+request.getQueryString();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fsubmit()
{
  if(submitText(form1.inbox,'<%=r.getString(teasession._nLanguage,"1168840467531")%>')&&submitText(form1.subject,'<%=r.getString(teasession._nLanguage,"Subject")%>'))
  {
   // et.save();
    return true;
  }
  return false;
}
</script>
</head>
<body onLoad="form1.inbox.focus();">
<!--发送邮件-->
<h1><%=r.getString(teasession._nLanguage,"1168829505147")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

   <form name="form1" METHOD="post" action="/servlet/EditWorkreport" onSubmit="return fsubmit();">
     <input type=hidden name="community" value="<%=community%>"/>
     <input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
     <input type=hidden name="action" value="sendworktel"/>


   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td><%=r.getString(teasession._nLanguage,"1168840467531")%><!--=收件箱--></td><td><input name="inbox" size="60" value="<%=inbox.toString()%>"></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"Subject")%></td><td><input name="subject" size="60" value="<%=subject%>"></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"Text")%></td><td><input type="hidden" name="url" value="<%=url%>"/><iframe width="600" height="400" src="<%=url%>"></iframe></td></tr>
   </table>
   <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"  onclick="">
   <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();" >
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



