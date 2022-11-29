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
<%@ page import="java.net.URLDecoder" %>  

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
	return;
}


String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();



StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
  
if(teasession._nNode>0)
{
	sql.append(" and node = "+teasession._nNode);
	param.append("&node=").append(teasession._nNode);
}
String mobile = teasession.getParameter("mobile");
if(mobile!=null && mobile.length()>0)
{
	sql.append(" and mobile like ").append(DbAdapter.cite("%"+mobile+"%"));
	param.append("&mobile=").append(mobile);
}



int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = MobileOrder.count(teasession._strCommunity,sql.toString());
%>


<html>
<head>
<title>手机支付管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>

function f_sub(igd,strigd)
{

	try{
		if((form1.checkbox_subid.length+"")=="undefined")    
		{
	 	 		if(!form1.checkbox_subid.checked)
	 	 		{
	 	 			alert(strigd);
					return false;
	 	 	 	}
	 	 		
	 	 }else
	 	 {
			    var f = false;
			    for (var i=0; i< form1.checkbox_subid.length; i++)
			    {
			      if (form1.checkbox_subid[i].checked)
			      {
				      f = true;
				  }
			    }
			    if(!f)
			    {
					alert(strigd);
					return false;
			    }
	 	 }
	}catch(e)
	{
		alert(strigd);
		return false;
	}

	if(igd=='delete')
	{
	   if(confirm('您确认执行【删除】操作?'))
	    {
	      form1.act.value="f_sub_delete";
	      form1.action = '/jsp/general/subscribe/mobilepay_ajax.jsp';
	      form1.submit();
	    }
	}
	if(igd =='jh')
	{
		if(confirm('您确认执行【激活】操作?'))
	    {
	      form1.act.value="f_sub_jh";
	      form1.action = '/jsp/general/subscribe/mobilepay_ajax.jsp';
	      form1.submit();
	    }
	}


}
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("checkbox_subid");
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
</script>

<h1>手机支付管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="get" >
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>  
<input type="hidden" name="act">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>


<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td>手机号码：</td>
		<td><input type=text name="mobile" value="<%=Entity.getNULL(mobile) %>"></td>
		
      <td><input type="submit" value="查询"/></td>
	</tr> 
 </table>
 

<h2>手机支付列表</h2>

<h2>
<input type="button" value="　删除　" onclick="f_sub('delete','请选择你要删除的记录!');">&nbsp;
<input type="button" value="　激活　" onclick="f_sub('jh','请选择你要删除的记录!');">
 </h2>
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
	    <td width=1><input type="checkbox" name="checkall" onclick="CheckAll()" /></td>
	      <td nowrap>手机号码</td>
	      <td nowrap>短信确认码</td>
	       <td nowrap>生效状态</td>
	       <td nowrap>激活时间</td>
	       <td nowrap>过期时间</td>
	       <td nowrap>创建时间</td>
	    
    </tr>
    <%
    

	Enumeration e = MobileOrder.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
      for(int i = 1;e.hasMoreElements();i++)
      {
       
			String moid = ((String)e.nextElement());
			MobileOrder mobj = MobileOrder.find(moid);
			
			
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
    <td width=1><input type="checkbox" name="checkbox_subid" value="<%=moid %>"/></td>
    <td><%=mobj.getMobile()%></td>
    <td><%=mobj.getMobilecode()%></td>
    
        <td><%if(mobj.getType()==1){out.print("已激活");}else if(mobj.getType()==0){out.print("<font color=Red>未激活</font>");}else if(mobj.getType()==3){out.print("已过期");}%></td>
        <td><%=Entity.getTimeToString(mobj.getPaytimes()) %></td>
            <td><%=Entity.getTimeToString(mobj.getMaturitytimes()) %></td>
      <td><%=Entity.getTimeToString(mobj.getTimes()) %></td>
      
    </tr>
    <%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>