<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.subscribe.*" %>
<%@page import="tea.entity.node.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

int nid = 0;
if(teasession._nNode>0)
{
	nid = teasession._nNode;	
}
//判断是否有手机支付设置
if(Node.find(nid).getCategoryosubscribe()!=null && Node.find(nid).getCategoryosubscribe().length()>0 && Node.find(nid).getCategoryosubscribe().indexOf("/4/")!=-1)
{



%>

<script src="/tea/tea.js" type="text/javascript"></script>

<script>
 
	function f_submit1()
	{
		if(form1.mobile.value=='')
		{
			alert('手机号码不能为空!');
			form1.mobile.focus();
			return false;
		}else
		{
			 var string_value =form1.mobile.value;
			 var type="^\s*[+-]?[0-9]+\s*$";
			 var re = new RegExp(type);

			   if(string_value.match(re)==null)
			   {

			     alert("手机号码有误,请确认!");
			     form1.mobile.focus();
			     return false;
			   }
			  if(string_value.length!=11)
			  {

				     alert("手机号码有误,请确认!");
				     form1.mobile.focus();
				     return false;
			  }
		}
	}
	function f_submit2()
	{
		if(form2.mobilecode.value=='')
		{
			alert("阅读密码不能为空!");
			form2.mobilecode.focus();
			return false;
		}else
		{
			sendx("/jsp/general/subscribe/mobilepay_ajax.jsp?act=Mobilepay_f_submit2&mobilecode="+form2.mobilecode.value+"&node="+form2.node.value,
					 function(data)
					 { 
					   if(data.trim()!=''&&data.trim().length>1)
					   { 
							 alert(data.trim());
							 form2.mobilecode.focus();
							 return false;
					   }
					 }
			 ); 
		}
	}
</script>
<table>
<tr><td>
<form action="/jsp/general/subscribe/mobilepay_ajax.jsp" method="post" name="form1"  onsubmit="return f_submit1();">
<input type="hidden" name="node" value="<%=nid %>"/>
<input type="hidden" name="act" value="mobile"/>
请输入手机号码： <input type="text" name="mobile" value=""  mask="float" >&nbsp;<input type="submit" value="下一步"/><br/>
</form></td></tr>
<tr><td class="td02">
注：输入您的手机号后我们会发送阅读密码到手机上，支付费用后，输入该密码可进行一天的阅读</td></tr>
<tr><td>
<form action="?" method="post" name="form2">
<input type="hidden" name="node" value="<%=nid %>"/>
<input type="hidden" name="act" value="mobilecode"/>
请输入阅读密码：<input type="text" name="mobilecode" value="" maxlength="8" mask="float"  >&nbsp;<input type="button"  value="激活" onclick="f_submit2();">
</form></td></tr>
<tr><td class="td02">
注：如果您购买过一天的阅读权限，请直接输入您获得的阅读密码，直接进入阅读。</td></tr></table>
<%}%>