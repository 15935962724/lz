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
if(teasession.getParameter("nid").indexOf("/")==-1&&teasession.getParameter("nid")!= null && teasession.getParameter("nid").length()>0)
{
  nid = Integer.parseInt(teasession.getParameter("nid"));
}
Node nobj = Node.find(nid);

Report robj = Report.find(nid);
String act = teasession.getParameter("act");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body style="padding:0px;">

<script>

function f_submit()
{

	if(form1.rejection.value=='')
	{
		alert("请填写退稿原因");
		form1.rejection.focus();
		return false;
	}

	//form1.act.value="Rejection";
	//form1.node.value=igd;
	//form1.nexturl.value=location.pathname+location.search;
	//form1.action="/servlet/EditContributors";
	//form1.submit();

	sendx("/servlet/EditContributors?nodeid="+form1.nid.value+"&act=Rejection&rejection="+encodeURIComponent(form1.rejection.value),
		 function(data)
		 {
		   if(data!=''&&data.length>1)//
		   {
				alert(data);
				window.returnValue='1';
				window.close();
		   }
		 }
	);


}

function CheckAll(igd)
{

 	form1.rejection.value=igd;

}


</script>
<form name="form1" METHOD=POST action="/servlet/EditContributors" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="nid" value="<%=teasession.getParameter("nid")%>"/>
<input type="hidden" name="act" value="Rejection">
<input type="hidden" name="member" value="<%=teasession._rv.toString() %>"/>
<table border="0" align="center" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="4">退稿原因</td>
</tr>
<%if(!"CLRE".equals(act)){ %>
<tr>
	<td>
		<input type="radio"" id=chename name="chename" value="没有新闻价值" onclick="CheckAll('没有新闻价值');">&nbsp;没有新闻价值&nbsp;
		<input type="radio" id=chename name="chename" value="写作水平有待提高"  onclick="CheckAll('写作水平有待提高');">&nbsp;写作水平有待提高&nbsp;
		<input type="radio" id=chename name="chename" value="请勿重复投稿" onclick="CheckAll('请勿重复投稿');">&nbsp;请勿重复投稿&nbsp;
	</td>
</tr>
<%} %>
<tr>
	<td><%if(!"CLRE".equals(act)){ %>

	<textarea rows="4" cols="60" name="rejection"><%=Entity.getNULL(robj.getRejection(teasession._nLanguage)) %></textarea>
	<%}else{out.print(Entity.getNULL(robj.getRejection(teasession._nLanguage)));} %></td>
	</tr>

</table>
<br/>
<%if(!"CLRE".equals(act)){%>
 <input type="button" name="GoFinish"  value="　提　交　" onclick=f_submit();>&nbsp;
 <%} %>
 <input type="button"   value="　关　闭　" onClick="javascript:window.close();">
</form>


</body>

</html>
