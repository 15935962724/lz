<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);
Node node=Node.find(teasession._nNode);


if (teasession._rv == null && (node.getOptions() & 0x8000) == 0 )
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if((node.getOptions()&0x2000)!=0&&Talkback.isPer(teasession._nNode,teasession._rv))
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "NodeOPerTB"),"UTF-8"));
  return;
}
r.add("/tea/ui/node/talkback/TalkbackServlet");

boolean flag = (node.getOptions() & 0x8000) != 0;

int id=0;
String tmp=teasession.getParameter("talkback");
if(tmp!=null)
{
  id=Integer.parseInt(tmp);
}
String nexturl=request.getParameter("nexturl");

int hint=0;
String subject="",content="";
String picture,voice,file;
int plen=0,vlen=0,flen=0;
if(id>0)
{
  Talkback obj=Talkback.find(id);
  hint=obj.getHint();
  subject=obj.getSubject(teasession._nLanguage);
  content=HtmlElement.htmlToText(obj.getContent(teasession._nLanguage));

  picture=obj.getPicture(teasession._nLanguage);
  voice=obj.getVoice(teasession._nLanguage);
  file=obj.getFile(teasession._nLanguage);
  if(picture!=null)plen=(int)new File(application.getRealPath(picture)).length();//"/res/"+teasession._strCommunity+"/talkback/" + id + ".gif"
  if(voice!=null)vlen=(int)new File(application.getRealPath(voice)).length();//"/res/"+teasession._strCommunity+"/talkback/" + id + ".wav"
  if(file!=null)flen=(int)new File(application.getRealPath(file)).length();//"/res/"+teasession._strCommunity+"/talkback/" + id + ".doc"
}

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body onload="form1.subject.focus();">

<DIV id="edittalkback">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM NAME="form1" METHOD=POST action="/servlet/EditTalkback" ENCTYPE=multipart/form-data onSubmit="return(submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&(this.submit.disabled=true));">
<INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="talkback" value="<%=id%>">
<%
if(nexturl!=null)
{
  out.print("<input type='hidden' name='talkback' value='"+nexturl+"'>");
}
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="edittalikback5"><TH><%=r.getString(teasession._nLanguage, "Hint")%>:</TH>
<td>
<%
for(int i=0;i<12;i++)
{
  out.print("<input id=radio type=radio name=hint value="+i);
  if(hint==i)
  {
    out.print(" checked ");
  }
  out.print("><img src=/tea/image/hint/"+i+".gif>");
}
%></td>
</tr>
<tr>
  <TH><%=r.getString(teasession._nLanguage, "Subject")%>:</TH>
  <td><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="<%=subject%>" SIZE=70 MAXLENGTH=255></td>
</tr>
<tr>
  <TH><%=r.getString(teasession._nLanguage, "Content")%>:</TH>
  <td><TEXTAREA NAME="content" COLS=60 ROWS=8 class="edit_input"><%=content%></TEXTAREA></td>
</tr>
</TABLE>

<INPUT TYPE=SUBMIT name="submit" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
<INPUT TYPE=button class="edit_button" onClick="window.history.back();" VALUE="<%=r.getString(teasession._nLanguage, "CBBack")%>">
</FORM>


<div id="head6"><img height="6" src="about:blank"></div></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
