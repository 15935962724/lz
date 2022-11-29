<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String province=request.getParameter("province");
if(province!=null&&province.length()>0)
{
	sql.append(" AND province=").append(DbAdapter.cite(province));
}

String region=request.getParameter("region");
if(region!=null&&(region=region.trim()).length()>0)
{
	sql.append(" AND region LIKE ").append(DbAdapter.cite("%"+region+"%"));
}

String telecode=request.getParameter("telecode");
if(telecode!=null&&(telecode=telecode.trim()).length()>0)
{
	sql.append(" AND telecode LIKE ").append(DbAdapter.cite("%"+telecode+"%"));
}

String postcode=request.getParameter("postcode");
if(postcode!=null&&(postcode=postcode.trim()).length()>0)
{
	sql.append(" AND postcode LIKE ").append(DbAdapter.cite("%"+postcode+"%"));
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.region.focus();">

<h1><%=r.getString(teasession._nLanguage, "邮政编码查询")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>
<FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><%=r.getString(teasession._nLanguage, "省")%></td>
<td><select name="province">
<option value="">---------------
<%
java.util.Enumeration e2=Postcode.findProvince();
while(e2.hasMoreElements())
{
	String str=(String)e2.nextElement();
	out.print("<option value="+str);
	if(str.equals(province))
	  out.print(" SELECTED ");
	out.print(">"+str);	
}
%>
</select>
</td>
</tr>
<tr>
<td><%=r.getString(teasession._nLanguage, "地区")%></td>
<td><input name="region" value="<%if(region!=null)out.print(region);%>"></td>
</tr>
<tr>
<td><%=r.getString(teasession._nLanguage, "区号")%></td>
<td><input name="telecode" value="<%if(telecode!=null)out.print(telecode);%>"></td>
</tr>
<tr>
<td><%=r.getString(teasession._nLanguage, "邮编")%></td>
<td><input name="postcode" value="<%if(postcode!=null)out.print(postcode);%>"></td>
</tr>
</table>
<input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>" >

</form>


<%
if(sql.length()>0)
{
	out.print("<h2>结果</h2><table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
	out.print("<tr id=tableonetr><td width=1><td>省");
	out.print("<td>地区");
	out.print("<td>区号");
	out.print("<td>邮编");

	e2=Postcode.find(sql.toString(),0,200);
	for(int i=1;e2.hasMoreElements();i++)
	{
		Postcode obj=(Postcode)e2.nextElement();
		out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
		out.print("<td width=1>"+i);
		out.print("<td>"+obj.getProvince());
		out.print("<td>"+obj.getRegion());
		out.print("<td>"+obj.getTelecode());
		out.print("<td>"+obj.getPostcode());
	}
	out.print("</table>");
}
%>


<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
