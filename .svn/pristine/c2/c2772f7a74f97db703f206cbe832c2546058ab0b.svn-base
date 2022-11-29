<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
  int i = Integer.parseInt(teasession.getParameter("QuizQ"));
            QuizQ quizq = QuizQ.find(i);
            Node node = Node.find(quizq.getNode());
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            String s = teasession.getParameter("QuizA");
            boolean flag = s == null;
                int j = 0;
                String s1 = "";
                String s3 = "";
                int l = 0;
                if(!flag)
                {
                    int i1 = Integer.parseInt(s);
                    QuizA quiza = QuizA.find(i1);
                    j = quiza.getScore();
                    s1 = quiza.getText(teasession._nLanguage);
                    s3 = quiza.getAlt(teasession._nLanguage);
                    l = quiza.getAlign(teasession._nLanguage);
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
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>


		<FORM name=foEdit METHOD=POST action="/servlet/EditQuizA" ENCtype=multipart/form-data onSubmit="return(submitInteger(this.Score,'<%=r.getString(teasession._nLanguage, "InvalidScore")%>'))">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <input type='hidden' name=QuizQ VALUE="<%=i%>">
            <%   if(!flag)
                 {%>   <input type='hidden' name=QuizA VALUE="<%=s%>">
               <%}%>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr><TD><%=r.getString(teasession._nLanguage, "Score")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Score VALUE="<%=j%>"></td>
            </tr><%=new PictureInput(teasession._nLanguage, "Picture", 0, s3, l)%>
            <tr><TD><%=r.getString(teasession._nLanguage, "Voice")%>:</TD>
              <td COLSPAN=6><input type="file" name="Voice" class="edit_input"/>
                <input  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null>
                <%=r.getString(teasession._nLanguage, "Clear")%><A HREF=/tea/html/0/recorder.html TARGET=_blank><%=r.getString(teasession._nLanguage, "Record")%></A></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "File")%>:</TD>
              <td COLSPAN=6><input type="file" name="File" class="edit_input"/>
                <input  id="CHECKBOX" type="CHECKBOX" name=ClearFile value=null>
                <%=r.getString(teasession._nLanguage, "Clear")%></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <td><TEXTAREA name="text" ROWS=6 COLS=60><%=HtmlElement.htmlToText(s1)%></TEXTAREA></td>
            </tr></table>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM>
		<div id="head6"><img height="6" src="about:blank"></div>
              <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>


<%----%>
</body>
</html>

