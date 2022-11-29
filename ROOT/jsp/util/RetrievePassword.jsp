<%@page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.member.Message"%>
<%@ page import="tea.entity.member.Profile"%>
<%@ page import="tea.entity.site.License"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.service.Robot"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.http.RequestHelper"%>


<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();

TeaSession teasession = new TeaSession(request);
r.add("/tea/resource/Photography");
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);


%>
 


<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body ID="forgetpw">
<script>
	function f_submt()
	{
		if(foRetrieve.member.value=='')
			{
				alert('<%=r.getString(teasession._nLanguage, "2969876073")%><%=r.getString(teasession._nLanguage, "9967733288")%>');
				return false;
			}
	}
</script>
<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<h1><%=r.getString(teasession._nLanguage, "3613776778")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<DIV ID="edit_BodyDiv">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>
<%=r.getString(teasession._nLanguage, "2973327234")%>
<FORM name=foRetrieve METHOD=POST action="/servlet/RetrievePassword" onSubmit="return f_submt();");">
<input type="hidden" name="node" value="<%=teasession._nNode%>" />
<%=r.getString(teasession._nLanguage, "2969876073")%>:
<input type="TEXT" class="edit_input"  name="member">
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<SCRIPT>document.foRetrieve.member.focus();</SCRIPT>
<P><%=r.getString(teasession._nLanguage,"2900584323") %> <A href=mailto:<%=community.getEmail()%>><%=r.getString(teasession._nLanguage,"5620926498") %></A>&nbsp;
   <%=r.getString(teasession._nLanguage,"6964582914") %>&nbsp;<a href="#" onClick="javascript:window.close();"><%=r.getString(teasession._nLanguage,"365139969") %></a></P>
</td>
</tr>
</table>

</DIV>


</body>
<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>

<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>
</html>

