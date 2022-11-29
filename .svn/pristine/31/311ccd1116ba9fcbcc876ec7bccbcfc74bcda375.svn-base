<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.subscribe.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.subscribe.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String act = teasession.getParameter("act");

String nexturl = request.getRequestURI()+"?node="+teasession._nNode+"&act="+act+"&mobile="+teasession.getParameter("mobile");
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

%>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<html>
<head>
<title>手机验证码</title>
</head>


<%
	if("mobile".equals(act))
	{
		
	String mobile = teasession.getParameter("mobile");
	
	
	if(!MobileOrder.isNumeric(mobile))
	{
		out.println("<script>alert('您输入的手机号不正确，请重新输入!');history.go(-1);</script>");
		return;
	}
	 
	
%>

<body>

<script type="text/javascript">
function reloadVcode()
{
	var vcode = document.getElementById('vcodeImg');
	vcode.setAttribute('src','/jsp/user/validate.jsp?r='+Math.random());
	//这里必须加入随机数不然地址相同我发重新加载
}

function f_submit()
{
	
	if(form1.mobilecode.value=='')
	{
		alert('请输入阅读密码!');
		form1.mobilecode.focus();
		return false;
	}else
	{
		if(form1.vertify.value=='')
		{
			alert('请输入附加码!');
			form1.vertify.focus();
			return false;
			
		}else
		{
					 sendx("/jsp/general/subscribe/mobilepay_ajax.jsp?act=vertify&vertify="+form1.vertify.value,
							 function(data)
							 {
							   if(data.trim()!=''&&data.trim().length>1)//如果有这个用户 
							   { 
									 alert(data.trim());
									 form1.vertify.focus();
									 reloadVcode();
									 return false;
							   }else
							   {
								   sendx("/jsp/general/subscribe/mobilepay_ajax.jsp?act=mobilecode&mobile="+form1.mobile.value+"&mobilecode="+form1.mobilecode.value+"&node="+form1.node.value,

										   function(data)
										   {
											   if(data.trim()!=''&&data.trim().length>1)//如果有这个用户
											   { 
												 alert(data.trim());
												 form1.mobilecode.focus();
												 return false;
											   }else
											   {
												  /////////////////
													  form1.action='/jsp/general/subscribe/Mobilepay3.jsp';
													  form1.submit();
											   }
										   } 
								   );
								   
							   }
							 }
					);
		}
		
				 
	
	}
	

	
}

function f_addSMS()
{
	 sendx("/jsp/general/subscribe/mobilepay_ajax.jsp?act=Againmobile&mobile="+form1.mobile.value+"&node="+form1.node.value,
			 function(data)
			 {
			   if(data.trim()!=''&&data.trim().length>1)
			   { 
					 alert(data.trim());
					 form1.mobilecode.focus();
					 reloadVcode();
					 return false;
			   }
			 }
	 );
}

</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<h1>手机验证码</h1>
<form action="?" method="post" name="form1">
<input type ="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
 	 <td align="right">您的手机号码：</td><td><input type="text" name="mobile" value="<%=mobile %>" readonly="readonly" size="10"></td>
  </tr>
    <tr>
 	 <td align="right">阅读密码：</td><td><input type="text" name="mobilecode" value=""  size="10" maxlength="8" mask="float" >&nbsp;
 	 <a href="###" onClick="f_addSMS();">重新获得阅读密码</a>
 	 </td>
  </tr> 
   <tr>
 	 <td align="right">附加码：</td><td><input type="TEXT" class="Code"  name=vertify value="" size="5" maxlength="4" mask="float" >
   <img src="/jsp/user/validate.jsp" alt="点击图片可以更换验证码"  id="vcodeImg" align="absmiddle"  onclick="reloadVcode();"  style="cursor:pointer">
</td>
  </tr>
  
    <tr>
 	 <td align="center" colspan="2"><input type="button" value="下一步" onClick="f_submit();"></td>
  </tr> 
  <!-- 
    <tr>
 	 <td><input type=button value="首信易支付" onclick="window.open('/jsp/pay/newspaperbeijing/Send.jsp?community=<%=teasession._strCommunity %>&mobile=<%=mobile %>','_blank');" ></td>
  </tr>
   -->
  </table>

</form>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>

<%	} %>


