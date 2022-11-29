<%@page import="tea.resource.Resource"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.Entity"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.entity.RV"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
}
Resource r = new  Resource();
r.add("/tea/resource/Chat");

int cid = Integer.parseInt(teasession.getParameter("cid"));
Chat cobj = Chat.find(cid);

if("POST".equals(request.getMethod()))
{

     int action = Integer.parseInt(teasession.getParameter("action"));
     String buffer = teasession.getParameter("buffer");
    
     String attach = teasession.getParameter("attach");
     System.out.println(attach);
	
    if(teasession.getParameter("Clear") != null && teasession.getParameter("Clear").length()>0)
     {
    	attach = "";
     }else if(attach==null)
     {
    	 attach = cobj.getAttach();	 
     }
    
    
     System.out.println(teasession.getParameter("Clear") +"--"+attach);
      
     if(buffer!=null && buffer.length()>0)
     {
        cobj.set(action,buffer,attach);
     }
 	//添加成功
 	out.print("<script>alert('修改成功'); window.returnValue='1'; window.close();</script>");
 	return;     
}



long len = 0;
if(cobj.getAttach()!=null && cobj.getAttach().length()>0)
{
	len=new java.io.File(application.getRealPath(cobj.getAttach())).length();
}

 
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script>
window.name="dialog";
function f_sub()
{
	if(form1.buffer.value=='')
	{
		alert('请填写内容!');
		form1.buffer.focus();
		return false;
		
	}
	
	form1.method="POST";
	form1.submit();
	
}
</script>


<h1>聊天室管理</h1>
<form name="form1" action="?" target="dialog" ENCtype=multipart/form-data>
<input type="hidden" name="cid" value="<%=cid %>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
	<td align="right">表情：</td>
      <td nowrap>
		<SELECT name=action>
		<%
		for(int i=2;i<Chat.CHAT_ACTION.length;i++)
		{
		  out.print("<option value="+i);
		  if(cobj.getAction()==i)
		  {
			  out.print(" selected ");
		  }
		  out.print(">"+r.getString(teasession._nLanguage, Chat.CHAT_ACTION[i]));
		  out.print("</option>");
		}
		%>
</SELECT>
	</td>
</tr>

<tr>
	<td align="right"><%=r.getString(teasession._nLanguage, "Text")%>：</td>
	<td><textarea rows="3" cols="40"  name="buffer"><%if(cobj.getText(teasession._nLanguage)!=null)out.print(cobj.getText(teasession._nLanguage)); %></textarea></td>
</tr>
<tr>
	<td align="right"><%=r.getString(teasession._nLanguage, "附件")%>：</td>
	<td COLSPAN=6><input type="file" name="attach" class="edit_input"/>
	 <%
      if(len> 0)
      {
        out.print("<a href='"+cobj.getAttach()+"' target='_blank'>查看原图&nbsp;("+len + r.getString(teasession._nLanguage, "Bytes")+")</a>");
        out.print("<input id='checkbox' type='checkbox' name='Clear' onclick='form1.attach.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
	</td>
</tr> 
     
 

</table>
<br>
<input  type="button" class="edit_button" value="提交" onclick="f_sub();" >
<input type="button" class="edit_button" value="关闭" onclick="window.close()">
</form>
</body>
</html>

