<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.util.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

Resource r=new Resource("/tea/resource/DNS");

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

%><html>
<head>
<link href="/tea/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "Template")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/servlet/EditExample" method="post">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="act" value="use"/>
<input type="hidden" name="example"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td width="1">&nbsp;</td>
    <td>名称</td>
    <td></td>
  </tr>
  <%
  Enumeration ee= Example.find("",pos,25);
  for(int i=1;ee.hasMoreElements();i++)
  {
    Example e=(Example)ee.nextElement();
    int id=e.getExample();
    String exids=e.getExid();
    String subject=e.getSubject();
    String picture=e.getPicture();
    out.print("<img src=\""+picture+"\" id='img"+id+"' style='visibility:hidden;position:absolute;filter:revealtrans(duration=0.5);' />");
    out.print("<tr onMouseOver=\"bgColor='#BCD1E9'\" onMouseOut=\"bgColor=''\">");
    out.print("<td>"+i);
    out.print("<td onmouseover=showSnap(event,img"+id+") onMouseOut=showSnap(event,img"+id+")>"+subject);
    out.print("<td><input type='button' value='"+r.getString(teasession._nLanguage, "添加")+"' onclick=\"form1.example.value="+id+"; form1.submit();\" />");
  }
  %>
</table>

</form>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.open('/servlet/Node?node=<%=teasession._nNode%>', '_self');" />

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
