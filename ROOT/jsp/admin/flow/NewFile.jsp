<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.entity.*"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
 request.setCharacterEncoding("UTF-8");
 String id = teasession.getParameter("id");

 String acceename = teasession.getParameter("acceename");
 String bulletins = teasession.getParameter("bulletins");
 String captions = teasession.getParameter("captions");
 String time_ss = teasession.getParameter("time_ss");
 String time_es = teasession.getParameter("time_es");
 String contents = teasession.getParameter("contents");
 String parts = teasession.getParameter("parts");
 
 


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>上传附件文件</h1>
<%
 if(acceename!=null)
 {
 	DbAdapter dbadapter = new DbAdapter();
 	try{
		dbadapter.executeQuery("SELECT name,file_id,file_name FROM Bullfile  where bull_id=1");
		while(dbadapter.next())
		{
			out.print("--"+dbadapter.getVarchar(1,1,1)+",");
		}
	}catch (Exception ex)
	{
		ex.toString();
	}finally
	{
		dbadapter.close();
	}

}
 %>
 <script>
 	function files()
 	{
 		if(form1.acceefile.value=="")
 		{
 			alert("请选择附件！");
 			return false;
 		}
 	}
 </script>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" METHOD="post" action="/servlet/EditBulletin" ENCtype=multipart/form-data onSubmit="return files();">
<input type="hidden" name="AccFile" value="ACCFILE">
<input type="hidden" name="id" value="<%=id %>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  
  		
  	<input type="hidden" value ="<%=bulletins %>" name="bulletins">
  	<input type="hidden" value ="<%=captions %>" name="captions">
  	<input type="hidden" value ="<%=time_ss %>" name="time_ss">
  	<input type="hidden" value ="<%=time_es %>" name="time_es">
  	<input type="hidden" value ="<%=contents %>" name="contents">
  	<input type="hidden" value="<%=parts %>" name="parts">
    <tr>
      <td COLSPAN=6><input NAME="acceefile" TYPE=FILE class="edit_input" onclick="" size="40"></td>
    </tr>

    <tr>
      <td></td>
      <td><input type="submit" name="submit" value="上传附件文件"></td>
    </tr>
    <tr>
		<td align="center">
			<a href="/jsp/admin/flow/NewBulletin.jsp?community=<%=teasession._strCommunity %>&id=<%=id %>&bulletins=<%=java.net.URLEncoder.encode(bulletins,"UTF-8") %>&captions=<%=java.net.URLEncoder.encode(captions,"UTF-8") %>&time_ss=<%=java.net.URLEncoder.encode(time_ss,"UTF-8") %>&time_es=<%=java.net.URLEncoder.encode(time_es,"UTF-8") %>&contents=<%= java.net.URLEncoder.encode(contents,"UTF-8")%>&parts=<%=java.net.URLEncoder.encode(parts,"UTF-8") %>" onclick="javascript:window.close();">完成</a>
		</td>
	</tr>
  </table>


