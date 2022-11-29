<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.qcjs.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession =new TeaSession(request);
String eaid[]=request.getParameterValues("eaid");

response.setHeader("Content-Disposition", "attachment; filename=exp.doc");

%>
<html>
<head>
<base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/"/>

<title>中国第二届（2010年）清真食品穆斯林用品企业评选报名表</title>
</head>
<body bgcolor="#ffffff">
<h1>中国第二届（2010年）清真食品穆斯林用品企业评选报名表</h1>
<%

for(int iiii=0;iiii<eaid.length;iiii++)
{
	EnterpriseAward eaobj = EnterpriseAward.find(Integer.parseInt(eaid[iiii]));


if(iiii>0)out.print("<hr>");
%>
<form action="">

<table border="1" id="tablecenter">
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;企业名称：</td>
	       <td nowrap><%=Entity.getNULL(eaobj.getName()) %></td>
	       <td nowrap align="right">企业地址：</td>
	       <td nowrap><%=Entity.getNULL(eaobj.getAddress()) %></td>
    </tr>
    <tr id=tableonetr> 
	       <td nowrap align="right">企业性质：</td>
	       <td nowrap colspan="3"><%=Entity.getNULL(eaobj.getNatures()) %></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right">企业法人：</td>
	       <td nowrap><%=Entity.getNULL(eaobj.getLegal()) %></td>
	       <td nowrap align="right">联系方式：</td>
	       <td nowrap><%=Entity.getNULL(eaobj.getContact()) %></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right">企业描述：</td>
	       <td nowrap colspan="3"><%=Entity.getNULL(eaobj.getDescription()) %></td>
    </tr>
         <tr id=tableonetr>
	       <td nowrap align="right">备 注：</td>
	       <td nowrap colspan="3"><%=Entity.getNULL(eaobj.getRemarks()) %></td>
	       
    </tr>

  </table>
</form>
<%}%>
 
</body>
</html>
