<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Vector"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.node.UserForm"%>
<%@ page import="tea.entity.member.*"%>



<%
request.setCharacterEncoding("UTF-8");
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
	String username=member;
	boolean flag=true;
	Vector temp=(Vector)application.getAttribute("myuser");
	if(application.getAttribute("myuser")==null){
		temp=new Vector();
	}
	
	for(int i=0;i<temp.size();i++){
		UserForm tempuser=(UserForm)temp.elementAt(i);
		if(tempuser.username.equals(username)){
			out.println("<script language='javascript'>alert('该用户已经登录');window.location.href='index.jsp';</script>");
            flag=false;
        }

	}
	UserForm mylist=new UserForm();
	mylist.username=username;
	
	
	//保存当前登录的用户名
	session.setAttribute("username",username);
	
	application.setAttribute("ul",username);

	Vector myuser=(Vector)application.getAttribute("myuser");
	if(myuser==null){
		myuser=new Vector();
	}

	if(flag){
		myuser.addElement(mylist);
	}

	application.setAttribute("myuser",myuser);
	response.sendRedirect("main.jsp#topname");
%>