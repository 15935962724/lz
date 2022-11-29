<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(!teasession._rv.isReal())
{
  response.sendError(403);
  return;
}


Resource r=new Resource("/tea/ui/member/profile/ProfileServlet");


Home home = Home.find(teasession._strCommunity,teasession._rv._strR);

String picture=home.getPicture(teasession._nLanguage);

long picture_len=0;
if(picture!=null)
{
  picture_len=new java.io.File (  application.getRealPath(picture)).length();
}

String voice=home.getVoice(teasession._nLanguage);
long voice_len=0;
if(voice!=null)
{
  voice_len=new java.io.File (  application.getRealPath(voice)).length();
}
//String filename=home.getFileName(teasession._nLanguage);
String filename=home.getFileName(teasession._nLanguage) == null?"":home.getFileName(teasession._nLanguage);
String file=home.getFile(teasession._nLanguage);
long file_len=0;
if(file!=null)
{
  file_len=new java.io.File (  application.getRealPath(file)).length();
}

String content=home.getContent(teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditHome")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditHome" ENCtype=multipart/form-data>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr><TD><%=r.getString(teasession._nLanguage, "Picture")%>:</TD>
<td COLSPAN=6>
<input type="file" name="Picture" ondblclick="window.open('<%=picture%>');"  class="edit_input"/><%if(picture_len>0)out.print(picture_len+r.getString(teasession._nLanguage, "Bytes"));%>
<input  id="CHECKBOX" type="CHECKBOX" name=ClearPicturevalue onclick="foEdit.Picture.disabled=this.checked"><%=r.getString(teasession._nLanguage, "Clear")%></td></tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Voice")%>:</TD>
<td COLSPAN=6>
<input type="file" name="Voice"  ondblclick="window.open('<%=voice%>');" class="edit_input"/><%if(voice_len>0)out.print(voice_len+r.getString(teasession._nLanguage, "Bytes"));%>
<input  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null onclick="foEdit.Voice.disabled=this.checked"><%=r.getString(teasession._nLanguage, "Clear")%>
<A HREF="/tea/html/0/recorder.html" TARGET=_blank><%=r.getString(teasession._nLanguage, "Record")%></A></td></tr>

<tr><TD><%=r.getString(teasession._nLanguage, "File")%>:</TD>
<td COLSPAN=6>
<input type="file" name="File"  ondblclick="<%if(file_len>0)out.print("window.open('/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(file,"UTF-8")+"&name="+java.net.URLEncoder.encode(filename,"UTF-8")+"','_self');");%>" class="edit_input"/><%if(file_len>0)out.print(file_len+r.getString(teasession._nLanguage, "Bytes"));%>
<input  id="CHECKBOX" type="CHECKBOX" name=ClearFile value=null onclick="foEdit.File.disabled=this.checked"><%=r.getString(teasession._nLanguage, "Clear")%></td></tr>

<tr><TD><%=r.getString(teasession._nLanguage, "Content")%>:</TD>
<td>
<TEXTAREA name=Content ROWS=8 COLS=60><%if(content!=null)out.print(tea.html.HtmlElement.htmlToText(content));%></TEXTAREA></td></tr>
<tr><td></td><td>
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td></tr></table></FORM>

<SCRIPT>document.foEdit.Content.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

