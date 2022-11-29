<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*" %>
<%@ page import="tea.entity.node.UserForm"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.member.*"%>
<% request.setCharacterEncoding("UTF-8");


TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}

Profile pobj = Profile.find(teasession._rv._strR);
String member = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
if(member==null)
{
	member = 	teasession._rv._strR;
}
 










%>
<%Vector myuser=(Vector)application.getAttribute("myuser");%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td height="32" align="center" class="word_orange ">欢迎来到网站聊天室</td></tr>
  <tr> 
  <td height="23" align="center"><a  href="javascript:set('所有人');" >所有人</a></td>
  </tr>   
 <%	for(int i=0;i<myuser.size();i++){
		UserForm mylist=(UserForm)myuser.elementAt(i);
	
		if(!member.equals(mylist.username) && !teasession._rv._strR.equals(mylist.username)){
		%>
  <tr>
    <td height="23" align="center"><a href="javascript:set('<%=mylist.username%>');" ><%=mylist.username%></a></td>
  </tr>
<%}}%>
<tr><td height="30" align="center">当前在线[<font color="#FF6600"><%=myuser.size()%></font>]人</td></tr>
</table>