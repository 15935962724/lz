<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String s =request.getParameter("Member");
if(s == null)
                if(teasession._rv != null)
                {
                    s = teasession._rv._strR;
                } else
                {response.sendRedirect("/servlet/StartLogin");
return;
}r.add("/tea/ui/member/feedback/Feedbacks").add("/tea/ui/member/feedback/FeedbackServlet");
            int i = Integer.parseInt(request.getParameter("Feedback"));
            Feedback feedback = Feedback.find(i);
            if(!s.equals(feedback.getMember()))
            {
                response.sendError(403);
                return;
            }
            RV rv = feedback.getRV();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body> 
<h1><%=r.getString(teasession._nLanguage, "Feedbacks")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster"> 
<input type='hidden' name=vmember VALUE="webmaster"> 
<div id="PathDiv"><%//=ts.hrefGlance(s) %> ><A href="/servlet/Feedbacks"><%=r.getString(teasession._nLanguage, "Feedbacks")%></A><%=new HintImg( feedback.getHint()) + feedback.getSubject(teasession._nLanguage)%></div> 
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter"> 
  <tr> 
    <td><%=r.getString(teasession._nLanguage, "Poster")%>:</td> 
    <td><%=ts.hrefGlance(rv)%> </td> 
  </tr> 
  <tr> 
    <td><%=r.getString(teasession._nLanguage, "Time")%>:</td> 
    <td><%=(new SimpleDateFormat("MM.dd HH:mm")).format(feedback.getTime())%></td> 
  </tr> 
  <tr> 
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td> 
    <td><%=new HintImg( feedback.getHint()) + feedback.getSubject(teasession._nLanguage)%> </td> 
  </tr> 
  <tr> 
    <td><%=r.getString(teasession._nLanguage, "Content")%>:</td> 
    <td><%=feedback.getContent(teasession._nLanguage)%></td> 
  </tr> 
</table> 
<%
String picture=feedback.getPicture(teasession._nLanguage);
            if(picture!=null&&picture.length()>0)
			{%> 
<%=new Image(picture)%> 
<%			}
            String voice=feedback.getVoice(teasession._nLanguage);
            if(voice!=null&&voice.length()>0)
{%> 
<input type="button" onclick="<%=voice%>" value="<%=r.getString(teasession._nLanguage, "Play")%>"/> 
out.print(new Anchor("/servlet/FeedbackVoice?Member=" + s + "&Feedback=" + i, r.getCommandImg(teasession._nLanguage, "Play")));
<%}
            String file=feedback.getFileData(teasession._nLanguage);
            if(file!=null&&file.length()>0)
            {%> 
<input type="button" onclick="window.open('<%=file%>')" value="<%=r.getString(teasession._nLanguage, "Download")%>"/> 
<%}if(teasession._rv != null && (teasession._rv.equals(rv) || teasession._rv.isWebMaster()))
			{%> 
<input type=button onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/DeleteFeedback?Member=<%=s%>&Feedback=<%=i%>','_self') ;"  value="<%=r.getString(teasession._nLanguage, "Delete")%>"/> 
<%}%> 
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div> 
<%----%> 
</body>
</html>

