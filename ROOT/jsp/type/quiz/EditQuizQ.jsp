<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%



// new MultipartRequest(request);

            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            String s = teasession.getParameter("QuizQ");
            boolean flag = s == null;
			String s1 = "";
                String s3 = "";
                int i = 0;
                if(!flag)
                {
                    int j = Integer.parseInt(s);
                    QuizQ quizq = QuizQ.find(j);
                    s1 = quizq.getText(teasession._nLanguage);
                    s3 = quizq.getAlt(teasession._nLanguage);
                    i = quizq.getAlign(teasession._nLanguage);
                }
				%>


<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Quiz")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM name=foEdit METHOD=POST action="/servlet/EditQuizQ" ENCtype=multipart/form-data>
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<%           if(!flag)
              {%>    <input type='hidden' name=QuizQ VALUE="<%=s%>">
            <%}%>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <%=new PictureInput(teasession._nLanguage, "Picture", 0, s3, i)%>
            <tr><TD><%=r.getString(teasession._nLanguage, "Voice")%>:</TD>
              <td COLSPAN=6><input type="file" name="Voice" class="edit_input"/>
                <input  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null>
                <%=r.getString(teasession._nLanguage, "Clear")%><A HREF="/tea/html/0/recorder.html" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Record")%></A></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "File")%>:</TD>
              <td COLSPAN=6><input type="file" name="File" class="edit_input"/>
                <input  id="CHECKBOX" type="CHECKBOX" name=ClearFile value=null>
                <%=r.getString(teasession._nLanguage, "Clear")%></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <td><TEXTAREA name="Text" ROWS=6 COLS=60><%=HtmlElement.htmlToText(s1)%></TEXTAREA></td>
            </tr></table>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM>
		<div id="head6"><img height="6" src="about:blank"></div>
		<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>


<%----%>
</body>
</html>

