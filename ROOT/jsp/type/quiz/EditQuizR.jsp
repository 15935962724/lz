<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
//new MultipartRequest(request);

            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            String s = teasession.getParameter("QuizR");
            boolean flag = s == null;
			 int i = 0;
                int k = 0;
                String s1 = "";
                String s3 = "";
                int i1 = 0;
                if(!flag)
                {
                    int j1 = Integer.parseInt(s);
                    QuizR quizr = QuizR.find(j1);
                    i = quizr.getFloorScore();
                    k = quizr.getCeilScore();
                    s1 = quizr.getText(teasession._nLanguage);
                    s3 = quizr.getAlt(teasession._nLanguage);
                    i1 = quizr.getAlign(teasession._nLanguage);
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
		<FORM name=foEdit METHOD=POST action="/servlet/EditQuizR" ENCtype=multipart/form-data onSubmit="return(submitInteger(this.FloorScore,'<%=r.getString(teasession._nLanguage, "InvalidFloorScore")%>')&&submitInteger(this.CeilScore,'<%=r.getString(teasession._nLanguage, "InvalidCeilScore")%>'))">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<%        if(!flag)
          {%>                  <input type='hidden' name=QuizR VALUE="<%=s%>">
  		<%}%>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr><TD><%=r.getString(teasession._nLanguage, "FloorScore")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=FloorScore VALUE="<%=i%>"></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "CeilScore")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=CeilScore VALUE="<%=k%>"></td>
            </tr><%=new PictureInput(teasession._nLanguage, "Picture", 0, s3, i1)%>
            <tr><TD><%=r.getString(teasession._nLanguage, "Voice")%>:</TD>
              <td COLSPAN=6><input type="file" name="Voice" class="edit_input"/>
                <input  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null>
                <%=r.getString(teasession._nLanguage, "Clear")%><A HREF="/tea/html/0/recorder.html" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Record")%></A></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "File")%>:</TD>
              <td COLSPAN=6><input type="file" name="File" class="edit_input"/>
                <input  id="CHECKBOX" type="CHECKBOX" name=ClearFile value=null>
                <%=r.getString(teasession._nLanguage, "Clear")%></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
              <td><TEXTAREA name="Text" ROWS=6  class="edit_input" COLS=60><%=HtmlElement.htmlToText(s1)%></TEXTAREA></td>
            </tr></table>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM>
<div id="head6"><img height="6" src="about:blank"></div>		
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
<%----%>
</body>
</html>

