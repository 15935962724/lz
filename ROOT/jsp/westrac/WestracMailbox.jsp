<%@page import="tea.entity.MT"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*"%><%@ page import="tea.entity.member.*"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%@page import="tea.entity.admin.mov.*"%>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
} 

Resource r=new Resource();
r.add("/tea/resource/Classes");


StringBuffer sp = new StringBuffer("/");



if("POST".equals(request.getMethod()))
{
	String memberemail = teasession.getParameter("memberemail");
	String subject = teasession.getParameter("subject");
	String contents= teasession.getParameter("content");


    int  message=Message.create(teasession._strCommunity, teasession._rv._strR,memberemail, teasession._nLanguage, subject, contents);
    Message obj2 = Message.find(message);
    obj2.setFolder(1);
 
	out.print("<script>alert('短消息发送完毕！');window.returnValue=1;window.close();</script>");
	return;   
	  
}else 
{
	if(teasession.getParameter("member")!=null &&teasession.getParameter("member").length()>0&&!"/".equals(teasession.getParameter("member")))
	{
		String member = teasession.getParameter("member");
		sp.append(member);
	}else
	{
		String sql = teasession.getParameter("sql");
		sql = MT.dec(sql);
		 java.util.Enumeration e = Profile.find(sql,0,Integer.MAX_VALUE);
		 for(int i=1;e.hasMoreElements();i++)
	 	{
	 		String memberorder =((String)e.nextElement());
	 	   
	 	    sp.append(memberorder).append("/");
	 	    
	 	}
		 
	}
}

%>
<html>
<head>
<title>发生会员短消息</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
window.name='dialog';
function f_click(id)
{
  window.returnValue=id;
  window.close();
}
function f_sub()
{
	if(form1.memberemail.value=='')
	{
		alert("请选择发送用户名");
		form1.memberemail.focus();
		return false;
	}
		if(form1.subject.value=='')
	{
		alert("请添加发送短消息主题");
		form1.subject.focus();
		return false;
	}
		document.getElementById('buttonid').value='短消息正在提交,请稍候...';
		document.getElementById('buttonid').disabled=true;
		document.getElementById('closeid').disabled=true;
		
	form1.submit();
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<h1>发送会员短消息</h1>
<form name="form1" method="POST" action="?" target="dialog" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right" nowrap>用户名：</td>
    <td><textarea rows="2" cols="60" name="memberemail" readonly="readonly" ><%if(!"/".equals(sp.toString())){out.print(sp.toString());} %> </textarea></td>
  </tr>
    <tr>
    <td align="right" nowrap>短消息主题：</td>
    <td><input type="text" name="subject" value="" size=79></td>
  </tr>
   <tr>
    <td align="right" nowrap>短消息内容：</td>
    <td>
		 <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="690" height="450" frameborder="no" scrolling="no"></iframe>
      
	</td>
  </tr>
</table>

<br>
<input type="button" id="buttonid" value="发送短消息" onclick=f_sub();>&nbsp;<input type="button" id="closeid" value="关闭" onclick=window.close();>

</form>
</body>
</html>
