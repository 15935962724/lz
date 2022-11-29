<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

//参数 node  为文件夹节点号
//参数 membertype 0 为会员 1 可以不是 会员



String nexturl = teasession.getParameter("nexturl");
int nid = 0;
if(teasession.getParameter("nid")!= null && teasession.getParameter("nid").length()>0)
{
  nid = Integer.parseInt(teasession.getParameter("nid"));
}
Node nobj = Node.find(nid);

Report robj = Report.find(nid);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body>

<script>

function f_submit()
{

	if(form1.name.value=='')
	{
		alert("姓名不能为空");
		form1.name.focus();
		return false;
	}
	if(form1.units.value=='')
	{
		alert("工作单位不能为空");
		form1.units.focus();
		return false;
	}
	if(form1.email.value=='')
	{
		alert("邮箱不能为空");
		form1.email.focus();
		return false;
	}
	if(form1.mobile.value=='')
	{
		alert("手机不能为空");
		form1.mobile.focus();
		return false;
	}
	if(form1.address.value=='')
	{
		alert("地址不能为空");
		form1.address.focus();
		return false;
	}

}
</script>
<form name="form1" METHOD=POST action="/servlet/EditContributors"  onsubmit="return f_submit();" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="nid" value="<%=nid%>"/>
<input type="hidden" name="act" value="ContributorsMember"> 
<input type="hidden" name="member" value="<%=teasession._rv.toString() %>"/>
<table border="0" align="center" cellpadding="0" cellspacing="0" id="tablecenter" height="10">
<tr>
	<td colspan="4">个人信息</td>
</tr>
<tr>
	<td>*&nbsp;姓名:</td>
	<td><input type="text" name="name" value="<%if(robj.getName(teasession._nLanguage)!=null)out.println(robj.getName(teasession._nLanguage)); %>"/></td>
	<td>*&nbsp;工作单位:</td>
	<td><input type="text" name="units" value="<%if(robj.getUnits(teasession._nLanguage)!=null)out.println(robj.getUnits(teasession._nLanguage)); %>"/></td>
</tr>
<tr>
	<td>*&nbsp;邮箱:</td>
	<td><input type="text" name="email" value="<%if(robj.getEmail(teasession._nLanguage)!=null)out.println(robj.getEmail(teasession._nLanguage)); %>"/></td>
	<td>*&nbsp;手机:</td>
	<td><input type="text" name="mobile" value="<%if(robj.getMobile(teasession._nLanguage)!=null)out.println(robj.getMobile(teasession._nLanguage)); %>"/></td>
</tr>
<tr>
<td>*&nbsp;地址:</td>
<td ><input type="text"  name="address" value="<%if(robj.getAddress(teasession._nLanguage)!=null)out.println(robj.getAddress(teasession._nLanguage)); %>"></td>
<td>*&nbsp;办公电话:</td>
	<td><input type="text" name="telephone" value="<%if(robj.getTelephone(teasession._nLanguage)!=null)out.println(robj.getTelephone(teasession._nLanguage)); %>"/></td>

</tr>
</table>
<br/>
 <input type="submit" name="GoFinish"  value="　提　交　">&nbsp;
 <input type="button"   value="　关　闭　" onClick="javascript:window.close();">
</form>


</body>

</html>
