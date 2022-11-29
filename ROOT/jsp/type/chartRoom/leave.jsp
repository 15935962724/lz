<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="tea.entity.node.UserForm"%>
<%
System.out.println("用户"+session.getAttribute("username")+"成功退出聊天室");
	Vector temp=(Vector)application.getAttribute("myuser");
	for(int i=0;i<temp.size();i++){
		UserForm mylist=(UserForm)temp.elementAt(i);
		if(mylist.username.equals(session.getAttribute("username"))){
			temp.removeElementAt(i);
			session.setAttribute("username","null");
		}
		if(temp.size()==0){
				application.removeAttribute("message");
		}
	}

%>
