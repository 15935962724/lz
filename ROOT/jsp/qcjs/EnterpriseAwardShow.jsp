<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");

int eaid = 0;
if(teasession.getParameter("eaid")!=null && teasession.getParameter("eaid").length()>0){
	eaid = Integer.parseInt(teasession.getParameter("eaid"));
}
EnterpriseAward eaobj = EnterpriseAward.find(eaid);


%>

<html>
<head>
<title>中国第二届（2010年）清真食品穆斯林用品企业评选报名表</title>
<script src="/tea/tea.js" type="text/javascript"></script>

<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<h1>中国第二届（2010年）清真食品穆斯林用品企业评选报名表</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="?" name="form1" method="POST"  >


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
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
  <br/>
  <input type="button" value="　返回　" onclick="window.open('<%=nexturl %>','_self');">
  </form>
</body>
</html>
