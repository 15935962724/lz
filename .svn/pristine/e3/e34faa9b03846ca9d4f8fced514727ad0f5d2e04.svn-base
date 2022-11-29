<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}





String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));

String name = teasession.getParameter("name");
if(name!=null && name.length()>0){
	name = name.trim();
	sql.append(" and name like ").append(DbAdapter.cite("%"+name+"%"));
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
}


String natures = teasession.getParameter("natures");
if(natures!=null && natures.length()>0){
	natures = natures.trim();
	sql.append(" and natures  like ").append(DbAdapter.cite("%"+natures+"%"));
	param.append("&natures=").append(URLEncoder.encode(natures,"UTF-8"));
}

String legal = teasession.getParameter("legal");
if(legal!=null && legal.length()>0){
	legal = legal.trim();
	sql.append(" and legal  like ").append(DbAdapter.cite("%"+legal+"%"));
	param.append("&legal=").append(URLEncoder.encode(legal,"UTF-8"));
}

String contact = teasession.getParameter("contact");
if(contact!=null && contact.length()>0){
	contact = contact.trim();
	sql.append(" and contact like ").append(DbAdapter.cite("%"+contact+"%"));
	param.append("&contact=").append(URLEncoder.encode(contact,"UTF-8"));
}


int pos = 0, size = 15, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count =EnterpriseAward.count(teasession._strCommunity,sql.toString());

 sql.append(" order by times desc ");

%>

<html>
<head>
<title>企业评选管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("eaid");
	var lname="";
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){
	      fname[i].checked=true;
	}
	}else{
	   for(var i=0; i<fname.length; i++){
	      fname[i].checked=false;
	   }
	}
}

function f_delete()
{
  if(submitCheckbox(form1.eaid,'请选择你要删除的数据!'))
  {
		  if(confirm('您确定要删除选中会员吗？'))
			{
				form1.action='/jsp/qcjs/EditEnterpriseAward.jsp';
				form1.act.value='EnterpriseAward-DELETE';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
  }
}
function f_word()
{
	if(submitCheckbox(form1.eaid,'请选择你要导出的数据!'))
  {

				form1.action='/jsp/qcjs/EnterpriseAwardWord.jsp';
	    		form1.submit();
  }
}
function f_button()
{
	form1.action ="?";
	form1.submit();
}
</script>
<h1>企业评选管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >

<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
<input type="hidden" name="act" >

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
	<tr>
		<td width="" align="right">企业名称：</td>
		<td><input type="text" name="name" value="<%=Entity.getNULL(name) %>"/></td>
		<td align="right">企业性质：</td>
		<td><input type="text" name="natures" value="<%=Entity.getNULL(natures) %>"/></td>
	</tr>
	<tr>
		<td align="right">企业法人：</td>
		<td><input type="text" name="legal" value="<%=Entity.getNULL(legal) %>"/></td>
	</td>
		<td align="right">联系方式：</td>
		<td><input type="text" name="contact" value="<%=Entity.getNULL(contact) %>"/></td>

	</tr>
	<tr>

		<td colspan="4" align="center"><input type="button" value="查询" onclick=f_button();></td>

	 </tr>

 </table>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;条记录&nbsp;)&nbsp;</h2>
<h2>

<input type="button" value="　增加　" onclick="window.open('/jsp/qcjs/EditEnterpriseAward.jsp?nexturl='+encodeURIComponent(location.href),'_self');">&nbsp;
<input type="button" value="　删除　" onclick="f_delete();">&nbsp;
<input type="button" value="　导出Word　" onclick="f_word();">&nbsp;

 </h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
      <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
	       <td nowrap>企业名称</td>
	       <td nowrap>企业性质</td>
	       <td nowrap>企业法人</td>
	       <td nowrap>联系方式</td>
	       <td nowrap>第几届</td>
	       <td nowrap>添加时间</td>
	       <td nowrap>操作</td>
    </tr>

 <%
 	 Enumeration e = EnterpriseAward.find(teasession._strCommunity,sql.toString(),pos,size);
	 if(!e.hasMoreElements())
	 {
	     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
	 }
 	for(int i=1;e.hasMoreElements();i++){
 		int eaid = ((Integer)e.nextElement()).intValue();
 		EnterpriseAward eaobj = EnterpriseAward.find(eaid);
 %>

    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
  	 <td width=1><input type=checkbox name=eaid value="<%=eaid%>" style="cursor:pointer"></td>
  	 <td><%=eaobj.getName() %></td>
  	 <td><%=eaobj.getNatures() %></td>
  	 <td><%=eaobj.getLegal() %></td>
  	 <td><%=eaobj.getContact() %></td>
  	 <td>第<%=eaobj.getEatype() %>届</td>
  	  <td><%=eaobj.sdf.format(eaobj.getTimes()) %></td>
  	 <td>
  	 <a href="/jsp/qcjs/EnterpriseAwardShow.jsp?eaid=<%=eaid %>&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">详细</a>
  	 <a href="/jsp/qcjs/EditEnterpriseAward.jsp?eaid=<%=eaid %>&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">编辑</a></td>
    </tr>

    <%} %>
<%if (count > size) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
