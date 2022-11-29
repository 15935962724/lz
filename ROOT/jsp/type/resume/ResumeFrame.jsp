<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.ui.*" %><%


TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}

String community=request.getParameter("community");

%>
<script type="">
function fchangetitle()
{
  window.document.title=window.m.document.title;
}
window.setInterval("fchangetitle();",1000);
</script>
<html>
<frameset id="frame" rows="80,*"  frameborder="NO" border="0" framespacing="0">
    <frame name="ResumeLeft" src="ResumeLeft.jsp?" style="border-right: 1 solid #666666">
    <frame name="ResumeRight" src="leftup2.jsp?node=<%=teasession._nNode%>&community=<%=community%>" style="border-right: 1 solid #666666">
</frameset>
</html>

