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
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}





String nexturl = teasession.getParameter("nexturl");
String act = teasession.getParameter("act");
int nid = 0;
if(teasession.getParameter("nid")!= null && teasession.getParameter("nid").length()>0)
{
  nid = Integer.parseInt(teasession.getParameter("nid"));
}
Node nobj = Node.find(nid);

if("POST".equals(request.getMethod()))
{
	String audits = teasession.getParameter("audits");
	String audits_reason = teasession.getParameter("audits_reason");
	Category cobj = Category.find(nobj.getFather());
	int audit_type = nobj.getAudit();
	
	int perm = 0;
	if((cobj.getPermissions() & 1) != 0&&audit_type==0)
	{
		
		perm = cobj.getPermissionsAll(audit_type);
	}else 
    if((cobj.getPermissions() & 2) != 0&&audit_type==1)
	{
    	perm = cobj.getPermissionsAll(audit_type);
	}else 
    if((cobj.getPermissions() & 4) != 0&&audit_type==2)
	{
    	perm = cobj.getPermissionsAll(audit_type);
	}else 
    if((cobj.getPermissions() & 8) != 0&&audit_type==3)
	{
    	perm = cobj.getPermissionsAll(audit_type);
	}

	if(nobj.getType()==39)
	{
	    Report robj = Report.find(nid);
	    robj.setIseditreport(0); 
	    //拒绝 
	    if("false".equals(audits))
	    {
	    	  robj.setRefuse_audits(audit_type+1); 
	    	  robj.setAudits_reason("audits_reason"+(audit_type), audits_reason,"audits_reason_member"+(audit_type),teasession._rv._strR); 
	    	 
	    }else 
	    {
	    	robj.setAudits_by("audits_by"+(audit_type), audits_reason,"audits_by_member"+(audit_type),teasession._rv._strR); 
	    	if(perm==0)
	    	{
	    		perm = 4;
	    		nobj.setHidden(false);  
	    	}
	    	nobj.setAudit(perm);
	    	robj.setRefuse_audits(0);
	    	//如果审核通过，测清空编辑状态
	    } 
	}

		out.print("<script  language='javascript'>alert('审核操作成功');window.returnValue=1;window.close(); </script> ");

		return;

	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<script>
 

function f_submit()
{


	var ck = document.getElementsByName("audits"); 
	var flat = true;
	var fstr='';
	for(var i = 0; i < ck.length; i++) {
		if(ck[i].checked) {
			flat = false;
			fstr=ck[i].value;
		} 
	}
	if(flat)
	{
		document.getElementById("span_auditsid").innerHTML='&nbsp;<font color=red>请选择审核状态</font>';
		return false;
	}

	document.getElementById("span_auditsid").innerHTML='';
	
	if(document.getElementById("audits_reason").value=='' && fstr=='false')
	{
		document.getElementById("span_audits_reason").innerHTML='<br><font color=red>请填写拒绝审核意见</font>';
		return false;
	}
	document.getElementById("span_audits_reason").innerHTML='';
	
	form_sub.submit();
	
}
</script>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes"> 


<h2>审核意见查看</h2>
<%
	if("See".equals(act))
	{
%>
<h2>审核状态</h2>
<table border="0"  cellpadding="0" cellspacing="0" id="tablecenter" height="10">
<tr>
	<td>状态</td>
	<td>审核意见</td>
	<td>审核用户</td>
</tr>

	   <%
	   //审批意见
	   if(nobj.getType()==39)
	   {
		   Report robj = Report.find(nid);
		   String austring =robj.getAudits_reason(0);
		   if(austring!=null && austring.length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>一级初审未通过意见：</b></td>");
			   out.println("<td>");
			   		out.println(austring); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_reason_member0()); 
		       out.println("</td>");
			   
			   out.print("</tr>");
		   }
		 
		   if(robj.getAudits_by0()!=null && robj.getAudits_by0().length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>一级初审通过意见：</b></td>");
			   out.println("<td>");
			   		out.println(robj.getAudits_by0()); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_by_member0()); 
		       out.println("</td>");
			   
			   out.print("</tr>");
		   }
		  
		    austring = robj.getAudits_reason(1);
		   if(austring!=null && austring.length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>一级终审未通过意见：</b></td>");
			   out.println("<td>");
			   out.println(austring); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_reason_member1()); 
		       out.println("</td>");
			   out.print("</tr>");
		   }
		   
		   
		   if(robj.getAudits_by1()!=null && robj.getAudits_by1().length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>一级终审通过意见：</b></td>");
			   out.println("<td>");
			   		out.println(robj.getAudits_by1()); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_by_member1()); 
		       out.println("</td>");
			   
			   out.print("</tr>");
		   }
		  
		    austring = robj.getAudits_reason(2);
		   if(austring!=null && austring.length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>二级初审未通过意见：</b></td>");
			   out.println("<td>");
			   out.println(austring); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_reason_member2()); 
		       out.println("</td>");
			   out.print("</tr>");
		   }
		   
		   if(robj.getAudits_by2()!=null && robj.getAudits_by2().length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>二级初审通过意见：</b></td>");
			   out.println("<td>");
			   		out.println(robj.getAudits_by2()); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_by_member2()); 
		       out.println("</td>");
			   
			   out.print("</tr>"); 
		   }
		  
		    austring =robj.getAudits_reason(3);
		   if(austring!=null && austring.length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>二级终审未通过意见：</b></td>");
			   out.println("<td>");
			   out.println(austring); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_reason_member3()); 
		       out.println("</td>");
			   out.print("</tr>");
		   }
		  
		   
		   if(robj.getAudits_by3()!=null && robj.getAudits_by3().length()>0)
		   {
			   out.print("<tr>");
			   out.println("<td align=right><b>二级终审通过意见：</b></td>");
			   out.println("<td>");
			   		out.println(robj.getAudits_by3()); 
			   out.println("</td>");
			   out.println("<td>");
		   		out.println(robj.getAudits_by_member3()); 
		       out.println("</td>");
			   
			   out.print("</tr>");
		   }
	   }
	   
	    
	   %> 
	 </td>
</tr>

</table>
<br/> 
 <input type="button"   value="　关　闭　" onClick="javascript:window.close();">
<%}else{ %>
<form action="?"  method="post"  name="form_sub">

<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="nid" value="<%=nid%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="act" value="ContributorsMember"> 
<input type="hidden" name="member" value="<%=teasession._rv.toString() %>"/>
<table border="0" align="center" cellpadding="0" cellspacing="0" id="tablecenter" height="10">

<tr>
	<td align="right">*&nbsp;审核状态:</td>
	<td align="left">
	   <input type="radio" id="audits" name="audits" value="true"/>&nbsp;通过&nbsp;&nbsp;
	   <input type="radio" id="audits" name="audits" value="false"/>&nbsp;拒绝
	   <span id="span_auditsid"></span>
	 </td>
</tr>

<tr>
	<td colspan="2"><textarea rows="4" cols="50" name="audits_reason" id="audits_reason"></textarea>
	<span id="span_audits_reason"></span>
	</td>
</tr>

</table>
<br/>
 <input type="button" name="GoFinish"  value="确定" onClick="f_submit();">&nbsp;
 <input type="button"  value="取消 " onClick="javascript:window.close();">
</form>

<%} %>
</body>

</html>
