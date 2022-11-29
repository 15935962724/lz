<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);


if(teasession._rv==null)
{
  out.println("您还没有登录，系统不能处理您的信息.<a href=\"###\" onclick=\"history.go(-1)\" >返回</a> ");
  return;
}
Node   node=Node.find(teasession._nNode);
Profile pobj = Profile.find(teasession._rv.toString());




%>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_sub(){
	

	
	
	if(form11.subject.value==''){
	alert('请填写主题');
	form11.subject.focus();
	return false;
	}
	
	if(form11.content.value==''){
	alert('请填写留言');
	form11.content.focus();
	return false;
	}
	if(form11.vertify.value==''){
	alert('请填写验证码');
	form11.vertify.focus();
	return false;
	} 

	form11.action='/servlet/EditMessageBoard';
	form11.submit();
}

</script>


<form name="form11" method="post" action="?" >
  <INPUT TYPE=hidden NAME=NewNode VALUE=ON>

<INPUT TYPE=HIDDEN NAME="Node" VALUE="<%=teasession._nNode %>">
<INPUT TYPE=HIDDEN NAME="name" VALUE="<%=pobj.getFirstName(teasession._nLanguage) %>">
<INPUT TYPE=HIDDEN NAME="mobile" VALUE="<%=pobj.getAddress(teasession._nLanguage) %>"><!--地址  -->
<INPUT TYPE=HIDDEN NAME="email" VALUE="<%=pobj.getEmail() %>">
<INPUT TYPE=HIDDEN NAME="phone" VALUE="<%=pobj.getTelephone(teasession._nLanguage) %>">


<table border="0" cellpadding="0" cellspacing="5">
  <input type="hidden" name="Hint" value="0" >
 <tr>
      <td width="100" height="30" align="right" valign="middle">姓　　名：</td>
      <td width="214" height="30" align="left" valign="middle"><%=pobj.getFirstName(teasession._nLanguage) %></td>
      
    </tr>
	    <tr>
      <td height="30" align="right" valign="middle">所在地区：</td>
      <td height="30" align="left" valign="middle"><%=pobj.getAddress(teasession._nLanguage) %></td>
    </tr>
    <tr>
      <td height="30" align="right" valign="middle">邮箱地址：</td>
      <td height="30" align="left" valign="middle"><%=pobj.getEmail() %>
      <br/></td>
    </tr>
    <tr>
      <td height="30" align="right" valign="middle">联系电话：</td>
      <td height="30" align="left" valign="middle"><%=pobj.getTelephone(teasession._nLanguage) %></td>
    </tr>
    <tr>
      <td height="30" align="right" valign="middle">主　　题：</td>
      <td height="30" align="left" valign="middle"><input name="subject" type="text" maxlength="30"></td>
    </tr>
    <tr>
      <td height="164" align="right" valign="middle">留　　言：</td>
      <td height="164" width="456" align="left" valign="middle"><textarea name="content" cols="38" rows="10"></textarea></td>
    </tr>
    <tr>
      <td height="30" align="right" valign="middle">验&nbsp;证&nbsp;码：</td>
      <td height="30" align="left" valign="middle">
      
      
      <img src="/jsp/user/addValidate.jsp" id="vcodeImg" alt="点击更换验证码"  style="cursor:pointer" align="absmiddle" class="CodeImg" onClick="reloadVcode();">&nbsp;
        <input type="TEXT"  name=vertify value="" size="5" class="vertify" />&nbsp;&nbsp;<a href="#"   style="cursor:pointer"  onClick="reloadVcode();">看不清？请点击此处获得新的验证码</a>&nbsp;</td>
    </tr>
<tr>
      <td height="30" align="right" valign="middle"></td>
      <td height="35" align="left" valign="middle"　align="center"><input  type="button" name="Submit" value="" onClick="f_sub();" class="Submit" ></td>      
       </tr>
  </table>
</form>

