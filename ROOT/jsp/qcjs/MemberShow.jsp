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





String nexturl = teasession.getParameter("nexturl");
int mid =0;
if(teasession.getParameter("mid")!=null && teasession.getParameter("mid").length()>0)
{
	mid = Integer.parseInt(teasession.getParameter("mid"));
}
QcMember mobj = QcMember.find(mid);
 
%>

<html>
<head>
<title>会员详细信息</title>
<script src="/tea/tea.js" type="text/javascript"></script>

<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >

<h1>会员详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;姓名：</td>
	       <td nowrap><%=Entity.getNULL(mobj.getName()) %></td>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;性别：</td>
	       <td nowrap>
	       <%
	       	if(mobj.getSex()==0){out.print("男");}else{out.print("女");}
	       %>
				
			</td>
    </tr>
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;驾驶证号：</td>
	       <td nowrap><%=Entity.getNULL(mobj.getCard()) %></td>
	       <td nowrap align="right">电话：</td>
	       <td nowrap><%=Entity.getNULL(mobj.getTelephone()) %></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right">手机：</td>
	       <td nowrap><%=Entity.getNULL(mobj.getMobile()) %></td>
	       <td nowrap align="right">地址：</td>
	       <td nowrap><%=Entity.getNULL(mobj.getAddress()) %></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;报名时间：</td>
	       <td nowrap><%if(mobj.getRegistratime()!=null)out.print(Entity.sdf.format(mobj.getRegistratime())); %></td>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;档案编号：</td>
	       <td nowrap><%=Entity.getNULL(mobj.getArchives()) %></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;出证日期：</td>
	       <td nowrap><%if(mobj.getOuttime()!=null)out.print(Entity.sdf.format(mobj.getOuttime())); %></td>
	       <td nowrap align="right">来源：</td>
	      <td nowrap colspan="2"><%=Entity.getNULL(mobj.getSource()) %></td>
    </tr>

  </table>
  <br/>
<input type="button" value="　返回　" onclick="window.open('<%=nexturl %>','_self');">&nbsp;
</form>
</body>
</html>
