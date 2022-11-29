<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
boolean boll=request.getParameter("jobmailmsg")!=null;
String community=request.getParameter("community");
tea.entity.member.Profile profile=tea.entity.member.Profile.find(teasession._rv._strR,community);
profile.setJobMailMsg(boll);
String nexturl=request.getParameter("nexturl");
response.sendRedirect(nexturl);
%>

