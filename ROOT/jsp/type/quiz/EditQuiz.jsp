<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>



<%int i;

            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            r.add("/tea/ui/node/type/quiz/EditQuiz");
			%>


<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Quiz")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%              for(java.util.Enumeration enumeration =tea.entity.node.QuizQ.findByNode(teasession._nNode); enumeration.hasMoreElements(); )
                {
                  i = ((Integer)enumeration.nextElement()).intValue();
                  tea.entity.node.QuizQ quizq = tea.entity.node.QuizQ.find(i);%>
		<tr><td><%=quizq.getText(teasession._nLanguage)%>
                   <A href="/servlet/EditQuizQ?node=<%=teasession._nNode%>&QuizQ=<%=i%>"><%=r.getString(teasession._nLanguage, "Edit")%></A>
<%                  if(quizq.isLayerExisted(teasession._nLanguage))
                    {%>    <A href="/servlet/DeleteQuizQ?node=<%=teasession._nNode%>&QuizQ=<%=i%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));"><%=r.getString(teasession._nLanguage, "Delete")%></A>
                  <%}%>
</td></tr>
                  <tr><td><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%                  for(java.util.Enumeration enumeration2 =tea.entity.node.QuizA.findByQuizQ(i); enumeration2.hasMoreElements(); )
                    {
                        int k = ((Integer)enumeration2.nextElement()).intValue();
                        tea.entity.node.QuizA quiza = tea.entity.node.QuizA.find(k);%>
                        <tr><td><%=quiza.getText(teasession._nLanguage)%></td>
                        <td><%=Integer.toString(quiza.getScore())%></td>
			<TD><A href="/servlet/EditQuizA?node=<%=teasession._nNode%>&QuizQ=<%=i%>&QuizA=<%=k%>"><%=r.getString(teasession._nLanguage, "Edit")%></A></td>
<%                      if(quiza.isLayerExisted(teasession._nLanguage))
						{%><td>  <A href="/servlet/DeleteQuizA?node=<%=teasession._nNode%>&QuizQ=<%=i%>&QuizA=<%=k%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));"><%=r.getString(teasession._nLanguage, "Delete")%></A></td>
<%						}%>
<%}
%></table></td></tr>
     <!--input type=button class="edit_button" onClick="window.open('/servlet/EditQuizA?node=<%=teasession._nNode%>&QuizQ=<%=i%>','_self')" value="<%=r.getString(teasession._nLanguage, "NewExamKey")%>"--><tr><td>
<%}%>
</table>




<input type=button class="edit_button" onClick="window.open('/servlet/EditQuizQ?node=<%=teasession._nNode%>','_self')" value="<%=r.getString(teasession._nLanguage, "NewQuizQ")%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=TableHeader>
<TD><%=r.getString(teasession._nLanguage, "FloorScore")%> </TD>
<TD><%=r.getString(teasession._nLanguage, "CeilScore")%> </TD>
<TD><%=r.getString(teasession._nLanguage, "Result")%></TD></tr>
<%              for(java.util.Enumeration enumeration1 = tea.entity.node.QuizR.findByNode(teasession._nNode); enumeration1.hasMoreElements();)
                {
                    int j = ((Integer)enumeration1.nextElement()).intValue();
                   tea.entity.node.QuizR quizr = tea.entity.node.QuizR.find(j);%>
<tr><td><%=Integer.toString(quizr.getFloorScore())%></td>
<td><%=Integer.toString(quizr.getCeilScore())%></td>
<td><%=quizr.getText(teasession._nLanguage)%></td>
<td><A href="/servlet/EditQuizR?node=<%=teasession._nNode%>&QuizR=<%=j%>"><%=r.getString(teasession._nLanguage, "Edit")%></A> </td>
<%if(quizr.isLayerExisted(teasession._nLanguage))
{%>  <td><A href="/servlet/DeleteQuizR?node=<%=teasession._nNode%>&QuizR=<%=j%>" onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));"><%=r.getString(teasession._nLanguage, "Delete")%></A> </td><%}
 }%>
</table>

<input type=button class="edit_button" onClick="window.open('/servlet/EditQuizR?node=<%=teasession._nNode%>','_self')" value="<%=r.getString(teasession._nLanguage, "NewQuizR")%>">

<FORM name=foEdit METHOD=POST action="/servlet/EditQuiz">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <P ALIGN=CENTER>
            <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
          </P>
</td></tr></table>
</FORM>
        
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

