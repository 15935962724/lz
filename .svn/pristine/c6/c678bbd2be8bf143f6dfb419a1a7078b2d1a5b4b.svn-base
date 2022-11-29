<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@include file="/jsp/Header.jsp"%>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl=request.getRequestURI()+"?"+request.getQueryString();

String time_s = request.getParameter("time_s");
String time_e = request.getParameter("time_e");
String content =request.getParameter("content");

String sql="";
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body>
<h1>编辑附件</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?demand=demand" onSubmit="">
 
	
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
     		<td><%=r.getString(teasession._nLanguage,"Time")%>：<input name="time_s" size="7" onfocus="if(this.value=='yyyy-mm-dd')this.value='';" onblur="if(this.value=='')this.value='yyyy-mm-dd';" value=""><A href="###"><img onclick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --
           <input name="time_e" size="7" onfocus="if(this.value=='yyyy-mm-dd')this.value='';" onblur="if(this.value=='')this.value='yyyy-mm-dd';" value=""><A href="###"><img onclick="showCalendar('form1.time_e');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
     		<td>附件名字：<input name="content" value=""></td>
          <td><input type="submit" value="GO"/></td>
     </tr>
   </table>
</form>
<br>

<table align="center" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	
		<tr id="tableonetr" > 
			<td nowrap>提交时间</td>
			 <td nowrap>附件名字</td>
			 <td nowrap>操作</td>
		</tr>  
		<%
			   DbAdapter db = new DbAdapter();
			   try
			   {
			  if((time_s=="" ||time_s==null) && (time_e=="" || time_e==null) && (content =="" || content==null)){
			  		sql ="select worklog,accessories,path,community,time from  Worklog where community= '"+teasession._strCommunity+"' and member='"+teasession._rv._strV+"'";
			   		//db.executeQuery("select worklog,accessories,path,community,time from  Worklog where community= '"+teasession._strCommunity+"' and member='"+teasession._rv._strV+"'");
			   	} else if((time_s=="" || time_s ==null) && (content!=null || content !=""))
			   	{
			   			sql = "select worklog,accessories,path,community,time from  Worklog where community= '"+teasession._strCommunity+"' and member='"+teasession._rv._strV+"'  and accessories like '%"+content+"%'";
			   	}
			   	else{
			   		
			   		sql = "select worklog,accessories,path,community,time from  Worklog where community= '"+teasession._strCommunity+"' and member='"+teasession._rv._strV+"' and '"+time_s+"' < time and time< '"+time_e+"' and accessories like '%"+content+"%'";
			   	}
			   	db.executeQuery(sql);
			   		while(db.next()){
			   		if(!db.getString(3).equals("")){ 		
		 %>

		<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
			<td><%=db.getString(5).substring(0,10) %></td>
			<td><a href ="/jsp/include/DownFile.jsp?uri=<%=java.net.URLEncoder.encode(db.getString(3),"UTF-8") %>&name=<%=java.net.URLEncoder.encode(db.getString(2),"UTF-8") %>"><%=db.getString(2) %></a></td>
			<td><a href="/jsp/admin/workreport/EditWorklog.jsp?community=<%=db.getString(4)%>&worklog=<%=db.getInt(1) %>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>">编辑</a>&nbsp;
			<a href="/servlet/EditWorkreport?community=<%=db.getString(4)%>&worklog=<%=db.getInt(1) %>&action=deleteAccessories&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>" onClick="return window.confirm('您确定要删除此内容吗？')">删除</a></td>

		</tr>  
		
		<%
					}
				}
			} catch (Exception exception)
			{
				exception.toString();
        } finally
        {
            db.close();
        }
		 %>
		 
		
</table>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


