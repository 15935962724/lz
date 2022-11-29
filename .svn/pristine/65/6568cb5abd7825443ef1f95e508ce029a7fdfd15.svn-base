<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/node/type/quiz/AnswerQuiz");

            int i = 0;
            String as[] = request.getParameterValues("QuizQ");
            if(as != null)
            {
                for(int j = 0; j < as.length; j++)
                    try
                    {
                        i += Integer.parseInt(request.getParameter(as[j]));
                    }
                    catch(Exception _ex) { }

            }
            int k = 0;
            QuizR quizr = null;
            for(Enumeration enumeration = QuizR.findByNode(teasession._nNode); enumeration.hasMoreElements();)
            {
                k = ((Integer)enumeration.nextElement()).intValue();
                quizr = QuizR.find(k);
                if(i > quizr.getFloorScore() && i <= quizr.getCeilScore())
                    break;
            }


  %>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Quiz")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

            <%=node.getAncestor(teasession._nLanguage)%>
<%           if(quizr != null)
           {
                if(quizr.getPictureFlag())
                    out.print(new Image("/servlet/QuizRPicture?node=" + teasession._nNode + "&QuizR=" + k, quizr.getAlt(teasession._nLanguage), quizr.getAlign(teasession._nLanguage)));
                out.print(quizr.getText(teasession._nLanguage));
                if(quizr.getVoiceFlag())
                {%>
                 <input type=button onclick="window.open('/servlet/QuizRVoice?node=<%=teasession._nNode%>&QuizR=<%=k%>','_self')" value="<%=r.getString(teasession._nLanguage, "Play")%>">
<%              }
                if(quizr.getFileFlag())
                {%>    <input type=button onclick="window.open('/servlet/QuizRFile?node=<%=teasession._nNode%>&QuizR=<%=k%>','_self')" value="<%=r.getString(teasession._nLanguage, "Download")%>">
              <%}
            }
            long l = node.getOptions();
            if((l & 0x8000) != 0)
            {%>
            <input type=button onclick="window.open('/servlet/Talkbacks?node=<%=teasession._nNode%>','_self')" value="<%=r.getString(teasession._nLanguage, "Talkbacks")%>">

          <%}
            if((l & 0x10000) != 0)
            {%>
              <input type="button" onclick="window.open('/servlet/ChatFrameSet?node=<%=teasession._nNode%>')" value="<%=r.getString(teasession._nLanguage, "ChatRoom")%>">

          <%}%>
<%=new Languages(teasession._nLanguage, request)%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

