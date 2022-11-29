<%@page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.member.Message"%>
<%@ page import="tea.entity.member.Profile"%>
<%@ page import="tea.entity.site.License"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.service.Robot"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.http.RequestHelper"%>


<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();

TeaSession teasession = new TeaSession(request);
r.add("/tea/resource/Photography");
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String neurl=request.getRequestURL().toString();
%>

<script src="/tea/tea.js" type="text/javascript"></script>

<script>
	function f_submt()
	{
		if(foRetrieve.cmember.value=='')
			{
				document.getElementById("foshow").innerHTML ='<font color=red>请输入您的用户名</font>';
				//alert('<%=r.getString(teasession._nLanguage, "2969876073")%><%=r.getString(teasession._nLanguage, "9967733288")%>');
				foRetrieve.cmember.focus();
				return false;
			}
	}
</script>

<h1>找回密码</h1>

<DIV ID="edit_BodyDiv">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>

<FORM name=foRetrieve METHOD=POST action="/ChildMembers.do?act=RetrievePassword" onSubmit="return f_submt();");">
<table id="" >

<input type="hidden" name="node" value="<%=teasession._nNode%>" />

<input type="hidden" name="nextUrl" value="<%=neurl%>" />
<tr><td>
请输入您的用户名:</td>
<td>
<input type="TEXT" class="edit_input"  name="cmember"><span id ="foshow"></span></td>
</tr>
<tr>
<td>
请输入验证码:
</td>
<td>
<input type="text" class="edit_input" name="vertify"/>
<img src="" id="verid" onClick="chageVer();" /><a href="javascript:void(0);" onClick="chageVer();">看不清</a>
<script>

	document.getElementById("verid").src="/ChildMembers.do?act=verify&verify=3";
	function chageVer(){
		var num=parseInt(Math.random()*100);
		document.getElementById("verid").src+="&num="+num;
	}
</script>
</td>
</tr>
<tr ><td colspan="2">
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>" onClick="f_submt();">
</td>
</tr>
</table>

<span id ="foshow"></span>
</FORM>
<SCRIPT>document.foRetrieve.member.focus();</SCRIPT>
<P>如果您想获得其他问题的答案，请与我们联系如没有其他问题，请点击<a href="#" onClick="javascript:window.close();">关闭</a></p>

</td>
</tr>
</table>

</DIV>


