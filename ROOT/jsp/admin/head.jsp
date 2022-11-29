<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %>
<%
String url=request.getParameter("url");
TeaSession teasession=new TeaSession(request);

tea.resource.Resource r=new tea.resource.Resource();
r.add("/tea/resource/fun");
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
if (top.location == self.location)
{
  top.location="/jsp/admin/Frame.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
}

var f=parent.document.getElementById("frame");
function fclick()
{
  var value=getCookie('admin_head_hide');
  if(value=='true')
  {
    f.rows='80,*';
    img.src="/tea/image/public/ico_min.gif";
  }else
  {
    f.rows='10,*';
    img.src="/tea/image/public/ico_max.gif";
  }
  setCookie('admin_head_hide',value!='true');
  size_button.focus();
}

function fload()
{
  var value=getCookie('admin_head_hide');
  if(value=='true')
  {
    f.rows='10,*';
    img.src="/tea/image/public/ico_max.gif";
  }else
  {
    f.rows='80,*';
    img.src="/tea/image/public/ico_min.gif";
  }
  size_button.focus();
}
</script>
</head>
<body bgcolor="ffffff" text="000000" link="#CB9966" leftmargin="0" topmargin="0" onLoad="fload();">
<table width="100%" height="67" border="0" cellpadding="0" cellspacing="0">
  <tr >
  <td height="72" class="tou" valign="bottom"><div align="right"><A href="<%=url%>" id="ToDesktop" target="m" ><%=r.getString(teasession._nLanguage,"ToDesktop")%></A> <A id="ToProspects" href="/servlet/Node?node=<%=tea.entity.site.Community.find(teasession._strCommunity).getNode()%>" target="_blank" ><%=r.getString(teasession._nLanguage,"ToProspects")%></A></div></td>
  </tr>
  <tr>
    <td  valign="bottom" align="center"><A href="javascript:;" name="size_button" onClick="fclick();"><img  name="img" style=" cursor:hand " src="/tea/image/public/ico_min.gif"  ></A></td>
  </tr>
</table>
<%--
if (teasession._nCount == 1 && tea.ui.member.notification.NotificationServlet.isNotifying(teasession._rv))
{
  out.print("<SCRIPT language=JavaScript FOR=window EVENT=onload>");
  out.print("window.screenX = screen.width; window.screenY = screen.height;");
  out.print("window.open(\"/servlet/Notification\",\"Notification\", \"height=250,width=250,left=600,top=400,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes\");");
  out.print("</SCRIPT>");
}
<APPLET CODEBASE="/tea/applet/" CODE="tea.applet.meeting.CheckIn.class" WIDTH="0" HEIGHT="0" style="display:none"></APPLET>
--%>
</body>
</html>
