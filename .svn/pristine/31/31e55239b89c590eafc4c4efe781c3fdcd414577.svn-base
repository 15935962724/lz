<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
Node node=Node.find(teasession._nNode);

if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(73))
  {
    response.sendError(403);
    return;
  }
}

boolean _bNew=teasession.getParameter("NewNode")!=null;
String subject="",text="";
if(!_bNew)
{
  subject=node.getSubject(teasession._nLanguage);
  text=node.getText(teasession._nLanguage);
}

Resource r = new Resource("/tea/resource/BulletinBoard");

String nexturl=teasession.getParameter("nexturl");

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="form1.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "BulletinBoard")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<br>

<FORM NAME="form1" METHOD=POST action="/servlet/EditBulletinBoard"  onSubmit="return(submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<INPUT TYPE=HIDDEN NAME="node" VALUE="<%=teasession._nNode%>">
<INPUT TYPE=HIDDEN NAME="nexturl" VALUE="<%=nexturl%>">
<%if(_bNew)out.print("<INPUT TYPE=HIDDEN NAME=NewNode VALUE=on>");%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
    <TD><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="<%=subject%>" SIZE=70 MAXLENGTH=255></TD>
  </TR>
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
    <TD>
      <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=text%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
    </TD>
  </TR>
</TABLE>
<INPUT TYPE="SUBMIT" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
<INPUT TYPE="button" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBBack")%>">
</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%> </DIV>
</body>
</html>
