<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.RV"%>
<%@ page import="tea.entity.member.Profile"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaSession"%>
<jsp:useBean id="sendsms" scope="page" class="com.SMS" />


<%!private String getCheck(boolean i)  {
      if (i)
      {
		return "checked";
      }
	  else
	  { return "";}
       }%>

<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{response.sendRedirect("/servlet/StartLogin");
return;
}
if(!teasession._rv.isReal())
            {
                 response.sendError(403);
                return;
            }
            Profile profile = Profile.find(teasession._rv._strR);
            String s1 = request.getParameter("Mobile").trim();
            String s2 =sms.password();
            String msg="您好!您在1660上注册的密码是"+s2;
			if(profile.changemobile(s2,s1))
            {
				sendsms.SubmitPassword(s1,msg,s2);
response.sendRedirect("EditAddress.jsp");

  }
  else
  {
%>
<jsp:forward page="Cmerror.jsp">
 <jsp:param name="PhoneNumber" value="<%=s1%>"/>

</jsp:forward>

<%
  }
%>

