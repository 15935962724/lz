<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %><%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getNull(String strNull)
{	return strNull==null?"":strNull;
}%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();TeaSession teasession = new TeaSession(request);
     Node   node=Node.find(teasession._nNode);
 r.add("/tea/ui/node/talkback/TalkbackServlet");
               long i = node.getOptions();
            boolean flag = (i & 0x8000) != 0;
            String  s = teasession.getParameter("Talkback");
            int id=0;
            int len=0;
            if(s!=null)
            {id=Integer.parseInt(s);
            java.io.File file=new java.io.File(getServletContext().getRealPath("/tea/image/talkback/" + s + ".jpg"));
            len=(int)file.length();
        }

        Talkback talkback=Talkback.find(id);

RV rv=        node.getCreator();
tea.entity.member.Profile profile=tea.entity.member.Profile.find(rv._strV);


		%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body><div id="edit_BodyDiv">
 <div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM NAME=foEdit METHOD=POST action="/servlet/EditTalkback" ENCTYPE=multipart/form-data onSubmit="return(submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="/jsp/talkback/CebbankTalkbacks.jsp?node=<%=teasession._nNode%>"/>
    <%if(s!=null){%>
    <input type="hidden" name="Talkback" value="<%=s%>">
<%        }%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%if(teasession._rv!=null){%>

<TR id="edittalikback1">
<TD><%=r.getString(teasession._nLanguage, "Creator")%>:</TD>
<TD><%=new String(teasession._rv.toString().getBytes("iso-8859-1"))%></TD></TR>

<INPUT  id=CHECKBOX type="hidden" NAME=MsgOSendEmail >
<%}%>
<TR id="edittalikback5"><TD><%=r.getString(teasession._nLanguage, "Hint")%>:</TD>
<TD>
<%
for(int i=0;i<12;i++)
{
  out.print("<input id='radio' type='radio' name='Hint' value='"+i+"' ");
  if(hint==i)out.print(" checked='true'");
  out.print("><img src='/tea/image/hint/"+i+".gif'>");
}
%></TD></TR>
<TR>
<TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
<TD>
<INPUT NAME=Subject TYPE=TEXT class="edit_input" VALUE="<%=getNull(talkback.getSubject(teasession._nLanguage))%>" SIZE=70 MAXLENGTH=255></TD></TR>
<TR id="edittalikback6">
<TD><%=r.getString(teasession._nLanguage,"Picture")%>:</TD>
<TD COLSPAN=6>
<INPUT NAME=Picture TYPE=FILE class="edit_input"><%if(len>0)out.print(len);%>
<INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearPicture VALUE=null><%=r.getString(teasession._nLanguage,"Clear")%></TD></TR>
<TR id="edittalikback7" >
<TD><%=r.getString(teasession._nLanguage,"Voice")%>:</TD>
<TD COLSPAN=6>
<INPUT NAME=Voice TYPE=FILE class="edit_input">
<INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearVoice VALUE=null><%=r.getString(teasession._nLanguage,"Clear")%>
  <A href="/tea/html/0/recorder.html" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Record")%></A></TD></TR>
<TR id="edittalikback8">
<TD><%=r.getString(teasession._nLanguage,"File")%>:</TD>
<TD COLSPAN=6>
<INPUT NAME=File TYPE=FILE class="edit_input">
<INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearFile VALUE=null><%=r.getString(teasession._nLanguage,"Clear")%></TD></TR>
<TR>
<TD><%=r.getString(teasession._nLanguage, "Content")%>:</TD>
<TD>
<TEXTAREA NAME=Content COLS=60 ROWS=8 class="edit_input"><%=HtmlElement.htmlToText(talkback.getContent(teasession._nLanguage))%></TEXTAREA></TD></TR></TABLE>
<INPUT TYPE=SUBMIT class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
 <div id="head6"><img height="6" src="about:blank"></div>
<SCRIPT >document.foEdit.Subject.focus();</SCRIPT>

  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV>
</body>
</html>

