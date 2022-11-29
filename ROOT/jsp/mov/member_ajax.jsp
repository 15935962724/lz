<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="java.lang.*"%>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r=new Resource("/tea/resource/Photography");
String value = teasession.getParameter("value");
String name =  teasession.getParameter("name");

if(value!=null && value.length()>0)
{
  if("MemberId".equals(name))//用户名检测
  {
    if(Profile.isExisted(value))
    {
      out.print("<font color=red>"+r.getString(teasession._nLanguage,"0605279810")+"</font>");
    }else
    {
      out.print("<font color=green>"+r.getString(teasession._nLanguage,"4186534224")+"!</font>");
    }
  }else if("f_firstnameajax".equals(name)){
	  
	  if(Profile.isFirstname(teasession._strCommunity,value))
	  {
		  out.print("<font color=red>"+r.getString(teasession._nLanguage,"3775093400")+"</font>");
	  }else
	  {
		  out.print("<font color=green>"+r.getString(teasession._nLanguage,"9817060908")+"!</font>");
	  }
	  
  }else if("MemberId_en".equals(name))//英文网
  {
	  if(Profile.isExisted(value))
	    {
	      out.print("<font color=red>Sorry! There's an error in the email format. Please re-enter.</font>");
	    }else
	    {
	      out.print("<font color=green>Congratulations! The account name is valid.</font>");
	    }
  }
}


%>

