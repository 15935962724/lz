<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="java.math.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();

Communityim obj = Communityim.find(teasession._strCommunity);

String dayfocus=obj.getDayfocus(),report=obj.getReport();
if(request.getMethod().equals("POST"))
{
	dayfocus=request.getParameter("dayfocus");
	report=request.getParameter("report");
	obj.set(dayfocus,report);

	response.sendRedirect("/jsp/info/Succeed.jsp");
	return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="fload();" >

<h1>IM管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="POST" onSubmit="return(submitText(this.dayfocus, '<%=r.getString(teasession._nLanguage,"今日焦点")%>')&&submitText(this.report, '<%=r.getString(teasession._nLanguage,"报告")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"今日焦点")%>:</td>
      <td><input type="text" name="dayfocus" value="<%if(dayfocus!=null)out.print(dayfocus);%>" ></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"报告")%>:</td>
      <td><input type="text" name="report" value="<%if(report!=null)out.print(report);%>" ></td>
    </tr>
      <tr>
         <td nowrap></td>
        <td><input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
        </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


